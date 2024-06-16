import 'dart:io';

import 'package:dolphin_cli/src/exceptions/invalid_dolphin_structure_exception.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import 'package:dolphin_cli/src/constants/message_constants.dart';

@internal
mixin ProjectStructureValidator {
  /// Returns true if the cli is running from the root of a flutter
  /// or dart project
  Future<bool> _isProjectRoot({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final pubspecPath = 'pubspec.yaml';
    return File(
      hasOutputPath ? path.join(outputPath, pubspecPath) : pubspecPath,
    ).exists();
  }

  /// Checks if the current project aligns with the dolphin application structure
  /// to allow for scaffolding to work properly
  Future<bool> _isDolphinApplication({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final appPath = configService.dolphinAppFilePath;

    return File(hasOutputPath
            ? path.join(outputPath, 'lib', appPath)
            : path.join('lib', appPath))
        .exists();
  }

  /// Validates structure and throws exception message when not valid.
  Future<void> validateStructure({String? outputPath}) async {
    // Check if we are at the root of the project. If not, exit gracefully
    if (!(await _isProjectRoot(outputPath: outputPath))) {
      throw InvalidDolphinStructureException(kInvalidRootDirectory);
    }

    if (!(await _isDolphinApplication(outputPath: outputPath))) {
      throw InvalidDolphinStructureException(kInvalidDolphinStructure);
    }
  }
}
