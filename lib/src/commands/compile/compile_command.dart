import 'dart:async';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/services/template_service.dart';
import 'package:mason_logger/mason_logger.dart';

/// The command to run
class CompileCommand extends DolphinCommand {
  @override
  String get description =>
      '''Uses the /templates folder and creates the appropriate template code required for the scaffolding.
      This command is for use during development of the cli, not in its compile form. 
      ''';

  @override
  String get name => 'compile';

  @override
  Future<int> run() async {
    await templateService.compileTemplateInformation();
    return ExitCode.software.code;
  }
}
