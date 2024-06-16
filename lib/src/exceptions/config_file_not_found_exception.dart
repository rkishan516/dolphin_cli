import 'package:freezed_annotation/freezed_annotation.dart';

@internal
class ConfigFileNotFoundException implements Exception {
  final String message;
  final bool shouldHaltCommand;
  ConfigFileNotFoundException(this.message, {this.shouldHaltCommand = false});

  @override
  String toString() {
    return message;
  }
}
