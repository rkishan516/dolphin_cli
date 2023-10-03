class InvalidDolphinStructureException implements Exception {
  final String message;
  InvalidDolphinStructureException(this.message);

  @override
  String toString() {
    return message;
  }
}
