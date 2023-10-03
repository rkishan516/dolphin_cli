import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dolphin_cli/src/commands/dolhphin_cli_command_runner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

abstract class DolphinCommand extends Command<int> {
  // We don't currently have a test involving both a CommandRunner
  // and a Command, so we can't test this getter.
  // coverage:ignore-start
  @override
  DolphinCliCommandRunner? get runner =>
      super.runner as DolphinCliCommandRunner?;
  // coverage:ignore-end

  /// [ArgResults] used for testing purposes only.
  @visibleForTesting
  ArgResults? testArgResults;

  /// [ArgResults] for the current command.
  ArgResults get results => testArgResults ?? argResults!;
}
