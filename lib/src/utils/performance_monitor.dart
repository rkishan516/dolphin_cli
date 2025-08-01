import 'package:mason_logger/mason_logger.dart';

class PerformanceMonitor {
  final Logger _logger;
  final Map<String, Stopwatch> _operations = {};

  PerformanceMonitor({required Logger logger}) : _logger = logger;

  void startOperation(String operationName) {
    _operations[operationName] = Stopwatch()..start();
  }

  void endOperation(String operationName, {bool verbose = false}) {
    final stopwatch = _operations[operationName];
    if (stopwatch == null) {
      _logger.warn('No operation found with name: $operationName');
      return;
    }

    stopwatch.stop();
    final duration = stopwatch.elapsed;

    if (verbose || duration.inSeconds > 2) {
      _logger.detail(
        '$operationName completed in ${duration.inMilliseconds}ms',
      );
    }

    _operations.remove(operationName);
  }

  Future<T> measureAsync<T>(
    String operationName,
    Future<T> Function() operation, {
    bool verbose = false,
  }) async {
    startOperation(operationName);
    try {
      return await operation();
    } finally {
      endOperation(operationName, verbose: verbose);
    }
  }

  T measureSync<T>(
    String operationName,
    T Function() operation, {
    bool verbose = false,
  }) {
    startOperation(operationName);
    try {
      return operation();
    } finally {
      endOperation(operationName, verbose: verbose);
    }
  }
}
