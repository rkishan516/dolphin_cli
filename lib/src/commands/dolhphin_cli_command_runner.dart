import 'dart:async';

import 'package:args/args.dart';
import 'package:cli_completion/cli_completion.dart';
import 'package:dolphin_cli/src/commands/bootstrap/bootstrap_command.dart';
import 'package:dolphin_cli/src/commands/compile/compile_command.dart';
import 'package:dolphin_cli/src/commands/create/create_command.dart';
import 'package:dolphin_cli/src/commands/delete/delete_command.dart';
import 'package:dolphin_cli/src/commands/generate/generate_command.dart';
import 'package:dolphin_cli/src/commands/upgrade/upgrade_command.dart';
import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/exceptions/invalid_dolphin_structure_exception.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/pub_service.dart';
import 'package:mason_logger/mason_logger.dart';

const executableName = 'dolphin';
const description = 'The dolphin command-line tool';

class DolphinCliCommandRunner extends CompletionCommandRunner<int> {
  DolphinCliCommandRunner() : super(executableName, description) {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
    );
    argParser.addFlag(
      'verbose',
      abbr: 'v',
      help: 'Noisy logging, including all shell commands executed.',
      callback: (verbose) {
        if (verbose) {
          logger.level = Level.verbose;
        }
      },
    );
    addCommand(CreateCommand());
    addCommand(BootstrapCommand());
    addCommand(DeleteCommand());
    addCommand(CompileCommand());
    addCommand(GenerateCommand());
    addCommand(UpgradeCommand());
  }

  @override
  void printUsage() => logger.info(usage);

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final argResults = parse(args);

      if (argResults[ksVersion]) {
        logger.info(await pubService.getCurrentVersion());
        return ExitCode.success.code;
      }

      await _notifyNewVersionAvailable(arguments: args.toList());
      return await runCommand(argResults) ?? ExitCode.success.code;
    } on InvalidDolphinStructureException catch (e) {
      logger.err(e.message);
      return ExitCode.usage.code;
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.config.code;
    }
  }

  /// Notifies new version of Dolphin CLI is available
  Future<void> _notifyNewVersionAvailable({
    List<String> arguments = const [],
    List<String> ignored = const ['compile', 'upgrade'],
  }) async {
    if (arguments.isEmpty) return;

    for (var arg in ignored) {
      if (arguments.first == arg) return;
    }

    if (await pubService.hasLatestVersion()) return;

    logger.warn('''A new version of Dolphin CLI is available!''');
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    // Fast track completion command
    if (topLevelResults.command?.name == 'completion') {
      await super.runCommand(topLevelResults);
      return ExitCode.success.code;
    }

    // Run the command or show version
    final int? exitCode;
    if (topLevelResults[ksVersion] == true) {
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }

    return exitCode;
  }
}
