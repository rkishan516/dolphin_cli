import 'dart:async';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pub_service.dart';
import 'package:mason_logger/mason_logger.dart';

/// A command that updates the Dolphin CLI tool to the latest version.
class UpgradeCommand extends DolphinCommand {
  @override
  String get description => '''Updates dolphin_cli to latest version.''';

  @override
  String get name => 'upgrade';

  @override
  Future<int> run() async {
    try {
      if (await pubService.hasLatestVersion()) return ExitCode.success.code;

      await processService.runPubGlobalActivate();
      return ExitCode.success.code;
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.usage.code;
    }
  }
}
