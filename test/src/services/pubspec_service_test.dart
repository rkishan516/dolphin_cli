import 'dart:io';

import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:scoped_zone/scoped_zone.dart';
import 'package:test/test.dart';

void main() {
  group(PubspecService, () {
    void testWithOverrides<T>(Object? description, T Function() body) {
      test(description, () => runScoped(body, values: {pubspecServiceRef}));
    }

    group('getPackageName when called', () {
      testWithOverrides('with  working directory', () async {
        await pubspecService.initialise(
          workingDirectory: Directory.current.path,
        );
        expect(pubspecService.getPackageName, 'dolphin_cli');
      });

      testWithOverrides('without  working directory', () async {
        await pubspecService.initialise();
        expect(pubspecService.getPackageName, 'dolphin_cli');
      });
    });
  });
}
