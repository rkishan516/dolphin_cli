import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'logger_service.g.dart';

@Riverpod(keepAlive: true)
Talker loggerService(Ref ref) {
  return TalkerFlutter.init(
    logger: TalkerLogger(
      filter: const LogLevelTalkerLoggerFilter(LogLevel.debug),
      formatter: const ColoredLoggerFormatter(),
      settings: TalkerLoggerSettings(
        maxLineWidth: 20,
        colors: {
          LogLevel.critical: AnsiPen()..red(),
          LogLevel.error: AnsiPen()..magenta(),
          LogLevel.info: AnsiPen()..cyan(),
          LogLevel.warning: AnsiPen()..yellow(),
          LogLevel.debug: AnsiPen()..blue(),
          LogLevel.verbose: AnsiPen()..gray(),
        },
        enableColors: true,
      ),
    ),
  );
}

class LogLevelTalkerLoggerFilter implements LoggerFilter {
  const LogLevelTalkerLoggerFilter(this.logLevel);

  final LogLevel logLevel;

  /// List of levels sorted by priority
  final logLevelPriorityList = const [
    LogLevel.critical,
    LogLevel.error,
    LogLevel.warning,
    LogLevel.info,
    LogLevel.debug,
    LogLevel.verbose,
  ];

  @override
  bool shouldLog(dynamic msg, LogLevel level) {
    final currLogLevelIndex = logLevelPriorityList.indexOf(logLevel);
    final msgLogLevelIndex = logLevelPriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}
