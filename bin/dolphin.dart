import 'dart:io';

import 'package:dolphin_cli/src/commands/dolhphin_cli_command_runner.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/file_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/services/path_service.dart';
import 'package:dolphin_cli/src/services/process_service.dart';
import 'package:dolphin_cli/src/services/pub_service.dart';
import 'package:dolphin_cli/src/services/pubspec_service.dart';
import 'package:dolphin_cli/src/services/template_service.dart';
import 'package:dolphin_cli/src/templates/template_helper.dart';
import 'package:scoped_zone/scoped_zone.dart';

Future<void> main(List<String> args) async {
  await _flushThenExit(
    await runScoped(
      () async => DolphinCliCommandRunner().run(args),
      values: {
        configServiceRef,
        fileServiceRef,
        loggerRef,
        pathServiceRef,
        processServiceRef,
        pubServiceRef,
        pubspecServiceRef,
        templateServiceRef,
        templateHelperRef,
      },
    ),
  );
}

/// Flushes the stdout and stderr streams, then exits the program with the given
/// status code.
///
/// This returns a Future that will never complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future<void> _flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}
