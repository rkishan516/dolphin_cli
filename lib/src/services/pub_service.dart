import 'dart:io';

import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/config_constants.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:scoped_zone/scoped_zone.dart';

/// A reference to a [PubService] instance.
final pubServiceRef = create(PubService.new);

/// The [PubService] instance available in the current zone.
PubService get pubService => read(pubServiceRef);

/// Provides functionality to interact with pacakges
class PubService {
  final _pubUpdater = PubUpdater();

  /// Returns current `dolphin_cli` version installed on the system.
  Future<String> getCurrentVersion() async {
    String version = currentVersionNotAvailable;

    final packages = await processService.runPubGlobalList();
    for (var package in packages) {
      if (!package.contains(ksDolphinCli)) continue;

      version = package.split(' ').last;
      break;
    }

    return version;
  }

  /// Returns the latest published version of `dolphin_cli` package.
  Future<String> getLatestVersion() async {
    return await _pubUpdater.getLatestVersion(ksDolphinCli);
  }

  /// Checks whether or not has the latest version for `dolphin_cli` package
  /// installed on the system.
  Future<bool> hasLatestVersion() async {
    final currentVersion = await getCurrentVersion();
    if (currentVersion == currentVersionNotAvailable) {
      await update();
      return true;
    }

    return await _pubUpdater.isUpToDate(
      packageName: ksDolphinCli,
      currentVersion: currentVersion,
    );
  }

  /// Updates `dolphin_cli` package on the system.
  Future<ProcessResult> update() async {
    return await _pubUpdater.update(packageName: ksDolphinCli);
  }
}
