import 'package:logger/logger.dart';

class BiteLogger {
  BiteLogger._internal();

  static final BiteLogger _singleton = BiteLogger._internal();

  factory BiteLogger() => _singleton;

  final Logger _logger = Logger(
    // Use the default LogFilter (-> only log in debug mode)
    filter: null,
    // Use the default LogOutput (-> send everything to console)
    output: null,
    // Use the PrettyPrinter to format and print log
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  // Debug message
  void debug(String message) {
    _logger.d(message);
  }

  // Info message
  void info(String message) {
    _logger.i(message);
  }

  // Warning message
  void warning(String message) {
    _logger.w(message);
  }

  // Error message
  void error(String message) {
    _logger.e(message);
  }

  // Trace message
  void trace(String message) {
    _logger.t(message);
  }

  // Fatal Error message
  void fatal(String message) {
    _logger.f(message);
  }
}
