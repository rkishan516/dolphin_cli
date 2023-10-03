import 'package:dolphin_cli/src/commands/dolphin_command.dart';

import 'create_app_command.dart';
import 'create_bottom_sheet_command.dart';
import 'create_dialog_command.dart';
import 'create_service_command.dart';
import 'create_view_command.dart';
import 'create_widget_command.dart';

/// A command with subcommands that allows you to create / scaffold
/// different parts of the dolphin application
class CreateCommand extends DolphinCommand {
  @override
  String get description =>
      'Provides access to the different creation tools we have for dolphin.';

  @override
  String get name => 'create';

  CreateCommand() {
    addSubcommand(CreateAppCommand());
    addSubcommand(CreateBottomSheetCommand());
    addSubcommand(CreateDialogCommand());
    addSubcommand(CreateServiceCommand());
    addSubcommand(CreateViewCommand());
    addSubcommand(CreateWidgetCommand());
  }
}
