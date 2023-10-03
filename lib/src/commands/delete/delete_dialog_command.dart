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

/// A command class for deleting a dialog in Dolphin.
class DeleteDialogCommand extends DolphinCommand
    with ProjectStructureValidator {
  @override
  String get description =>
      'Deletes a dialog with all associated files and makes necessary code changes for deleting a dialog.';

  @override
  String get name => kTemplateNameDialog;

  DeleteDialogCommand() {
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
      ..addOption(
        ksConfigPath,
        abbr: 'c',
        help: kCommandHelpConfigFilePath,
      )
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
      final workingDirectory =
          argResults!.rest.length > 1 ? argResults!.rest[1] : null;
      final dialogName = argResults!.rest.first;
      final featureName = argResults![ksFeatureName];
      await configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      processService.formattingLineLength = argResults?[ksLineLength];
      await pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);
      await _deleteDialog(
          outputPath:
              Directory('${Directory.current.path}/lib/app/$featureName').path,
          dialogName: dialogName);
      await processService.runBuildRunner(workingDirectory: workingDirectory);
    } on PathNotFoundException catch (e) {
      logger.err(e.toString());
      return ExitCode.config.code;
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.usage.code;
    }
    return ExitCode.success.code;
  }

  /// It deletes the dialog files
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `dialogName` (String): The name of the dialog.
  Future<void> _deleteDialog(
      {String? outputPath, required String dialogName}) async {
    /// Deleting the dialog folder.
    final templateFiles =
        kCompiledDolphinTemplates['dialog']!['empty']!.templateFiles;
    for (final file in templateFiles) {
      String filePath = templateService.getTemplateOutputPath(
        inputTemplatePath: file.relativeOutputPath,
        name: dialogName,
        outputFolder: outputPath,
      );
      await fileService.deleteFile(filePath: filePath);
    }
  }
}
