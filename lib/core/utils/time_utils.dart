import 'package:intl/intl.dart';

// ignore: library_prefixes
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:kyo_base/imports/base_component_import.dart';
import 'package:timeago/timeago.dart';

enum FormatType {
  DATE,
  USER_DATE_MONTH_TIME,
  TIME,
  DATE_TIME,
  DATE_MONTH,
  MONTH_YEAR,
  CODE
}

extension DateExtend on DateTime?{

  bool? isSameDate(DateTime? date) {
    if (this == null || date == null) return null;

    return TimeUtils.isSameDay(this!, date);
  }
}

extension TimeString on String? {
  String? toSimpleMonthYear() {
    if (isNullOrEmpty()) return null;
    return TimeUtils.dateStrFormatLocale(this,
        format: TimeUtils.formatSimpleMonthYear);
  }

  String? toSimpleMonthDate() {
    if (isNullOrEmpty()) return null;
    return TimeUtils.dateStrFormatLocale(this,
        format: TimeUtils.formatSimpleMonthDate);
  }

  String? toSimpleDateLocale() {
    if (isNullOrEmpty()) return null;
    return TimeUtils.dateStrFormatLocale(this,
        format: TimeUtils.formatSimpleDate);
  }

  DateTime? toDateLocale() {
    if (isNullOrEmpty()) return null;
    return TimeUtils.strUtcToDateLocale(this);
  }

  DateTime? toDate() {
    if (isNullOrEmpty()) return null;
    return TimeUtils.strUtcToDate(this);
  }

  String? toTimeAgo() {
    if (isNullOrEmpty()) return null;
    return TimeUtils.getTimeAgo(this);
  }

  DateFormat toDateFormat() {
    return DateFormat(isNullOrEmpty() ? TimeUtils.formatSimpleDate : this);
  }

  DateFormat toDateFormatLocale() {
    return DateFormat(isNullOrEmpty() ? TimeUtils.formatSimpleDate : this, Get.locale!.languageCode);
  }
}

class TimeUtils {
  TimeUtils._();

  static const formatSimpleDate = 'dd/MM/yyyy';
  static final formatSimpleDateDF = DateFormat(formatSimpleDate);
  static const formatSimpleHour = 'HH:mm';
  static final formatSimpleHourDF = DateFormat(formatSimpleHour);
  static const formatSimpleMonthDate = 'dd/MM';
  static const formatSimpleMonthYear = 'MM/yyyy';
  static const formatUserDayOfWeek = 'EEEE';
  static final formatUserDayOfWeekDF = DateFormat(formatUserDayOfWeek);
  static const formatUserDateTime = 'hh:mm, dd/MM';
  static const formatUserDateTime1 = 'hh:mm - dd/MM/yyyy';
  static const formatUserDateTimeFull = 'dd/MM/yyyy, hh:mm';
  static const formatUserSimpleMonthDay = 'MMMMd';
  static const _monthFormat = 'MMMM yyyy';
  static final _monthFormatDF = DateFormat(_monthFormat);
  static const _dayFormat = 'dd';
  static final _dayFormatDF = DateFormat(_dayFormat);
  static const _fullDayFormat = 'EEE MMM dd, yyyy';
  static final _fullDayFormatDF = DateFormat(_fullDayFormat);
  static const _userDayTimeFormat = 'dd/MM/yyyy HH:mm';
  static final _userDayTimeFormatDF = DateFormat(_userDayTimeFormat);

  static String? getTimeAgo(String? datetime) {
    return getTimeAgoFromDate(strUtcToDate(datetime));
  }

  static String? getTimeAgoFromDate(DateTime? date, {String? dateFormat}) {
    if (date == null) {
      return null;
    }

    final nowUtc = DateTime.now().toUtc();
    final diffInDay = nowUtc.difference(date).inDays;

    if (date.isAfter(nowUtc)) {
      return dateToStrLocale(date, format: dateFormat ?? formatSimpleDate);
    } else if (diffInDay >= 7) {
      return dateToStrLocale(date, format: dateFormat ?? formatSimpleDate);
    } else if (diffInDay == 1) {
      return 'yesterday'.tr;
    } else if (diffInDay > 1 && diffInDay < 7) {
      return dateToStrLocale(date, format: formatUserDayOfWeek);
    }

    final fifteenAgo = date;
    timeAgo.setLocaleMessages('vi', MyCustomMessages());
    return timeAgo.format(fifteenAgo, locale: Get.locale!.languageCode);
  }

