import 'dart:async';
import 'dart:io';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:dolphin_cli/src/services/template_service.dart';
import 'package:dolphin_cli/src/templates/compiled_template_map.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:mason_logger/mason_logger.dart';

/// A command class for deleting a service in Dolphin.
class DeleteServiceCommand extends DolphinCommand
    with ProjectStructureValidator {
  @override
  String get description =>
      'Deletes a service with all associated files and makes necessary code changes for deleting a service.';

  @override
  String get name => kTemplateNameService;

  DeleteServiceCommand() {
    argParser
      ..addFlag(
        ksExcludeRoute,
        defaultsTo: false,
        help: kCommandHelpExcludeRoute,
      )
      ..addOption(
        ksFeatureName,
        defaultsTo: 'common',
        help: kCommandHelpFeature,
      )
      ..addOption(ksConfigPath, abbr: 'c', help: kCommandHelpConfigFilePath)
      ..addOption(
        ksLineLength,
        abbr: 'l',
        help: kCommandHelpLineLength,
        valueHelp: '80',
      );
  }

  @override
  Future<int> run() async {
    try {
      final workingDirectory = argResults!.rest.length > 1
          ? argResults!.rest[1]
          : null;
      final serviceName = argResults!.rest.first;
      final featureName = argResults![ksFeatureName];
      await configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      processService.formattingLineLength = argResults?[ksLineLength];
      await pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);
      await _deleteServiceFiles(
        outputPath: Directory(
          '${Directory.current.path}/lib/app/$featureName',
        ).path,
        serviceName: serviceName,
      );
      await processService.runBuildRunner(workingDirectory: workingDirectory);
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.usage.code;
    }
    return ExitCode.success.code;
  }

  /// It deletes the service and test files
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `serviceName` (String): The name of the service to be deleted.
  Future<void> _deleteServiceFiles({
    String? outputPath,
    required String serviceName,
  }) async {
    /// Deleting the service file.
    final templateFiles =
        kCompiledDolphinTemplates['service']!['empty']!.templateFiles;
    for (final file in templateFiles) {
      String filePath = templateService.getTemplateOutputPath(
        inputTemplatePath: file.relativeOutputPath,
        name: serviceName,
        outputFolder: outputPath,
      );
      await fileService.deleteFile(filePath: filePath);
    }
  }
}
