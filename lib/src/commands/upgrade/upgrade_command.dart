import 'dart:async';

import 'package:dolphin_cli/src/commands/dolphin_command.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pub_service.dart';
import 'package:mason_logger/mason_logger.dart';

/// A command that updates the Dolphin CLI tool to the latest version.
class UpgradeCommand extends DolphinCommand {
  @override
  String get description => '''Updates Dolphin CLI to latest version.''';

  @override
  String get name => 'upgrade';

  @override
  Future<int> run() async {
    try {
      if (await pubService.hasLatestVersion()) {
        logger.info('Dolphin CLI is already up to date.');
        return ExitCode.success.code;
      }

      final progress = logger.progress('Updating Dolphin CLI');
      await processService.runPubGlobalActivate();
      progress.complete('Successfully updated Dolphin CLI');
      return ExitCode.success.code;
    } catch (e) {
      logger.err(e.toString());
      return ExitCode.usage.code;
    }
  }
}
