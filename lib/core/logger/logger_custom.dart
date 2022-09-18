import 'package:kyo_base/core/logger/cus_pretty_printer.dart';
import 'package:logger/logger.dart';

var logger = LoggerCustom(logEnable: true);

/* to show log of Map inside a string expression, you need add intent into your Map
 * example:
 * Map<String,dynamic> mockData = {
    "id": "2705",
    "employee": {
    "name": "Nancy Ball"
    }
    }
 * final prettyString = JsonEncoder.withIndent(' ').convert(mockData);
 * logger.i('Show Map object: $prettyString');
 */
class LoggerCustom extends Logger {
  LoggerCustom({bool logEnable = true})
      : super(
          filter: CustomLogFilter(logEnable: logEnable),
          printer: CusPrettyPrinter(
            methodCount: 1,
            errorMethodCount: 2,
            lineLength: 2,
            // Colorful log messages
            colors: false,
            // Print an emoji for each log message
            printEmojis: true,
            // Should each log print contain a timestamp
            printTime: false,
          ),
        );
}

class CustomLogFilter extends LogFilter {
  final bool logEnable;

  CustomLogFilter({this.logEnable = true});

  @override
  bool shouldLog(LogEvent event) {
    return logEnable;
  }
}
