import 'package:adhan/src/classes/Astronomical.dart';

dateByAddingDays(DateTime date, int days) {
  return date.add(Duration(days: days));
}

dateByAddingMinutes(date, minutes) {
  return dateByAddingSeconds(date, minutes * 60);
}

dateByAddingSeconds(DateTime date, int seconds) {
  // TODO??? 1000*
  // return new Date(date.getTime() + (seconds * 1000));
  return date.add(Duration(seconds: seconds));
}

roundedMinute(DateTime date, {bool precision: true}) {
  // print(date);

  // const seconds = date.getUTCSeconds();
  // TODO seconds should be between 0-59
  int seconds = date.toUtc().second % 60;
  // int seconds = date.toUtc().second;
  int offset = seconds >= 30 ? 60 - seconds : -1 * seconds;
  // print(offset);
  if (precision) return date;

  return dateByAddingSeconds(date, offset);
}

dayOfYear(date) {
  int returnedDayOfYear = 0;
  int feb = Astronomical.isLeapYear(date.year) ? 29 : 28;
  List<int> months = [31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  for (var i = 0; i < (date.month - 1); i++) {
    returnedDayOfYear += months[i];
  }

  returnedDayOfYear += date.getDate();

  return returnedDayOfYear;
}
