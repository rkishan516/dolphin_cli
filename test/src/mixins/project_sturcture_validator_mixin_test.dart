import 'package:dolphin_cli/src/constants/message_constants.dart';
import 'package:dolphin_cli/src/exceptions/invalid_dolphin_structure_exception.dart';
import 'package:dolphin_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scoped_zone/scoped_zone.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

import '../../helpers/mock_services.dart';

class TestProjectStructureValidator with ProjectStructureValidator {}

void main() {
  group(ProjectStructureValidator, () {
    late TestProjectStructureValidator validator;
    late Directory tempDir;
    late File pubspecFile;
    late File appFile;
    late MockConfigService mockConfigService;

    setUp(() async {
      validator = TestProjectStructureValidator();
      mockConfigService = MockConfigService();
      return Future(() async {
        tempDir = await Directory.systemTemp.createTemp(
          'test_project_structure_',
        );
        pubspecFile = File(p.join(tempDir.path, 'pubspec.yaml'));
        final libDir = Directory(p.join(tempDir.path, 'lib'));
        await libDir.create();
        final appDir = Directory(p.join(libDir.path, 'app'));
        await appDir.create();

        appFile = File(p.join(appDir.path, 'app.dart'));
      });
    });

    tearDown(() async {
      await tempDir.delete(recursive: true);
    });

    test('if not at project root', () async {
      await expectLater(
        validator.validateStructure(outputPath: tempDir.path),
        throwsA(
          predicate(
            (e) =>
                e is InvalidDolphinStructureException &&
                e.message == kInvalidRootDirectory,
          ),
        ),
      );
    });

    test('if not a dolphin application', () async {
      when(
        () => mockConfigService.dolphinAppFilePath,
      ).thenReturn('app/app.dart');
      await pubspecFile.create();

      runScoped(() async {
        await expectLater(
          validator.validateStructure(outputPath: tempDir.path),
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDolphinStructureException &&
                  e.toString() == kInvalidDolphinStructure,
            ),
          ),
        );
      }, values: {configServiceRef.overrideWith(() => mockConfigService)});
    });

    test('if a dolphin application and at root', () async {
      when(
        () => mockConfigService.dolphinAppFilePath,
      ).thenReturn('app/app.dart');
      await pubspecFile.create();
      await appFile.create();

      runScoped(() async {
        await expectLater(
          validator.validateStructure(outputPath: tempDir.path),
          completes,
        );
      }, values: {configServiceRef.overrideWith(() => mockConfigService)});
    });
  });
}
