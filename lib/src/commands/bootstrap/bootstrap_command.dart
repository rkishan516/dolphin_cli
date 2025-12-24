import 'dart:async';
import 'dart:io';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/config_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:dolphin_cli/src/services/template_service.dart';
import 'package:dolphin_cli/src/templates/compiled_constants.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:mason_logger/mason_logger.dart';

/// Creates a Dolphin application
/// with all the basics setup.
class BootstrapCommand extends DolphinCommand {
  @override
  String get description => 'Convert basic flutter app to Dolphin application';

  @override
  String get name => kTemplateNameBootstrap;

  BootstrapCommand() {
    argParser
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameApp],
        defaultsTo: 'mobile',
        help: kCommandHelpCreateAppTemplate,
      )
      ..addOption(ksConfigPath, abbr: 'c', help: kCommandHelpConfigFilePath)
      ..addOption(
        ksLineLength,
        abbr: 'l',
        help: kCommandHelpLineLength,
        valueHelp: '80',
      )
      ..addOption(
        ksBackend,
        help: kCommandHelpBackend,
        allowed: _backendFrameworks,
      );
  }
  final _backendFrameworks = ['firebase', 'supabase', 'appwrite'];

  @override
  Future<int> run() async {
    try {
      await configService.findAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
      );

      final workingDirectory =
          argResults!.rest.firstOrNull ?? Directory.current.path;
      final appName = workingDirectory.split('/').last;
      final templateType = argResults![ksTemplateType];
      String? backend = argResults![ksBackend] as String?;

      logger.info('Adding 🐬');

      await templateService.renderTemplate(
        templateName: kTemplateNameApp,
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
            await _initialiseAppwrite(workingDirectory: workingDirectory);
            break;
          }
        case 'firebase':
          {
            await _initialiseFirebase(workingDirectory: workingDirectory);
            break;
          }
        case 'supabase':
          {
            await _initialiseSupabase(workingDirectory: workingDirectory);
            break;
          }
        default:
      }

      await processService.runBuildRunner(workingDirectory: workingDirectory);
      await processService.runFormat(appName: workingDirectory);
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.usage.code;
    }
    return ExitCode.success.code;
  }

  /// Add appwrite to project
  Future<void> _initialiseAppwrite({required String workingDirectory}) async {
    const packageName = 'appwrite';
    await processService.runPubAdd(
      appName: workingDirectory,
      packageName: packageName,
    );
    await templateService.renderTemplate(
      templateName: kTemplateNameAppWrite,
      name: packageName,
      outputPath: Directory('$workingDirectory/lib/app/common/services/').path,
      verbose: true,
      templateType: kCompiledTemplateTypes[kTemplateNameAppWrite]!.first,
    );
  }

  /// Add firebase to project
  Future<void> _initialiseFirebase({required String workingDirectory}) async {
    await processService.runPubAdd(
      packageName: 'firebase_core',
      additionalPackages: [
        'cloud_firestore',
        'cloud_functions',
        'firebase_auth',
        'firebase_storage',
      ],
    );

    await templateService.renderTemplate(
      templateName: kTemplateNameFirebase,
      name: 'firebase',
      outputPath: Directory('$workingDirectory/lib/app/common/services/').path,
      verbose: true,
      templateType: kCompiledTemplateTypes[kTemplateNameFirebase]!.first,
    );
  }

  /// Add supabase to project
  Future<void> _initialiseSupabase({required String workingDirectory}) async {
    const packageName = 'supabase_flutter';

    await processService.runPubAdd(
      appName: workingDirectory,
      packageName: packageName,
    );

    await templateService.renderTemplate(
      templateName: kTemplateNameSupabase,
      name: 'supabase',
      outputPath: Directory('$workingDirectory/lib/app/common/services/').path,
      verbose: true,
      templateType: kCompiledTemplateTypes[kTemplateNameSupabase]!.first,
    );
  }

  /// Replaces configuration file in the project created.
  ///
  /// If has NO custom config, does nothing.
  void _replaceConfigFile({required String appName}) {
    if (!configService.hasCustomConfig) return;

    File(
      '$appName/$kConfigFileName',
    ).writeAsStringSync(configService.exportConfig());
  }
}
