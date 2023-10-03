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

/// A command that creates a new service in the Dolphin framework.
class CreateServiceCommand extends DolphinCommand
    with ProjectStructureValidator {
  @override
  String get description =>
      'Creates a service with all associated files and makes necessary code changes to include that service.';

  @override
  String get name => kTemplateNameService;

  CreateServiceCommand() {
    argParser
      ..addFlag(
        ksExcludeDependency,
        defaultsTo: false,
        help: kCommandHelpExcludeRoute,
      )
      ..addOption(
        ksFeatureName,
        defaultsTo: 'common',
        help: kCommandHelpFeature,
      )
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameService],
        defaultsTo: 'empty',
        help: kCommandHelpCreateServiceTemplate,
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
      final serviceName = argResults!.rest.first;
      final featureName = argResults![ksFeatureName];
      final templateType = argResults![ksTemplateType];
      final workingDirectory =
          argResults!.rest.length > 1 ? argResults!.rest[1] : null;
      await configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      processService.formattingLineLength = argResults?[ksLineLength];
      await pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);

      await templateService.renderTemplate(
        templateName: name,
        name: serviceName,
        outputPath:
            Directory('${Directory.current.path}/lib/app/$featureName').path,
        featureName: featureName,
        verbose: true,
        excludeRoute: argResults![ksExcludeDependency],
        templateType: templateType,
      );
      await processService.runBuildRunner(workingDirectory: workingDirectory);
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.usage.code;
    }
    return ExitCode.success.code;
  }
}
