import 'dart:io';

import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/constants/config_constants.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pub_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:scoped_zone/scoped_zone.dart';
import 'package:test/test.dart';

import '../../helpers/mock_services.dart';

void main() {
  group(PubService, () {
    final version = '1.0.0';
    late ProcessService processService;
    late PubUpdater pubUpdater;
    late PubService pubService;

    setUp(() {
      processService = MockProcessService();
      pubUpdater = MockPubUpdater();
      pubService = PubService(pubUpdater);
    });

    void testWithOverrides<T>(Object? description, T Function() body) {
      test(
        description,
        () => runScoped(
          body,
          values: {
            pubServiceRef.overrideWith(() => pubService),
            processServiceRef.overrideWith(() => processService),
          },
        ),
      );
    }

    group('getCurrentVersion when called', () {
      testWithOverrides(
        'with global installation should return version',
        () async {
          when(
            () => processService.runPubGlobalList(),
          ).thenAnswer((i) async => ['$ksDolphinCli $version']);
          final fetchedVersion = await pubService.getCurrentVersion();
          expect(fetchedVersion, version);
        },
      );

      testWithOverrides(
        'with globally local installation should return currentVersionNotAvailable',
        () async {
          when(
            () => processService.runPubGlobalList(),
          ).thenAnswer((i) async => []);
          final fetchedVersion = await pubService.getCurrentVersion();
          expect(fetchedVersion, currentVersionNotAvailable);
        },
      );
    });

    testWithOverrides(
      'getLatestVersion when called should call pub updater getLatestVersion and return version return from pub updater',
      () async {
        when(
          () => pubUpdater.getLatestVersion(any()),
        ).thenAnswer((i) async => version);

        final fetchedVersion = await pubService.getLatestVersion();

        expect(fetchedVersion, version);
        verify(() => pubUpdater.getLatestVersion(ksDolphinCli)).called(1);
      },
    );

    group('hasLatestVersion when called', () {
      testWithOverrides(
        'with current version is locally installed should update and return true',
        () async {
          when(
            () => processService.runPubGlobalList(),
          ).thenAnswer((i) async => []);
          when(
            () => pubUpdater.update(packageName: any(named: 'packageName')),
          ).thenAnswer(
            (i) async => ProcessResult(pid, exitCode, stdout, stderr),
          );

          final result = await pubService.hasLatestVersion();

          verify(() => pubUpdater.update(packageName: ksDolphinCli)).called(1);
          expect(result, isTrue);
        },
      );

      testWithOverrides(
        'with current version is up to date should return true',
        () async {
          when(
            () => processService.runPubGlobalList(),
          ).thenAnswer((i) async => ['$ksDolphinCli $version']);
          when(
            () => pubUpdater.isUpToDate(
              packageName: any(named: 'packageName'),
              currentVersion: any(named: 'currentVersion'),
            ),
          ).thenAnswer((i) async => true);

          final result = await pubService.hasLatestVersion();

          verifyNever(() => pubUpdater.update(packageName: ksDolphinCli));
          expect(result, isTrue);
        },
      );

      testWithOverrides(
        'with current version is not up to date should return false',
        () async {
          when(
            () => processService.runPubGlobalList(),
          ).thenAnswer((i) async => ['$ksDolphinCli $version']);
          when(
            () => pubUpdater.isUpToDate(
              packageName: any(named: 'packageName'),
              currentVersion: any(named: 'currentVersion'),
            ),
          ).thenAnswer((i) async => false);

          final result = await pubService.hasLatestVersion();

          verifyNever(() => pubUpdater.update(packageName: ksDolphinCli));
          expect(result, isFalse);
        },
      );
    });

    testWithOverrides(
      'update when called should call pub updater update',
      () async {
        when(
          () => pubUpdater.update(packageName: any(named: 'packageName')),
        ).thenAnswer((i) async => ProcessResult(pid, exitCode, stdout, stderr));

        await pubService.update();

        verify(() => pubUpdater.update(packageName: ksDolphinCli)).called(1);
      },
    );
  });
}
