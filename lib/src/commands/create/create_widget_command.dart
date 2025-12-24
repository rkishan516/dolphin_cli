import 'dart:async';
import 'dart:io';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:dolphin_cli/src/services/template_service.dart';
import 'package:dolphin_cli/src/templates/compiled_constants.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:mason_logger/mason_logger.dart';

/// A command that creates a new widget in the specified project directory.
class CreateWidgetCommand extends DolphinCommand
    with ProjectStructureValidator {
  @override
  String get description => 'Creates a widget with their model file.';

  @override
  String get name => kTemplateNameWidget;

  CreateWidgetCommand() {
    argParser
      ..addFlag(ksModel, defaultsTo: true, help: kCommandHelpModel)
      ..addOption(
        ksFeatureName,
        defaultsTo: 'common',
        help: kCommandHelpFeature,
      )
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameWidget],
        defaultsTo: 'empty',
        help: kCommandHelpCreateWidgetTemplate,
      )
      ..addOption(ksConfigPath, abbr: 'c', help: kCommandHelpConfigFilePath)
      ..addOption(ksPath, abbr: 'p', help: kCommandHelpPath)
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
      final widgetName = argResults!.rest.first;
      final featureName = argResults![ksFeatureName];
      final templateType = argResults![ksTemplateType];
      final workingDirectory = argResults!.rest.length > 1
          ? argResults!.rest[1]
          : null;

      // load configuration
      await configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      // override [widgets_path] value on configuration
      configService.setWidgetsPath(argResults![ksPath]);

      processService.formattingLineLength = argResults![ksLineLength];
      await pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);

      await templateService.renderTemplate(
        templateName: name,
        name: widgetName,
        outputPath: Directory(
          '${Directory.current.path}/lib/app/$featureName',
        ).path,
        featureName: featureName,
        verbose: true,
        hasModel: argResults![ksModel],
        templateType: templateType,
      );
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.config.code;
    }
    return ExitCode.success.code;
  }
}
