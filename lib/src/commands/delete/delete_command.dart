import 'package:dolphin_cli/src/commands/delete/delete_dialog_command.dart';
import 'package:dolphin_cli/src/commands/delete/delete_service_command.dart';
import 'package:dolphin_cli/src/commands/dolphin_command.dart';

import 'delete_view_command.dart';

/// A command with subcommands that allows you to delete
/// different parts of the dolphin application
class DeleteCommand extends DolphinCommand {
  @override
  String get description =>
      'Provides access to the different deletion tools we have for dolphin.';

  @override
  String get name => 'delete';

  DeleteCommand() {
    addSubcommand(DeleteServiceCommand());
    addSubcommand(DeleteViewCommand());
    addSubcommand(DeleteDialogCommand());
  }
}
