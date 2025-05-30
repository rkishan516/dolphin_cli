// ignore_for_file: constant_identifier_names, unnecessary_string_escapes

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dolphin_cli/src/services/logger.dart';
import 'package:dolphin_cli/src/templates/template_constants.dart';
import 'package:recase/recase.dart';
import 'package:scoped_zone/scoped_zone.dart';

/// A reference to a [FileService] instance.
final fileServiceRef = create(FileService.new);

/// The [FileService] instance available in the current zone.
FileService get fileService => read(fileServiceRef);

/// Handles the writing of files to disk
class FileService {
  Future<void> writeStringFile({
    required File file,
    required String fileContent,
    bool verbose = false,
    FileModificationType type = FileModificationType.Create,
    String? verboseMessage,
    bool forceAppend = false,
  }) async {
    if (!(await file.exists())) {
      if (type != FileModificationType.Create) {
        logger.warn('File does not exist. Write it out');
      }
      await file.create(recursive: true);
    }

    await file.writeAsString(
      fileContent,
      mode: forceAppend ? FileMode.append : FileMode.write,
    );

    if (verbose) {
      logger.detail(verboseMessage ?? '$file operated with ${type.name}');
    }
  }

  Future<void> writeDataFile({
    required File file,
    required Uint8List fileContent,
    bool verbose = false,
    FileModificationType type = FileModificationType.Create,
    String? verboseMessage,
    bool forceAppend = false,
  }) async {
    if (!(await file.exists())) {
      if (type != FileModificationType.Create) {
        logger.warn('File does not exist. Write it out');
      }
      await file.create(recursive: true);
    }

    await file.writeAsBytes(
      fileContent,
      mode: forceAppend ? FileMode.append : FileMode.write,
    );

    if (verbose) {
      logger.detail(verboseMessage ?? '$file operated with ${type.name}');
    }
  }

  /// Delete a file at the given path
  ///
  /// Args:
  ///   filePath (String): The path to the file you want to delete.
  ///   verbose (bool): Determine if should log the action or not.
  Future<void> deleteFile({
    required String filePath,
    bool verbose = true,
  }) async {
    final file = File(filePath);
    await file.delete();
    if (verbose) {
      logger.detail('$file deleted');
    }
  }

  /// It deletes all the files in a folder. and the folder itself.
  ///
  /// Args:
  ///   directoryPath (String): The path to the directory you want to delete.
  Future<void> deleteFolder({required String directoryPath}) async {
    var files = await getFilesInDirectory(directoryPath: directoryPath);
    await Future.forEach<FileSystemEntity>(files, (file) async {
      await file.delete();
      logger.detail('$file deleted');
    });
    await Directory(directoryPath).delete(recursive: false);
  }

  /// Check if the file at [filePath] exists
  Future<bool> fileExists({required String filePath}) {
    return File(filePath).exists();
  }

  /// Reads the file at [filePath] on disk and returns as String
  Future<String> readFileAsString({
    required String filePath,
  }) {
    return File(filePath).readAsString();
  }

  /// Reads the file at [filePath] and returns its data as bytes
  Future<Uint8List> readAsBytes({required String filePath}) {
    return File(filePath).readAsBytes();
  }

  /// Read the file at the given path and return the contents as a list of strings, one string per
  /// line.
  ///
  /// Args:
  ///   filePath (String): The path to the file to read.
  ///
  /// Returns:
  ///   A [Future<List<String>>]
  Future<List<String>> readFileAsLines({
    required String filePath,
  }) {
    return File(filePath).readAsLines();
  }

  Future<void> removeSpecificFileLines({
    required String filePath,
    required String removedContent,
    String type = kTemplateNameView,
  }) async {
    final recaseName = ReCase('$removedContent $type');

    List<String> fileLines = await readFileAsLines(filePath: filePath);
    fileLines.removeWhere((line) => line.contains('/${recaseName.snakeCase}'));
    fileLines.removeWhere((line) => line.contains(' ${recaseName.pascalCase}'));
    await writeStringFile(
      file: File(filePath),
      fileContent: fileLines.join('\n'),
      type: FileModificationType.Modify,
      verbose: true,
      verboseMessage: "Removed ${recaseName.pascalCase} from $filePath",
    );
  }

  /// Removes [linesNumber] on the file at [filePath].
  Future<void> removeLinesOnFile({
    required String filePath,
    required List<int> linesNumber,
  }) async {
    final fileLines = await readFileAsLines(filePath: filePath);

    for (var line in linesNumber) {
      fileLines.removeAt(line - 1);
    }

    await writeStringFile(
      file: File(filePath),
      fileContent: fileLines.join('\n'),
      type: FileModificationType.Modify,
    );
  }

  /// Gets all files in a given directory
  Future<List<FileSystemEntity>> getFilesInDirectory(
      {required String directoryPath}) async {
    final directory = Directory(directoryPath);
    final allFileEntities = await _listDirectoryContents(directory);
    return allFileEntities.toList();
  }

  Future<List<String>> getFoldersInDirectory(
      {required String directoryPath}) async {
    final directory = Directory(directoryPath);
    final allFileEntities =
        await _listDirectoryContents(directory, recursive: false);
    return allFileEntities.whereType<Directory>().map((e) => e.path).toList();
  }

  Future<List<FileSystemEntity>> _listDirectoryContents(
    Directory dir, {
    bool recursive = true,
  }) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: recursive);
    lister.listen(
      (file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files),
    );
    return completer.future;
  }
}

// enum for file modification types
enum FileModificationType {
  Append,
  Create,
  Modify,
  Delete,
}
