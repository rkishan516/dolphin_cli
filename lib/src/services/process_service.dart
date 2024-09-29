import 'dart:convert';
import 'dart:io';

import 'package:dolphin_cli/src/constants/command_constants.dart';
import 'package:dolphin_cli/src/services/config_service.dart';
import 'package:dolphin_cli/src/services/logger.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:scoped_zone/scoped_zone.dart';

/// A reference to a [ProcessService] instance.
final processServiceRef = create(ProcessService.new);

/// The [ProcessService] instance available in the current zone.
ProcessService get processService => read(processServiceRef);

/// helper service to run flutter commands
class ProcessService {
  late String _formattingLineLength;

  ProcessService() {
    _formattingLineLength = configService.lineLength.toString();
  }

  set formattingLineLength(String? length) {
    _formattingLineLength = length ?? configService.lineLength.toString();
  }

  /// Creates a new flutter app.
  ///
  /// Args:
  ///   appName (String): The name of the app that's going to be create.
  ///   shouldUseMinimalTempalte (bool): Uses minimal app template.
  ///   description (String): The description to use for your new Flutter project.
  ///   organization (String): The organization responsible for your new Flutter project.
  ///   platforms (List<String>): The platforms supported by this project.
  Future<void> runCreateApp({
    required String name,
    String? description,
    String? organization,
    List<String> platforms = const [],
  }) async {
    await _runProcess(
      programName: ksFlutter,
      arguments: [
        ksCreate,
        name,
        '-e',
        if (description != null) '--description="$description"',
        if (organization != null) '--org=$organization',
        if (platforms.isNotEmpty) '--platforms=${platforms.join(",")}',
      ],
    );
  }

  /// Run the `pub run build_runner build --delete-conflicting-outputs` command in the `appName` directory
  ///
  /// Args:
  ///   appName (String): The name of the app.
  Future<void> runBuildRunner({
    String? workingDirectory,
    bool shouldWatch = false,
    bool shouldDeleteConflictingOutputs = true,
  }) async {
    await _runProcess(
      programName: ksDart,
      arguments: [
        ...buildRunnerArguments,
        shouldWatch ? ksWatch : ksBuild,
        if (shouldDeleteConflictingOutputs) ksDeleteConflictingOutputs,
      ],
      workingDirectory: workingDirectory,
    );
  }

  /// It runs the `flutter pub get` command in the app's directory
  ///
  /// Args:
  ///   appName (String): The name of the app.
  Future<void> runPubGet({String? appName}) async {
    await _runProcess(
      programName: ksFlutter,
      arguments: pubGetArguments,
      workingDirectory: appName,
    );
  }

  Future<void> runPubAdd({String? appName, required String packageName}) async {
    await _runProcess(
      programName: ksFlutter,
      arguments: [...pubAddArguments, packageName],
      workingDirectory: appName,
    );
  }

  /// Runs the dart format . command on the app's source code.
  ///
  /// Args:
  ///   appName (String): The name of the app.
  Future<void> runFormat({String? appName, String? filePath}) async {
    await _runProcess(
      programName: ksDart,
      arguments: [
        ksFormat,
        filePath ?? ksCurrentDirectory,
        '-l',
        _formattingLineLength
      ],
      workingDirectory: appName,
    );
  }

  /// It runs the `dart pub global activate` command in the app's directory
  Future<void> runPubGlobalActivate() async {
    await _runProcess(
      programName: ksDart,
      arguments: pubGlobalActivateArguments,
    );
  }

  /// Runs the `dart pub global list` command and returns a list of strings
  /// representing packages with their version.
  Future<List<String>> runPubGlobalList() async {
    final output = <String>[];
    await _runProcess(
      programName: ksDart,
      arguments: pubGlobalListArguments,
      verbose: false,
      handleOutput: (lines) async => output.addAll(lines),
    );

    return output;
  }

  /// Runs the flutter analyze command and returns the output as a list of lines.
  Future<List<String>> runAnalyze({String? appName}) async {
    final output = <String>[];
    await _runProcess(
      programName: ksFlutter,
      arguments: analyzeArguments,
      workingDirectory: appName,
      verbose: false,
      handleOutput: (lines) async => output.addAll(lines),
    );

    return output;
  }

  /// It runs a process and logs the output to the console when [verbose] is true.
  ///
  /// Args:
  ///   programName (String): The name of the program to run.
  ///   arguments (List<String>): The arguments to pass to the program. Defaults to const []
  ///   workingDirectory (String): The directory to run the command in.
  ///   verbose (bool): Determine when to log the output to the console.
  ///   handleOutput (Function): Function passed to handle the output.
  Future<void> _runProcess({
    required String programName,
    List<String> arguments = const [],
    String? workingDirectory,
    bool verbose = true,
    Future<void> Function(List<String> lines)? handleOutput,
  }) async {
    Progress? progress;
    final hasWorkingDirectory = workingDirectory != null;
    if (verbose) {
      progress = logger.progress(
          'Running $programName ${arguments.join(' ')} ${hasWorkingDirectory ? 'in $workingDirectory/' : ''}...');
    }

    try {
      final process = await Process.start(
        programName,
        arguments,
        workingDirectory: workingDirectory,
        runInShell: true,
      );

      final lines = <String>[];
      final lineSplitter = LineSplitter();
      await process.stdout.transform(utf8.decoder).forEach((output) {
        if (verbose) logger.detail(output);

        if (handleOutput != null) {
          lines.addAll(lineSplitter
              .convert(output)
              .map((l) => l.trim())
              .where((l) => l.isNotEmpty)
              .toList());
        }
      });

      await handleOutput?.call(lines);

      final exitCode = await process.exitCode;

      if (verbose) {
        if (exitCode == 0) {
          progress!.complete(
              'Successfully ran $programName ${arguments.join(' ')} ${workingDirectory != null ? 'in $workingDirectory/' : ''}.');
        } else {
          progress!.fail(
              'Failed to run $programName ${arguments.join(' ')} ${workingDirectory != null ? 'in $workingDirectory/' : ''}. ExitCode: $exitCode');
        }
      }
    } on ProcessException catch (e) {
      final message =
          'Command failed. Command executed: $programName ${arguments.join(' ')}\nException: ${e.message}';
      if (verbose) {
        progress!.fail(message);
      } else {
        logger.err(message);
      }
    } catch (e) {
      final message =
          'Command failed. Command executed: $programName ${arguments.join(' ')}\nException: ${e.toString()}';
      if (verbose) {
        progress!.fail(message);
      } else {
        logger.err(message);
      }
    }
  }
}
