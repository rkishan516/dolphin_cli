import 'dart:async';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
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
      ..addOption(ksConfigPath, abbr: 'c', help: kCommandHelpConfigFilePath)
      ..addOption(ksAppDescription, help: kCommandHelpAppDescription)
      ..addOption(ksAppOrganization, help: kCommandHelpAppOrganization)
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
      final workingDirectory = argResults!.rest.first;

      processService.formattingLineLength = argResults![ksLineLength];
      await processService.runCreateApp(
        name: workingDirectory,
        description: argResults![ksAppDescription],
        organization: argResults![ksAppOrganization],
        platforms: argResults![ksAppPlatforms],
      );

      if (argResults![ksAppDescription] != null) {
        templateHelper.packageDescription = argResults![ksAppDescription];
      }

      final bootstrapResponse = await runner?.run([
        kTemplateNameBootstrap,
        ...argResults!.arguments.where(
          (arg) =>
              !arg.contains(ksAppOrganization) &&
              !arg.contains(ksAppDescription) &&
              !arg.contains(ksAppPlatforms),
        ),
      ]);

      if (bootstrapResponse != null &&
          bootstrapResponse != ExitCode.success.code) {
        return bootstrapResponse;
      }

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
    final progress = logger.progress('Cleaning project...');

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

    progress.complete('Project cleaned.');
  }
}
