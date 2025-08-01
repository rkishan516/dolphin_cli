import 'package:mason_logger/mason_logger.dart';
import '../exceptions/config_file_not_found_exception.dart';
import '../exceptions/invalid_dolphin_structure_exception.dart';

class ErrorHandlerService {
  final Logger _logger;

  ErrorHandlerService({required Logger logger}) : _logger = logger;

  void handleError(Object error, StackTrace? stackTrace) {
    if (error is ConfigFileNotFoundException) {
      _logger.err(error.message);
      _logger.info('Run "dolphin create app" to create a new Dolphin project');
    } else if (error is InvalidDolphinStructureException) {
      _logger.err(error.message);
      _logger.info('Ensure you are in a valid Dolphin project directory');
    } else if (error is FormatException) {
      _logger.err('Invalid format: ${error.message}');
      _logger.detail('Source: ${error.source}');
    } else {
      _logger.err('An unexpected error occurred: $error');
      if (stackTrace != null) {
        _logger.detail('Stack trace:\n$stackTrace');
      }
    }
  }

  Future<T?> runWithErrorHandling<T>(
    Future<T> Function() operation, {
    String? operationName,
  }) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      if (operationName != null) {
        _logger.err('Failed to $operationName');
      }
      handleError(error, stackTrace);
      return null;
    }
  }
}
