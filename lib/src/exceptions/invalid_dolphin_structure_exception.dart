import 'package:freezed_annotation/freezed_annotation.dart';

@internal
class InvalidDolphinStructureException implements Exception {
  final String message;
  InvalidDolphinStructureException(this.message);

  @override
  String toString() {
    return message;
  }
}
