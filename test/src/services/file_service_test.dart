import 'dart:convert';
import 'dart:io';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';
import 'package:scoped_zone/scoped_zone.dart';
import 'package:test/test.dart';

import '../../helpers/mock_helpers.dart';
import '../../helpers/mock_services.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(FileMode.append);
  });
  group(FileService, () {
    late Logger logger;

    setUp(() async {
      logger = MockLoggerService();
    });

    T runWithOverrides<T>(T Function() body) {
      return runScoped(
        body,
        values: {fileServiceRef, loggerRef.overrideWith(() => logger)},
      );
    }

    void testWithOverrides<T>(Object? description, T Function() body) {
      test(description, () => runWithOverrides(body));
    }

    group('write with', () {
      final testCases = [
        (
          description:
              'file exist without verbose should write content without log',
          fileExist: true,
          verbose: false,
          verboseMessage: null,
          type: FileModificationType.Create,
          forceAppend: false,
        ),
        (
          description:
              'file exist with verbose and verboseMessage should write content with given message',
          verbose: true,
          fileExist: true,
          verboseMessage: 'Hello',
          type: FileModificationType.Create,
          forceAppend: false,
        ),
        (
          description:
              'file exist with verbose and without verboseMessage should write content with operation message',
          verbose: true,
          fileExist: true,
          verboseMessage: null,
          type: FileModificationType.Create,
          forceAppend: false,
        ),
        (
          description:
              'file exist with forceAppend should write content without log',
          fileExist: true,
          verbose: false,
          verboseMessage: null,
          type: FileModificationType.Create,
          forceAppend: true,
        ),
        (
          description:
              'file does not exist with modification type `FileModificationType.Create`',
          fileExist: false,
          verbose: false,
          verboseMessage: null,
          type: FileModificationType.Create,
          forceAppend: true,
        ),
        (
          description:
              'file does not exist with modification type `FileModificationType.Append`',
          fileExist: false,
          verbose: false,
          verboseMessage: null,
          type: FileModificationType.Append,
          forceAppend: true,
        ),
      ];
      group('writeStringFile when', () {
        for (final testCase in testCases) {
          testWithOverrides(testCase.description, () async {
            final file = MockFile();
            when(
              () => file.exists(),
            ).thenAnswer((_) async => testCase.fileExist);
            when(
              () => file.create(recursive: true),
            ).thenAnswer((_) async => file);
            when(
              () => file.writeAsString(any(), mode: any(named: 'mode')),
            ).thenAnswer((_) async => file);

            when(() => logger.detail(any())).thenAnswer((i) {});
            when(() => logger.warn(any())).thenAnswer((i) {});

            await fileService.writeStringFile(
              file: file,
              verbose: testCase.verbose,
              verboseMessage: testCase.verboseMessage,
              fileContent: 'test content',
              type: testCase.type,
              forceAppend: testCase.forceAppend,
            );

            verify(
              () => file.writeAsString(
                'test content',
                mode: testCase.forceAppend ? FileMode.append : FileMode.write,
              ),
            ).called(1);

            void verboseLoggerCallback() => logger.detail(
              testCase.verboseMessage ??
                  '$file operated with ${testCase.type.name}',
            );

            testCase.verbose
                ? verify(verboseLoggerCallback).called(1)
                : verifyNever(verboseLoggerCallback);

            void fileCreationLoggerCallback() => logger.warn(any());

            !testCase.fileExist && testCase.type != FileModificationType.Create
                ? verify(fileCreationLoggerCallback).called(1)
                : verifyNever(fileCreationLoggerCallback);

            void fileCreationCallback() => file.create(recursive: true);

            testCase.fileExist
                ? verifyNever(fileCreationCallback)
                : verify(fileCreationCallback).called(1);
          });
        }
      });

      group('writeDataFile when', () {
        for (final testCase in testCases) {
          testWithOverrides(testCase.description, () async {
            final file = MockFile();
            when(
              () => file.exists(),
            ).thenAnswer((_) async => testCase.fileExist);
            when(
              () => file.create(recursive: true),
            ).thenAnswer((_) async => file);
            when(
              () => file.writeAsBytes(any(), mode: any(named: 'mode')),
            ).thenAnswer((_) async => file);

            when(() => logger.detail(any())).thenAnswer((i) {});
            when(() => logger.warn(any())).thenAnswer((i) {});

            final content = utf8.encode('test content');

            await fileService.writeDataFile(
              file: file,
              verbose: testCase.verbose,
              verboseMessage: testCase.verboseMessage,
              fileContent: content,
              type: testCase.type,
              forceAppend: testCase.forceAppend,
            );

            verify(
              () => file.writeAsBytes(
                content,
                mode: testCase.forceAppend ? FileMode.append : FileMode.write,
              ),
            ).called(1);

            void verboseLoggerCallback() => logger.detail(
              testCase.verboseMessage ??
                  '$file operated with ${testCase.type.name}',
            );

            testCase.verbose
                ? verify(verboseLoggerCallback).called(1)
                : verifyNever(verboseLoggerCallback);

            void fileCreationLoggerCallback() => logger.warn(any());

            !testCase.fileExist && testCase.type != FileModificationType.Create
                ? verify(fileCreationLoggerCallback).called(1)
                : verifyNever(fileCreationLoggerCallback);

            void fileCreationCallback() => file.create(recursive: true);

            testCase.fileExist
                ? verifyNever(fileCreationCallback)
                : verify(fileCreationCallback).called(1);
          });
        }
      });
    });

    group('deleteFile', () {
      final filePath = 'test_file.txt';
      tearDown(() async {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
      });

      testWithOverrides(
        'should delete file and log a message if verbose is true',
        () async {
          final file = File(filePath);

          // Create a dummy file for testing
          await file.create();

          await fileService.deleteFile(filePath: filePath);

          expect(file.existsSync(), isFalse);
          verify(() => logger.detail('$file deleted')).called(1);
        },
      );

      testWithOverrides(
        'should delete file and not log a message if verbose is false',
        () async {
          final file = File(filePath);

          // Create a dummy file for testing
          await file.create();

          await fileService.deleteFile(filePath: filePath, verbose: false);

          expect(file.existsSync(), isFalse);
          verifyNever(() => logger.detail(any()));
        },
      );

      testWithOverrides(
        'should throw `FileSystemException` when file does not exist',
        () async {
          final file = File(filePath);

          await expectLater(
            fileService.deleteFile(filePath: filePath),
            throwsA(predicate((e) => e is FileSystemException)),
          );

          expect(file.existsSync(), isFalse);
          verifyNever(() => logger.detail(any()));
        },
      );
    });

    group('fileExists', () {
      final filePath = 'test_file.txt';

      tearDown(() async {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
      });

      for (final fileExist in [true, false]) {
        testWithOverrides(
          'should return $fileExist if file ${fileExist ? '' : 'does not'} exists',
          () async {
            if (fileExist) {
              // Create a dummy file for testing
              await File(filePath).create();
            }

            final status = await fileService.fileExists(filePath: filePath);

            expect(status, fileExist);
          },
        );
      }
    });

    group('read', () {
      final filePath = 'test_file.txt';
      final content = 'hello\nworld';

      setUp(() {
        final file = File(filePath);
        file.writeAsString(content);
      });

      tearDown(() async {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
      });

      testWithOverrides(
        'readFileAsString should return content as string',
        () async {
          final fileContent = await fileService.readFileAsString(
            filePath: filePath,
          );
          expect(fileContent, content);
        },
      );

      testWithOverrides(
        'readAsBytes should return content as Uint8List',
        () async {
          final fileContent = await fileService.readAsBytes(filePath: filePath);
          expect(fileContent, utf8.encode(content));
        },
      );

      testWithOverrides(
        'readAsLines should return content as List<String>',
        () async {
          final fileContent = await fileService.readFileAsLines(
            filePath: filePath,
          );
          expect(fileContent, content.split('\n'));
        },
      );
    });

    group('deleteFolder', () {
      final directoryPath = 'hello';
      final fileNames = ['test1.txt', 'test2.txt', 'test3.txt', 'test4.txt'];
      setUp(() async {
        await Directory(directoryPath).create();
        for (final fileName in fileNames) {
          await File(join(directoryPath, fileName)).create();
        }
      });
      tearDown(() async {
        final directory = Directory(directoryPath);
        if (await directory.exists()) {
          await directory.delete();
        }
      });

      testWithOverrides(
        'when called should delete directory and all files in it',
        () async {
          when(() => logger.detail(any())).thenAnswer((i) {});
          await fileService.deleteFolder(directoryPath: directoryPath);
          verify(() => logger.detail(any())).called(fileNames.length);
          await expectLater(await Directory(directoryPath).exists(), isFalse);
        },
      );
    });

    group('getFoldersInDirectory', () {
      final directoryPath = 'hello';
      final directoryNames = ['test1', 'test2', 'test3', 'test4'];
      setUp(() async {
        await Directory(directoryPath).create();
        for (final directoryName in directoryNames) {
          await Directory(join(directoryPath, directoryName)).create();
        }
      });
      tearDown(() async {
        final directory = Directory(directoryPath);
        if (await directory.exists()) {
          await directory.delete(recursive: true);
        }
      });

      testWithOverrides(
        'when called should delete directory and all files in it',
        () async {
          when(() => logger.detail(any())).thenAnswer((i) {});
          final directories = await fileService.getFoldersInDirectory(
            directoryPath: directoryPath,
          );
          expect(
            directories..sort(),
            directoryNames.map((e) => join(directoryPath, e)).toList(),
          );
        },
      );
    });

    group('removeLinesOnFile', () {
      final fileName = 'test.txt';
      final file = File(fileName);
      setUp(() async {
        final content = ['Hello', 'World', 'Hello1', 'World1'];
        await file.writeAsString(content.join('\n'));
      });

      tearDown(() async {
        if (await file.exists()) {
          await file.delete();
        }
      });

      testWithOverrides(
        'when called with lines number should delete those lines',
        () async {
          await fileService.removeLinesOnFile(
            filePath: fileName,
            linesNumber: [2, 3],
          );

          final content = await fileService.readFileAsLines(filePath: fileName);
          expect(content, ['Hello', 'Hello1']);
        },
      );
    });

    group('removeSpecificFileLines', () {
      final fileName = 'test.txt';
      final file = File(fileName);

      setUp(() async {
        final content = ['Hello', 'World', 'Hello1', 'World1'];
        await file.writeAsString(content.join('\n'));
      });

      tearDown(() async {
        if (await file.exists()) {
          await file.delete();
        }
      });

      testWithOverrides(
        'when called with filepath & content lines holding content should be removed from the file',
        () async {
          String content = 'Hello';
          var recasedContent = ReCase(content);
          await fileService.removeSpecificFileLines(
            filePath: fileName,
            removedContent: content,
          );
          List<String> file = await File(fileName).readAsLines();
          expect(
            file.contains('/${recasedContent.snakeCase}') ||
                file.contains(' ${recasedContent.pascalCase}'),
            false,
          );
        },
      );

      testWithOverrides(
        'when called with filepath & content with type service lines holding content should be removed from the file',
        () async {
          final content = 'World';
          final recasedContent = ReCase(content);
          await fileService.removeSpecificFileLines(
            filePath: fileName,
            removedContent: content,
            type: kTemplateNameService,
          );
          final file = await File(fileName).readAsString();
          expect(
            file.contains('/${recasedContent.snakeCase}') ||
                file.contains(' ${recasedContent.pascalCase}'),
            false,
          );
        },
      );
    });
  });
}