  static String? getTimeDifferStr(DateTime? firstDay, DateTime? secondDay) {
    try {
      if (firstDay == null || secondDay == null) {
        return null;
      }
      if (firstDay.isAfter(secondDay)) return null;

      timeAgo.setLocaleMessages('vi', DifferMessages());
      return timeAgo.format(secondDay,
          clock: firstDay, locale: Get.locale!.languageCode);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  static DateTime? strUtcToDateLocale(String? str,
      {String format = "yyyy-MM-ddTHH:mm:ssZ"}) {
    if (str.isNullOrEmpty()) return null;
    return DateFormat(format, Get.locale!.languageCode).parseUTC(str ?? '').toLocal();
  }

  static DateTime? strUtcToDate(String? str,
      {String format = "yyyy-MM-ddTHH:mm:ssZ"}) {
    if (str.isNullOrEmpty()) return null;
    return DateFormat(format).parseUTC(str ?? '');
  }

  static String getCurrentDateAsStr() {
    return dateToStr(getCurrentDate());
  }

  static String dateToStr(DateTime rs, {DateFormat? format, String? locale}) {
    return format != null ? format.format(rs) : formatSimpleDateDF.format(rs);
  }

  static String dateToStrLocale(DateTime rs, {String? format}) {
    return dateToStr(rs.toLocal(), format: DateFormat(format, Get.locale!.languageCode ));
  }

  static String? dateStrFormatLocale(String? rs, {String? format}) {
    if (rs == null) return null;
    var date = strUtcToDateLocale(rs)?.toLocal();

    if (date == null) return null;
    return dateToStr(date, format: format.toDateFormat());
  }

  static String? dateStrFormat(String? rs, {DateFormat? format}) {
    if (rs == null) return null;
    var date = strUtcToDate(rs);

    if (date == null) return null;
    return dateToStr(date, format: format);
  }

  static String formatMonth(DateTime d) => _monthFormatDF.format(d);

  static String formatDay(DateTime day, {String? strFormat}) {
    return strFormat != null
        ? DateFormat(strFormat).format(day)
        : _dayFormatDF.format(day);
  }

  static String fullDayFormat(DateTime d) => _fullDayFormatDF.format(d);

  static String? userFullDayFormatStr(String d) {
    final date = TimeUtils.strUtcToDate(d);
    return date == null ? null : userFullDayFormat(date);
  }

  static String? userFullDayFormat(DateTime? d) {
    if (d == null) return null;

    final now = DateTime.now().toUtc();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final checkDate = DateTime(d.year, d.month, d.day);
    final time = dateToStrLocale(d, format: formatSimpleHour);
    if (checkDate == today) {
      return '${'today'.tr} ${time}';
    } else if (checkDate == yesterday) {
      return '${'yesterday'.tr} ${time}';
    } else if (checkDate == tomorrow) {
      return '${'tomorrow'.tr} ${time}';
    }

    return dateToStrLocale(d, format: _userDayTimeFormat);
  }

  static DateTime today() {
    return DateTime.now();
  }

  static DateTime todayLocal() {
    return DateTime.now().toLocal();
  }

  /// List of day between 1 day
  /// @range: Ex range = 3 => get 3 days on the left and 3 days on the right => total 7 days
  static Future<List<DateTime>> daysBetween(DateTime date, int range) async {
    final first = date.subtract(Duration(days: range));
    final last = date.add(Duration(days: range + 1));

    return daysInRange(first, last).toList();
  }

  /// The list of days in a given month
  static List<DateTime> daysInMonth(DateTime month) {
    final first = firstDayOfMonth(month);
    final daysBefore = first.weekday;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));
    final last = lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday % 7;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(const Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(const Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(const Duration(days: 7));
  }
}

class MyCustomMessages extends ViMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String aboutAMinute(int minutes) => '1 phút';

  @override
  String aboutAnHour(int minutes) => '1 giờ';

  @override
  String aDay(int hours) => '1 ngày';

  @override
  String hours(int hours) => '${hours.abs()} giờ';
}

class DifferMessages extends ViMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => '${seconds.abs()} giây';

  @override
  String aboutAMinute(int minutes) => '${minutes.abs()} phút';

  @override
  String minutes(int minutes) => '${minutes.abs()} phút';

  @override
  String aboutAnHour(int minutes) => '${minutes.abs()} phút';

  @override
  String hours(int hours) => '${hours.abs()} giờ';

  @override
  String aDay(int hours) => '${hours.abs()} giờ';

  @override
  String days(int days) => '${days.abs()} ngày';

  @override
  String aboutAMonth(int days) => '${days.abs()} ngày';

  @override
  String months(int months) => '${months.abs()} tháng';

  @override
  String aboutAYear(int year) => '${year.abs()} tháng';

  @override
  String years(int years) => '$years năm';

  @override
  String wordSeparator() => ' ';
}
