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

/// A command that deletes a view from the project's directory structure.
class DeleteViewCommand extends DolphinCommand with ProjectStructureValidator {
  @override
  String get description =>
      'Deletes a view with all associated files and makes necessary code changes for deleting a view.';

  @override
  String get name => kTemplateNameView;

  DeleteViewCommand() {
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
      final viewName = argResults!.rest.first;
      final featureName = argResults![ksFeatureName];
      await configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      processService.formattingLineLength = argResults?[ksLineLength];
      await pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);
      await _deleteViewFiles(
          outputPath:
              Directory('${Directory.current.path}/lib/app/$featureName').path,
          viewName: viewName);
      await processService.runBuildRunner(workingDirectory: workingDirectory);
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.config.code;
    }
    return ExitCode.success.code;
  }

  /// It deletes the view and test files
  ///
  /// Args:
  ///
  ///   `outputPath` (String): The path to the output folder.
  ///
  ///   `viewName` (String): The name of the view.
  Future<void> _deleteViewFiles(
      {String? outputPath, required String viewName}) async {
    // /// Deleting the view folder.
    final templateFiles =
        kCompiledDolphinTemplates['view']!['empty']!.templateFiles;
    for (final file in templateFiles) {
      String filePath = templateService.getTemplateOutputPath(
        inputTemplatePath: file.relativeOutputPath,
        name: viewName,
        outputFolder: outputPath,
      );
      await fileService.deleteFile(filePath: filePath);
    }
  }
}
