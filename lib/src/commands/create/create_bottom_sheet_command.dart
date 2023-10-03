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

/// Creates a BottomSheet
/// with all associated files and makes necessary code changes for adding a bottom sheet.
class CreateBottomSheetCommand extends DolphinCommand
    with ProjectStructureValidator {
  @override
  String get description =>
      'Creates a bottom sheet with all associated files and makes necessary code changes for adding a bottom sheet.';

  @override
  String get name => kTemplateNameBottomSheet;

  CreateBottomSheetCommand() {
    argParser
      ..addFlag(
        ksExcludeRoute,
        defaultsTo: false,
        help: kCommandHelpExcludeRoute,
      )
      ..addFlag(
        ksModel,
        defaultsTo: true,
        help: kCommandHelpModel,
      )
      ..addOption(
        ksFeatureName,
        defaultsTo: 'home',
        help: kCommandHelpFeature,
      )
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameBottomSheet],
        defaultsTo: 'empty',
        help: kCommandHelpCreateBottomSheetTemplate,
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
      final bottomSheetName = argResults!.rest.first;
      final featureName = argResults![ksFeatureName];
      final templateType = argResults![ksTemplateType];
      final workingDirectory =
          argResults!.rest.length > 1 ? argResults!.rest[1] : null;
      await configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      processService.formattingLineLength = argResults![ksLineLength];
      await pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);

      await templateService.renderTemplate(
        templateName: name,
        name: bottomSheetName,
        outputPath:
            Directory('${Directory.current.path}/lib/app/$featureName').path,
        featureName: featureName,
        verbose: true,
        excludeRoute: argResults![ksExcludeRoute],
        hasModel: argResults![ksModel],
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
