import 'dart:convert';
import 'dart:io';

import 'package:dolphin_cli/src/constants/config_constants.dart';
import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/exceptions/config_file_not_found_exception.dart';
import 'package:dolphin_cli/src/models/config_model.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/path_service.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scoped_zone/scoped_zone.dart';
import 'package:test/test.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg;

import '../../helpers/mock_services.dart';

void main() {
  group(ConfigService, () {
    late ConfigService configService;
    late FileService fileService;
    late Logger logger;

    setUp(() {
      configService = ConfigService();
      fileService = MockFileService();
      logger = MockLoggerService();
    });

    T runWithOverrides<T>(T Function() body) {
      return runScoped(
        body,
        values: {
          fileServiceRef.overrideWith(() => fileService),
          configServiceRef.overrideWith(() => configService),
          loggerRef.overrideWith(() => logger),
          pathServiceRef,
        },
      );
    }

    void testWithOverrides<T>(Object? description, T Function() body) {
      test(description, () => runWithOverrides(body));
    }

    final customConfigFilePath =
        '${Directory.current.path}/test/helpers/mock_dolphin_config.json';
    final xdgConfigFilePath = '${xdg.configHome.path}/dolphin/$kConfigFileName';

    final Config customConfig = Config.fromJson({
      'bottom_sheets_path': 'ui',
      'dialogs_path': 'ui',
      'line_length': 100,
      'services_path': 'services/service',
      'dolphin_app_file_path': 'app/main_app.dart',
      'views_path': 'ui',
      'widgets_path': 'ui',
    });

    group('resolveConfigFile when called', () {
      testWithOverrides(
        'with configFilePath should return configFilePath and call fileExist',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => true);

          final path = await configService.resolveConfigFile(
            configFilePath: customConfigFilePath,
          );

          expect(path, customConfigFilePath);
          verify(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).called(1);
        },
      );

      testWithOverrides(
        'with configFilePath and file does not exists should throw ConfigFileNotFoundException with message equal kConfigFileNotFoundRetry and shouldHaltCommand equal true',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => false);

          expect(
            () => configService.resolveConfigFile(
              configFilePath: customConfigFilePath,
            ),
            throwsA(
              predicate(
                (e) =>
                    e is ConfigFileNotFoundException &&
                    e.toString() == kConfigFileNotFoundRetry &&
                    e.shouldHaltCommand == true,
              ),
            ),
          );
        },
      );

      testWithOverrides(
        'without configFilePath should call fileExists on XDG_CONFIG_HOME and return xdgConfigFilePath',
        () async {
          when(
            () => fileService.fileExists(filePath: xdgConfigFilePath),
          ).thenAnswer((i) async => true);

          final path = await configService.resolveConfigFile();

          verify(
            () => fileService.fileExists(filePath: xdgConfigFilePath),
          ).called(1);
          expect(path, xdgConfigFilePath);
        },
      );

      testWithOverrides(
        'without configFilePath and Home environment variable is not set should throw ConfigFileNotFoundException with message equal kConfigFileNotFound and shouldHaltCommand equal false',
        () async {
          when(
            () => fileService.fileExists(filePath: xdgConfigFilePath),
          ).thenThrow(StateError(''));

          await expectLater(
            configService.resolveConfigFile(),
            throwsA(
              predicate(
                (e) =>
                    e is ConfigFileNotFoundException &&
                    e.message == kConfigFileNotFound &&
                    e.shouldHaltCommand == false,
              ),
            ),
          );
        },
      );

      testWithOverrides(
        'without configFilePath and Home environment variable is set should throw ConfigFileNotFoundException with message equal kConfigFileNotFound and shouldHaltCommand equal false',
        () async {
          when(
            () => fileService.fileExists(filePath: xdgConfigFilePath),
          ).thenAnswer((i) async => false);

          await expectLater(
            configService.resolveConfigFile(),
            throwsA(
              predicate(
                (e) =>
                    e is ConfigFileNotFoundException &&
                    e.message == kConfigFileNotFound &&
                    e.shouldHaltCommand == false,
              ),
            ),
          );
        },
      );
    });

    group('composeConfigFile when called', () {
      testWithOverrides(
        'with configFilePath should return configFilePath and should call fileExist on configFilePath',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => true);

          final path = await configService.composeConfigFile(
            configFilePath: customConfigFilePath,
          );

          expect(path, customConfigFilePath);
          verify(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).called(1);
        },
      );

      testWithOverrides(
        'with configFilePath and file does NOT exists should throw ConfigFileNotFoundException with message equal kConfigFileNotFoundRetry and shouldHaltCommand equal true',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => false);

          expect(
            () => configService.composeConfigFile(
              configFilePath: customConfigFilePath,
            ),
            throwsA(
              predicate(
                (e) =>
                    e is ConfigFileNotFoundException &&
                    e.message == kConfigFileNotFoundRetry &&
                    e.shouldHaltCommand == true,
              ),
            ),
          );
        },
      );

      testWithOverrides(
        'without configFilePath should return kConfigFileName',
        () async {
          final path = await configService.composeConfigFile();

          expect(path, kConfigFileName);
        },
      );

      testWithOverrides(
        'without configFilePath and projectPath is NOT null should return kConfigFileName with projectPath',
        () async {
          final projectPath = 'example';

          final path = await configService.composeConfigFile(
            projectPath: projectPath,
          );

          expect(path, '$projectPath/$kConfigFileName');
        },
      );
    });

    group('loadConfig when called', () {
      testWithOverrides(
        'should call readFileAsString on FileService and configs are set',
        () async {
          when(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).thenAnswer((i) async => '{}');

          await configService.loadConfig(customConfigFilePath);

          verify(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).called(1);
          expect(configService.hasCustomConfig, isTrue);
        },
      );

      testWithOverrides('should sanitize path', () async {
        final configToBeSanitize = {'services_path': 'lib/app/services/'};
        when(
          () => fileService.readFileAsString(filePath: customConfigFilePath),
        ).thenAnswer((i) async => jsonEncode(configToBeSanitize));
        when(() => logger.warn(any())).thenAnswer((i) {});

        await configService.loadConfig(customConfigFilePath);

        expect(configService.servicePath, 'app/services/');
      });

      testWithOverrides(
        'if file is malformed should throw FormatException',
        () async {
          when(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).thenAnswer((i) async => '{"services_path": app/services"}');
          when(() => logger.warn(any())).thenAnswer((i) {});

          await configService.loadConfig(customConfigFilePath);

          verify(() => logger.warn(kConfigFileMalformed)).called(1);
        },
      );

      testWithOverrides(
        'if parsing fails for config should throw _TypeError or other error',
        () async {
          when(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).thenAnswer((i) async => '{"services_path": 4}');
          when(() => logger.err(any())).thenAnswer((i) {});

          await configService.loadConfig(customConfigFilePath);

          verify(() => logger.err(any())).called(1);
        },
      );
    });

    group('replaceCustomPaths when called', () {
      testWithOverrides(
        'without custom config should return same path',
        () async {
          final path = 'test/services/service_test.dart.stub';
          when(
            () => fileService.readFileAsString(filePath: path),
          ).thenAnswer((i) async => '{}');

          final customPath = configService.replaceCustomPaths(path);

          expect(customPath, path);
          expect(configService.hasCustomConfig, false);
        },
      );

      testWithOverrides(
        'with custom config should return custom path',
        () async {
          final path = 'test/services/service_test.dart.stub';
          when(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).thenAnswer((i) async => jsonEncode(customConfig.toJson()));

          await configService.loadConfig(customConfigFilePath);
          final customPath = configService.replaceCustomPaths(path);

          expect(configService.hasCustomConfig, true);
          expect(customPath, isNot(path));
          expect(customPath, 'test/services/service/service_test.dart.stub');
        },
      );

      testWithOverrides(
        'with custom dolphin app file path should return full dolphin_app file path from config',
        () async {
          final path = 'app/app.dart';
          when(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).thenAnswer((i) async => jsonEncode(customConfig.toJson()));

          await configService.loadConfig(customConfigFilePath);
          final customPath = configService.replaceCustomPaths(path);

          expect(customPath, isNot(path));
          expect(customPath, 'app/main_app.dart');
        },
      );
    });

    group('sanitizePath', () {
      final testCases = [
        (input: 'lib/src/services', output: 'src/services'),
        (input: 'src/lib/services', output: 'src/lib/services'),
        (input: 'src/services', output: 'src/services'),
      ];
      for (final testCase in testCases) {
        testWithOverrides(
          'with path equals "${testCase.input}" should return "${testCase.output}"',
          () async {
            final importPath = configService.sanitizePath(testCase.input);

            expect(importPath, testCase.output);
          },
        );
      }

      final testCasesWithUpdatedFinder = [
        (input: 'test/services', output: 'services'),
        (input: 'path/to/services', output: 'path/to/services'),
      ];
      for (final testCase in testCasesWithUpdatedFinder) {
        testWithOverrides(
          'with path equals "${testCase.input}" and find equals "test/" should return "${testCase.output}"',
          () async {
            final importPath = configService.sanitizePath(
              testCase.input,
              'test/',
            );

            expect(importPath, testCase.output);
          },
        );
      }
    });

    group('findAndLoadConfigFile when called', () {
      testWithOverrides(
        'with configFilePath should load all configs',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => true);
          when(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).thenAnswer((i) async => jsonEncode(customConfig.toJson()));

          await configService.findAndLoadConfigFile(
            configFilePath: customConfigFilePath,
          );

          verify(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).called(1);
          verify(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).called(1);
          expect(configService.hasCustomConfig, true);
          expect(configService.serviceImportPath, customConfig.servicesPath);
          expect(
            configService.dolphinAppFilePath,
            customConfig.dolphinAppFilePath,
          );
          expect(configService.bottomSheetsPath, customConfig.bottomSheetsPath);
          expect(configService.dialogsPath, customConfig.dialogsPath);
          expect(configService.viewImportPath, customConfig.viewsPath);
          expect(configService.viewPath, customConfig.viewsPath);
          expect(configService.widgetPath, customConfig.widgetsPath);
          expect(configService.lineLength, customConfig.lineLength);
        },
      );

      testWithOverrides(
        'with configFilePath and file does not exist then should throw ConfigFileNotFoundException with message kConfigFileNotFoundRetry',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => false);

          expect(
            () => configService.findAndLoadConfigFile(
              configFilePath: customConfigFilePath,
            ),
            throwsA(
              predicate(
                (e) =>
                    e is ConfigFileNotFoundException &&
                    e.message == kConfigFileNotFoundRetry &&
                    e.shouldHaltCommand == true,
              ),
            ),
          );
        },
      );

      testWithOverrides(
        'with configFilePath but got any other exception should log in error',
        () async {
          final someExceptionMessage = 'FileReadFailure';
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenThrow(Exception(someExceptionMessage));
          when(() => logger.err(any())).thenAnswer((i) {});

          await configService.findAndLoadConfigFile(
            configFilePath: customConfigFilePath,
          );

          verify(() => logger.err(any())).called(1);
        },
      );

      testWithOverrides(
        'without configFilePath and xdgConfigFile does not exist then should catch exception and log in detail',
        () async {
          when(
            () => fileService.fileExists(filePath: xdgConfigFilePath),
          ).thenAnswer((i) async => false);
          when(() => logger.detail(any())).thenAnswer((i) {});

          await configService.findAndLoadConfigFile();

          verify(() => logger.detail(kConfigFileNotFound)).called(1);
        },
      );
    });

    group('composeAndLoadConfigFile when called', () {
      testWithOverrides(
        'with configFilePath should load all configs',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => true);
          when(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).thenAnswer((i) async => jsonEncode(customConfig.toJson()));

          await configService.composeAndLoadConfigFile(
            configFilePath: customConfigFilePath,
          );

          verify(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).called(1);
          verify(
            () => fileService.readFileAsString(filePath: customConfigFilePath),
          ).called(1);
          expect(configService.hasCustomConfig, true);
        },
      );

      testWithOverrides(
        'with configFilePath and file does not exist then should throw ConfigFileNotFoundException with message kConfigFileNotFoundRetry',
        () async {
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenAnswer((i) async => false);

          expect(
            () => configService.composeAndLoadConfigFile(
              configFilePath: customConfigFilePath,
            ),
            throwsA(
              predicate(
                (e) =>
                    e is ConfigFileNotFoundException &&
                    e.message == kConfigFileNotFoundRetry &&
                    e.shouldHaltCommand == true,
              ),
            ),
          );
        },
      );

      testWithOverrides(
        'with configFilePath but got any other exception should log in error',
        () async {
          final someExceptionMessage = 'FileReadFailure';
          when(
            () => fileService.fileExists(filePath: customConfigFilePath),
          ).thenThrow(Exception(someExceptionMessage));
          when(() => logger.err(any())).thenAnswer((i) {});

          await configService.composeAndLoadConfigFile(
            configFilePath: customConfigFilePath,
          );

          verify(() => logger.err(any())).called(1);
        },
      );
    });

    group('setWidgetsPath when called', () {
      testWithOverrides('with given path should update path', () {
        configService.setWidgetsPath('test/app');

        expect(configService.widgetPath, 'test/app');
        expect(configService.widgetPath, isNot(Config().widgetsPath));
      });

      testWithOverrides('without given path should remains same', () {
        configService.setWidgetsPath(null);

        expect(configService.widgetPath, equals(Config().widgetsPath));
      });

      testWithOverrides(
        'without given path after update should remains same',
        () {
          configService.setWidgetsPath('test/app');
          configService.setWidgetsPath(null);

          expect(configService.widgetPath, 'test/app');
          expect(configService.widgetPath, isNot(Config().widgetsPath));
        },
      );
    });

    testWithOverrides('exportConfig when called', () {
      final formattedConfig = configService.exportConfig();
      expect(
        formattedConfig,
        '{\n'
        '    "views_path": "presentation",\n'
        '    "services_path": "services",\n'
        '    "widgets_path": "presentation",\n'
        '    "bottom_sheets_path": "presentation",\n'
        '    "dialogs_path": "presentation",\n'
        '    "dolphin_app_file_path": "app/app.dart",\n'
        '    "line_length": 80\n'
        '}',
      );
    });
  });
}
