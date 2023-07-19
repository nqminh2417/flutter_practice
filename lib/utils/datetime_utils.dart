import 'package:moment_dart/moment_dart.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeUtils {
  static String timeFromNow(String timestamp) {
    final parsedTime = DateTime.parse(timestamp);
    return timeago.format(parsedTime);
  }

  static String mmTimeFromNow(String timestamp) {
    final moment = Moment.parse(timestamp);
    return moment.fromNow();
  }
}
