import 'dart:async';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:mason_logger/mason_logger.dart';

/// A command that generates code for the Dolphin framework.
class GenerateCommand extends DolphinCommand {
  @override
  String get description =>
      '''Generates the code for the dolphin application if any changes were made.''';

  @override
  String get name => kTemplateNameGenerate;

  GenerateCommand() {
    argParser
      ..addFlag(
        ksDeleteConflictOutputs,
        abbr: 'd',
        defaultsTo: true,
        negatable: true,
        help: kCommandHelpDeleteConflictingOutputs,
      )
      ..addFlag(ksWatch, abbr: 'w', defaultsTo: false, help: kCommandHelpWatch);
  }

  @override
  Future<int> run() async {
    try {
      await processService.runBuildRunner(
        shouldDeleteConflictingOutputs: argResults?[ksDeleteConflictOutputs],
        shouldWatch: argResults?[ksWatch],
      );
      return ExitCode.success.code;
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.config.code;
    }
  }
}
