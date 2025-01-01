import 'dart:io';

import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/exceptions/invalid_dolphin_structure_exception.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/path_service.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:dolphin_cli/src/services/template_service.dart';
import 'package:dolphin_cli/src/templates/compiled_template_map.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:dolphin_cli/src/templates/template_helper.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recase/recase.dart';
import 'package:scoped_zone/scoped_zone.dart';
import 'package:test/test.dart';

import '../../helpers/mock_services.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(File('test'));
    registerFallbackValue(FileModificationType.Append);
  });
  group(TemplateService, () {
    late Logger logger;
    late FileService fileService;
    late PubspecService pubspecService;
    late ConfigService configService;
    late ProcessService processService;

    setUp(() async {
      logger = MockLoggerService();
      fileService = MockFileService();
      pubspecService = MockPubSpecService();
      configService = MockConfigService();
      processService = MockProcessService();
    });

    void testWithOverrides<T>(Object? description, T Function() body) {
      test(
        description,
        () => runScoped(
          body,
          values: {
            templateServiceRef,
            templateHelperRef,
            pathServiceRef,
            processServiceRef.overrideWith(() => processService),
            configServiceRef.overrideWith(() => configService),
            pubspecServiceRef.overrideWith(() => pubspecService),
            fileServiceRef.overrideWith(() => fileService),
            loggerRef.overrideWith(() => logger),
          },
        ),
      );
    }

    group('renderContentForTemplate', () {
      for (var testCase in [
        (
          description: 'when feature name is given',
          featureName: 'auth',
        ),
        (
          description: 'when feature name is not given',
          featureName: null,
        ),
      ]) {
        testWithOverrides(
            '${testCase.description} and content with string that has required all replaceable names, should return string with those values replaced',
            () {
          when(() => pubspecService.getPackageName).thenReturn('app');
          when(() => configService.serviceImportPath).thenReturn('services');
          when(() => configService.viewImportPath).thenReturn('presentation');
          final content = '''
        {{viewName}}
        {{viewNameSnake}}
        {{viewFileName}}
        {{viewFileNameWithoutExtension}}
        {{notifierName}}
        {{notifierProviderName}}
        {{notifierFileName}}
        {{viewFolderName}}
        {{featureName}}
    ''';
          final expected = '''
        NewView
        new_view
        new.dart
        new_view
        NewNotifier
        newNotifierProvider
        new_notifier.dart
        new
        ${testCase.featureName ?? 'home'}
    ''';

          final result = templateService.renderContentForTemplate(
            content: content,
            templateName: kTemplateNameView,
            name: 'new',
            featureName: testCase.featureName,
          );

          expect(result, expected);
        });
      }
    });

    group('performFileModification', () {
      setUp(() {
        when(() => pubspecService.getPackageName).thenReturn('app');
        when(() => configService.serviceImportPath).thenReturn('services');
        when(() => configService.viewImportPath).thenReturn('presentation');
      });
      for (final testCase in [
        (
          description:
              'given file content with `TEST` identifier only, Should return `TEST` and template in different lines',
          modificationTemplate: 'MaterialRoute(page: {{viewName}})',
          name: 'details',
          expectedResult: 'TEST\nMaterialRoute(page: DetailsView)',
        ),
        (
          description:
              'Given modificationTemplate with $kTemplatePropertyViewFolderName and $kTemplatePropertyViewFileName and name helloTest'
              ' Should return snake_case hello_test hello_test.dart',
          modificationTemplate:
              '{{$kTemplatePropertyViewFolderName}} {{$kTemplatePropertyViewFileName}}',
          name: 'helloTest',
          expectedResult: 'TEST\nhello_test hello_test.dart',
        )
      ]) {
        testWithOverrides(testCase.description, () {
          final result = templateService.templateModificationFileContent(
            fileContent: 'TEST',
            modificationTemplate: testCase.modificationTemplate,
            modificationIdentifier: 'TEST',
            name: testCase.name,
            templateName: kTemplateNameView,
          );

          expect(result, testCase.expectedResult);
        });
      }
    });

    group('getTemplateOutputPath', () {
      setUp(() {
        when(() => pubspecService.getPackageName).thenReturn('app');
        when(() => configService.serviceImportPath).thenReturn('services');
        when(() => configService.viewImportPath).thenReturn('presentation');
      });

      for (final testCase in [
        (
          inputTemplatePath: 'generic/generic.dart',
          expectedPath: 'hello_test/hello_test.dart',
          outputFolder: null,
        ),
        (
          inputTemplatePath: 'generic/generic.dart.stub',
          expectedPath: 'hello_test/hello_test.dart',
          outputFolder: null,
        ),
        (
          inputTemplatePath: 'generic/generic.dart.stub',
          expectedPath: 'test/hello_test/hello_test.dart',
          outputFolder: 'test',
        )
      ]) {
        testWithOverrides(
            'when given a path ${testCase.inputTemplatePath} with viewName helloTest and outputPath ${testCase.outputFolder}, should return ${testCase.expectedPath}',
            () {
          when(() =>
                  configService.replaceCustomPaths(testCase.inputTemplatePath))
              .thenReturn(testCase.inputTemplatePath);

          final result = templateService.getTemplateOutputPath(
            inputTemplatePath: testCase.inputTemplatePath,
            name: 'helloTest',
            outputFolder: testCase.outputFolder,
          );
          expect(result, testCase.expectedPath);
        });
      }
    });

    testWithOverrides(
        'writeOutTemplateFiles given templateName view, should write 3 files to the fileSystem',
        () async {
      when(() => pubspecService.getPackageName).thenReturn('app');
      when(() => configService.serviceImportPath).thenReturn('services');
      when(() => configService.viewImportPath).thenReturn('presentation');
      when(() => configService.replaceCustomPaths(any()))
          .thenReturn('state/generic_view_state.dart.stub');
      when(
        () => fileService.writeStringFile(
          file: any(named: 'file'),
          fileContent: any(named: 'fileContent'),
          verbose: any(named: 'verbose'),
        ),
      ).thenAnswer((i) async => {});

      await templateService.writeOutTemplateFiles(
        template:
            kCompiledDolphinTemplates[kTemplateNameView]![kTemplateTypeEmpty]!,
        templateName: kTemplateNameView,
        name: 'Test',
      );

      verify(
        () => fileService.writeStringFile(
          file: any(named: 'file'),
          fileContent: any(named: 'fileContent'),
          verbose: any(named: 'verbose'),
        ),
      ).called(3);
    });

    group('modifyExistingFiles', () {
      setUp(() {
        when(() => pubspecService.getPackageName).thenReturn('app');
        when(() => configService.serviceImportPath).thenReturn('services');
        when(() => configService.viewImportPath).thenReturn('presentation');
        when(() => configService.replaceCustomPaths(any()))
            .thenReturn('./routes/notifiers/app_router.dart');
        when(() => fileService.fileExists(filePath: any(named: 'filePath')))
            .thenAnswer((i) async => true);
        when(
          () => fileService.readFileAsString(filePath: any(named: 'filePath')),
        ).thenAnswer((i) async => '');
        when(() => processService.runFormat(appName: any(named: 'appName')))
            .thenAnswer((i) async => {});
        when(
          () => fileService.writeStringFile(
            file: any(named: 'file'),
            fileContent: any(named: 'fileContent'),
            verbose: true,
            type: FileModificationType.Modify,
            verboseMessage: any(named: 'verboseMessage'),
          ),
        ).thenAnswer((i) async => '');
      });
      testWithOverrides(
          'Given the view template with a modification file for routes/notifiers/app_router.dart\n'
          'should check if the file exists\n'
          'should get file data if it exist', () async {
        await templateService.modifyExistingFiles(
          template: kCompiledDolphinTemplates[kTemplateNameView]![
              kTemplateTypeEmpty]!,
          templateName: kTemplateNameView,
          name: 'test',
        );

        verify(
          () => fileService.fileExists(
              filePath: './routes/notifiers/app_router.dart'),
        ).called(3);

        verify(() =>
                fileService.readFileAsString(filePath: any(named: 'filePath')))
            .called(3);
      });

      testWithOverrides(
          'given the view template with a modification file for routes/notifiers/app_router.dart and outputPath test, should check if the file exists in test',
          () async {
        await templateService.modifyExistingFiles(
          template: kCompiledDolphinTemplates[kTemplateNameView]![
              kTemplateTypeEmpty]!,
          templateName: kTemplateNameView,
          name: 'xyz',
          outputPath: 'test',
        );
        verify(
          () => fileService.fileExists(
            filePath: 'test/./routes/notifiers/app_router.dart',
          ),
        ).called(3);
      });

      testWithOverrides(
          'Given the view template with a modification file for lib/app/app.dart, if the file does not exist, should throw the InvalidDolphinStructure message',
          () async {
        when(() => fileService.fileExists(filePath: any(named: 'filePath')))
            .thenAnswer((i) async => false);

        expect(
            () async => await templateService.modifyExistingFiles(
                  template: kCompiledDolphinTemplates[kTemplateNameView]![
                      kTemplateTypeEmpty]!,
                  templateName: kTemplateNameView,
                  name: 'details',
                ),
            throwsA(
              predicate(
                (e) =>
                    e is InvalidDolphinStructureException &&
                    e.message == kInvalidDolphinStructureAppFile,
              ),
            ));
      });
    });

    group('renderTemplate when called with template view and excludeRoutes',
        () {
      setUp(() {
        when(() => pubspecService.getPackageName).thenReturn('app');
        when(() => configService.serviceImportPath).thenReturn('services');
        when(() => configService.viewImportPath).thenReturn('presentation');
        when(() => configService.replaceCustomPaths(any()))
            .thenReturn('routes/notifiers/app_router.dart');
        when(() => fileService.fileExists(filePath: any(named: 'filePath')))
            .thenAnswer((i) async => true);
        when(
          () => fileService.readFileAsString(filePath: any(named: 'filePath')),
        ).thenAnswer((i) async => '');

        when(
          () => fileService.writeStringFile(
            file: any(named: 'file'),
            fileContent: any(named: 'fileContent'),
            verbose: any(named: 'verbose'),
            type: any(named: 'type'),
            verboseMessage: any(named: 'verboseMessage'),
          ),
        ).thenAnswer((i) async => '');

        when(() => processService.runFormat(appName: any(named: 'appName')))
            .thenAnswer((i) async => {});
      });
      testWithOverrides(
          'should not check if any file exists for file modification',
          () async {
        await templateService.renderTemplate(
          templateName: kTemplateNameView,
          excludeRoute: true,
          name: 'xyz',
          templateType: 'empty',
        );

        verifyNever(
            () => fileService.fileExists(filePath: any(named: 'filePath')));
      });

      testWithOverrides('should check if file exists for file modification',
          () async {
        await templateService.renderTemplate(
          templateName: kTemplateNameView,
          excludeRoute: false,
          name: 'xyz',
          templateType: 'empty',
        );

        verify(() => fileService.fileExists(filePath: any(named: 'filePath')))
            .called(3);
      });
    });

    group('getTemplateRenderData', () {
      setUp(() {
        when(() => pubspecService.getPackageName).thenReturn('app');
        when(() => configService.serviceImportPath).thenReturn('services');
        when(() => configService.viewImportPath).thenReturn('presentation');
      });
      testWithOverrides(
          'when given renderTemplates with no values and templateName dolphin, should throw exception',
          () {
        expect(
          () => templateService.getTemplateRenderData(
              templateName: 'dolphin', testRenderFunctions: {}, name: ''),
          throwsA(
            predicate((e) => e is Exception),
          ),
        );
      });
      testWithOverrides(
          'when given renderTemplate snakeCase and templateName snakeCase, should convert the property to snake_case',
          () {
        final result = templateService.getTemplateRenderData(
          templateName: 'snakeCase',
          name: 'dolphinCli',
          testRenderFunctions: {
            'snakeCase': (
              ReCase recaseValue, {
              String? featureName,
            }) =>
                {
                  'name': recaseValue.snakeCase,
                }
          },
        );

        expect(result['name'], 'dolphin_cli');
      });
    });

    group('compileTemplateInformation', () {
      testWithOverrides('should be written in compiled files', () async {
        when(
          () => fileService.getFoldersInDirectory(
            directoryPath: '${Directory.current.path}/lib/src/templates',
          ),
        ).thenAnswer((i) async => ['app', 'appwrite']);
        when(
          () => fileService.getFoldersInDirectory(directoryPath: 'app'),
        ).thenAnswer((i) async => ['mobile']);
        when(
          () => fileService.getFoldersInDirectory(directoryPath: 'appwrite'),
        ).thenAnswer((i) async => ['mini']);

        when(
          () => fileService.getFilesInDirectory(
            directoryPath:
                '${Directory.current.path}/lib/src/templates/app/mobile',
          ),
        ).thenAnswer((i) async => [File('pubspec.yaml.stub')]);

        when(
          () => fileService.writeStringFile(
            file: any(named: 'file'),
            fileContent: any(named: 'fileContent'),
          ),
        ).thenAnswer((i) async => {});
        when(
          () => fileService.getFilesInDirectory(
            directoryPath:
                '${Directory.current.path}/lib/src/templates/appwrite/mini',
          ),
        ).thenAnswer((i) async => [File('appwrite_service.dart.stub')]);

        await templateService.compileTemplateInformation();

        for (final expectedFileToWritten in [
          'compiled_constants.dart',
          'compiled_template_map.dart',
          'compiled_templates.dart'
        ]) {
          verify(
            () => fileService.writeStringFile(
              file: any(
                named: 'file',
                that: predicate(
                  (e) =>
                      e is File &&
                      pathService.basename(e.path) == expectedFileToWritten,
                ),
              ),
              fileContent: any(named: 'fileContent'),
            ),
          ).called(1);
        }
      });
    });
  });
}
