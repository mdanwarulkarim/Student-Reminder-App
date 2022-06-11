import 'package:intl/intl.dart';

class TimeFormatter {

  static String stringDateToDate(String? dateTime) {
    return DateFormat('MMM, dd yyyy').format(DateFormat('yyyy-MM-dd').parse(dateTime!));
  }

  static String stringDateTimeToTime(String? dateTime) {
    return DateFormat('hh a').format(DateFormat('yyyy-MM-dd HH:mm').parse(dateTime!));
  }

}