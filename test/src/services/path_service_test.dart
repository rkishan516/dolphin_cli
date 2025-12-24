import 'dart:io';

import 'package:xdg_directories/xdg_directories.dart' as xdg;
import 'package:dolphin_cli/src/services/path_service.dart';
import 'package:scoped_zone/scoped_zone.dart';
import 'package:test/test.dart';

void main() {
  group(PathService, () {
    T runWithOverrides<T>(T Function() body) {
      return runScoped(body, values: {pathServiceRef});
    }

    void testWithOverrides<T>(Object? description, T Function() body) {
      test(description, () => runWithOverrides(body));
    }

    testWithOverrides('templatesPath', () {
      expect(
        pathService.templatesPath,
        '${Directory.current.path}/lib/src/templates',
      );
    });

    testWithOverrides('separator', () {
      // final seperator = Platform.isWindows ? '\' : '/';
      expect(pathService.separator, '/');
    });

    testWithOverrides('join', () {
      expect(pathService.join('lib', 'src', 'templates'), 'lib/src/templates');
    });

    testWithOverrides('basename', () {
      expect(pathService.basename('lib/src/templates/main.dart'), 'main.dart');
      expect(pathService.basename('lib/src/templates/'), 'templates');
    });

    testWithOverrides('configHome', () {
      expect(pathService.configHome.path, xdg.configHome.path);
    });
  });
}
