import 'dart:async';
import 'dart:io';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/config_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:dolphin_cli/src/services/template_service.dart';
import 'package:dolphin_cli/src/templates/compiled_constants.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:dolphin_cli/src/templates/template_helper.dart';
import 'package:mason_logger/mason_logger.dart';

/// Creates a Dolphin application
/// with all the basics setup.
class CreateAppCommand extends DolphinCommand {
  @override
  String get description =>
      'Creates a Dolphin application with all the basics setup.';

  @override
  String get name => kTemplateNameApp;

  CreateAppCommand() {
    argParser
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameApp],
        defaultsTo: 'mobile',
        help: kCommandHelpCreateAppTemplate,
      )
      ..addOption(
        ksConfigPath,
        abbr: 'c',
        help: kCommandHelpConfigFilePath,
      )
      ..addOption(
        ksAppDescription,
        help: kCommandHelpAppDescription,
      )
      ..addOption(
        ksAppOrganization,
        help: kCommandHelpAppOrganization,
      )
      ..addMultiOption(
        ksAppPlatforms,
        allowed: ['ios', 'android', 'windows', 'linux', 'macos', 'web'],
        help: kCommandHelpAppPlatforms,
      )
      ..addOption(
        ksLineLength,
        abbr: 'l',
        help: kCommandHelpLineLength,
        valueHelp: '80',
      )
      ..addOption(
        ksBackend,
        help: kCommandHelpBackend,
        allowed: ['firebase', 'supabase', 'appwrite'],
      );
  }

  @override
  Future<int> run() async {
    try {
      await configService.findAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
      );

      final workingDirectory = argResults!.rest.first;
      final appName = workingDirectory.split('/').last;
      final templateType = argResults![ksTemplateType];
      final backend = argResults![ksBackend] as String?;

      processService.formattingLineLength = argResults![ksLineLength];
      await processService.runCreateApp(
        name: workingDirectory,
        description: argResults![ksAppDescription],
        organization: argResults![ksAppOrganization],
        platforms: argResults![ksAppPlatforms],
      );

      logger.info('Add Dolphin Magic ... ');

      if (argResults![ksAppDescription] != null) {
        templateHelper.packageDescription = argResults![ksAppDescription];
      }

      await templateService.renderTemplate(
        templateName: name,
        name: appName,
        verbose: true,
        outputPath: workingDirectory,
        templateType: templateType,
      );
      _replaceConfigFile(appName: workingDirectory);
      await processService.runPubGet(appName: workingDirectory);

      await pubspecService.initialise(workingDirectory: workingDirectory);
      switch (backend) {
        case 'appwrite':
          {
            const packageName = 'appwrite';
            await processService.runPubAdd(
              appName: workingDirectory,
              packageName: packageName,
            );
            await templateService.renderTemplate(
              templateName: kTemplateNameAppWrite,
              name: packageName,
              outputPath:
                  Directory('$workingDirectory/lib/app/common/services/').path,
              verbose: true,
              templateType:
                  kCompiledTemplateTypes[kTemplateNameAppWrite]!.first,
            );
            break;
          }
        case 'firebase':
          {
            await processService.runPubAdd(
              packageName: 'firebase_core',
              additionalPackages: [
                'cloud_firestore',
                'cloud_functions',
                'firebase_auth',
                'firebase_storage'
              ],
            );

            await templateService.renderTemplate(
              templateName: kTemplateNameFirebase,
              name: 'firebase',
              outputPath:
                  Directory('$workingDirectory/lib/app/common/services/').path,
              verbose: true,
              templateType:
                  kCompiledTemplateTypes[kTemplateNameFirebase]!.first,
            );

            break;
          }
        case 'supabase':
          {
            const packageName = 'supabase_flutter';

            await processService.runPubAdd(
              appName: workingDirectory,
              packageName: packageName,
            );

            await templateService.renderTemplate(
              templateName: kTemplateNameSupabase,
              name: 'supabase',
              outputPath:
                  Directory('$workingDirectory/lib/app/common/services/').path,
              verbose: true,
              templateType:
                  kCompiledTemplateTypes[kTemplateNameSupabase]!.first,
            );
            break;
          }
        default:
      }

      await processService.runBuildRunner(workingDirectory: workingDirectory);
      await processService.runFormat(appName: workingDirectory);
      await _clean(workingDirectory: workingDirectory);
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.usage.code;
    }
    return ExitCode.success.code;
  }

  /// Cleans the project.
  ///
  ///   - Deletes widget_test.dart file
  ///   - Removes unused imports
  Future<void> _clean({required String workingDirectory}) async {
    logger.info('Cleaning project...');

    // Removes `widget_test` file to avoid failing unit tests on created app
    if (await fileService.fileExists(
      filePath: '$workingDirectory/test/widget_test.dart',
    )) {
      await fileService.deleteFile(
        filePath: '$workingDirectory/test/widget_test.dart',
        verbose: false,
      );
    }

    // Analyze the project and return output lines
    final issues = await processService.runAnalyze(appName: workingDirectory);

    for (var i in issues) {
      if (!i.endsWith('unused_import')) continue;

      final log = i.split(' • ')[2].split(':');

      await fileService.removeLinesOnFile(
        filePath: '$workingDirectory/${log[0]}',
        linesNumber: [int.parse(log[1])],
      );
    }

    logger.info('Project cleaned.');
  }

  /// Replaces configuration file in the project created.
  ///
  /// If has NO custom config, does nothing.
  void _replaceConfigFile({required String appName}) {
    if (!configService.hasCustomConfig) return;

    File('$appName/$kConfigFileName').writeAsStringSync(
      configService.exportConfig(),
    );
  }
}
