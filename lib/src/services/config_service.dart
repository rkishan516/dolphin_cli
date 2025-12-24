import 'dart:convert';

import 'package:dolphin_cli/src/constants/config_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/exceptions/config_file_not_found_exception.dart';
import 'package:dolphin_cli/src/models/config_model.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/path_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scoped_zone/scoped_zone.dart';

/// A reference to a [ConfigService] instance.
final configServiceRef = create(ConfigService.new);

/// The [ConfigService] instance available in the current zone.
ConfigService get configService => read(configServiceRef);

/// Handles app configuration of dolphin cli
class ConfigService {
  /// Default config map used to compare and replace with custom values.
  final Map<String, dynamic> _defaultConfig = Config().toJson();

  /// Custom config used to store custom values read from file.
  Config _customConfig = Config();

  bool _hasCustomConfig = false;

  bool get hasCustomConfig => _hasCustomConfig;

  /// Relative services path for import statements.
  String get serviceImportPath => _customConfig.servicesPath;

  /// Relative path where services will be genereated.
  String get servicePath => _customConfig.servicesPath;

  /// Relative bottom sheet path for import statements.
  String get bottomSheetsPath => _customConfig.bottomSheetsPath;

  /// Relative path where dialogs will be genereated.
  String get dialogsPath => _customConfig.dialogsPath;

  /// File path where DolphinApp is setup.
  String get dolphinAppFilePath => _customConfig.dolphinAppFilePath;

  /// Relative views path for import statements.
  String get viewImportPath => _customConfig.viewsPath;

  /// Relative path where views and viewmodels will be genereated.
  String get viewPath => _customConfig.viewsPath;

  /// Relative path where widgets will be genereated.
  String get widgetPath => _customConfig.widgetsPath;

  /// Returns int value for line length when format code.
  int get lineLength => _customConfig.lineLength;

  /// Finds configuration file and loads it into memory.
  ///
  /// Generally used when creating an app to determine the configuration to
  /// export to the project.
  Future<void> findAndLoadConfigFile({String? configFilePath}) async {
    try {
      final configPath = await resolveConfigFile(
        configFilePath: configFilePath,
      );

      await loadConfig(configPath);
    } on ConfigFileNotFoundException catch (e) {
      if (e.shouldHaltCommand) rethrow;

      logger.detail(e.message);
    } catch (e) {
      logger.err(e.toString());
    }
  }

  /// Composes configuration file and loads it into memory.
  ///
  /// Generally used to load the configuration file at root of the project.
  Future<void> composeAndLoadConfigFile({
    String? configFilePath,
    String? projectPath,
  }) async {
    try {
      final configPath = await composeConfigFile(
        configFilePath: configFilePath,
        projectPath: projectPath,
      );

      await loadConfig(configPath);
    } on ConfigFileNotFoundException catch (e) {
      if (e.shouldHaltCommand) rethrow;
    } catch (e) {
      logger.err(e.toString());
    }
  }

  /// Resolves configuration file path.
  ///
  /// Looks for the configuration file in different locations depending their
  /// priorities. When a configuration file is find, the path of the file is
  /// returned. Otherwise, null is returned.
  ///
  /// Locations sorted by priority.
  ///   - $path
  ///   - $XDG_CONFIG_HOME/dolphin/dolphin.json
  @visibleForTesting
  Future<String> resolveConfigFile({String? configFilePath}) async {
    if (configFilePath != null) {
      if (!await fileService.fileExists(filePath: configFilePath)) {
        throw ConfigFileNotFoundException(
          kConfigFileNotFoundRetry,
          shouldHaltCommand: true,
        );
      }

      return configFilePath;
    }

    try {
      if (await fileService.fileExists(
        filePath: '${pathService.configHome.path}/dolphin/$kConfigFileName',
      )) {
        return '${pathService.configHome.path}/dolphin/$kConfigFileName';
      }
    } on StateError catch (_) {
      // This error is Thrown when HOME environment variable is not set.
    }

    throw ConfigFileNotFoundException(kConfigFileNotFound);
  }

  /// Returns configuration file path.
  ///
  /// When configFilePath is NOT null should returns configFilePath unless the
  /// file does NOT exists where should throw a ConfigFileNotFoundException.
  ///
  /// When configFilePath is null should returns [kConfigFileName] or with the
  /// []projectPath] included if it was passed through arguments.
  @visibleForTesting
  Future<String> composeConfigFile({
    String? configFilePath,
    String? projectPath,
  }) async {
    if (configFilePath != null) {
      if (await fileService.fileExists(filePath: configFilePath)) {
        return configFilePath;
      }

      throw ConfigFileNotFoundException(
        kConfigFileNotFoundRetry,
        shouldHaltCommand: true,
      );
    }

    if (projectPath != null) {
      return '$projectPath/$kConfigFileName';
    }

    return kConfigFileName;
  }

  /// Reads configuration file and sets data to [_customConfig] map.
  @visibleForTesting
  Future<void> loadConfig(String configFilePath) async {
    try {
      final data = await fileService.readFileAsString(filePath: configFilePath);
      _customConfig = Config.fromJson(jsonDecode(data));
      _hasCustomConfig = true;
      _sanitizeCustomConfig();
    } on FormatException {
      logger.warn(kConfigFileMalformed);
    } catch (e) {
      logger.err(e.toString());
    }
  }

  /// Replaces the default configuration in [path] by custom configuration
  /// available at [customConfig].
  ///
  /// If [hasCustomConfig] is false, returns [path] without modifications.
  String replaceCustomPaths(String path) {
    if (!hasCustomConfig) return path;

    final customConfig = _customConfig.toJson();
    String customPath = path;

    for (var k in _defaultConfig.keys) {
      // Avoid trying to replace non path values like v1 or lineLength
      if (!k.contains('path')) continue;

      if (customPath.contains(_defaultConfig[k])) {
        customPath = customPath.replaceFirst(
          _defaultConfig[k],
          customConfig[k],
        );
        break;
      }
    }

    return customPath;
  }

  /// Sanitizes the [path] removing [find].
  ///
  /// Generally used to remove unnecessary parts of the path as {lib} or {test}.
  @visibleForTesting
  String sanitizePath(String path, [String find = 'lib/']) {
    if (!path.startsWith(find)) return path;

    return path.replaceFirst(find, '');
  }

  /// Sanitizes [_customConfig] to remove unnecessary {lib} or {test} from paths.
  ///
  /// Warns the user if the custom config has deprecated path parts.
  void _sanitizeCustomConfig() {
    final sanitizedConfig = _customConfig.copyWith(
      dolphinAppFilePath: sanitizePath(_customConfig.dolphinAppFilePath),
      servicesPath: sanitizePath(_customConfig.servicesPath),
      viewsPath: sanitizePath(_customConfig.viewsPath),
    );

    if (_customConfig == sanitizedConfig) return;

    logger.warn(kDeprecatedPaths);

    _customConfig = sanitizedConfig;
  }

  /// Exports custom config as a formatted Json String.
  String exportConfig() {
    return const JsonEncoder.withIndent('    ').convert(_customConfig.toJson());
  }

  /// Overrides [widgets_path] value on configuration.
  void setWidgetsPath(String? path) {
    _customConfig = _customConfig.copyWith(
      widgetsPath: path ?? _customConfig.widgetsPath,
    );
  }
}
