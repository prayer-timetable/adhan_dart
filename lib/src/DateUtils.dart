import 'package:adhan_dart/src/Rounding.dart';

DateTime dateByAddingDays(DateTime date, int days) {
  return date.add(Duration(days: days));
}

DateTime dateByAddingMinutes(DateTime date, int minutes) {
  return dateByAddingSeconds(date, minutes * 60);
}

DateTime dateByAddingSeconds(DateTime date, int seconds) {
  return date.add(Duration(seconds: seconds));
}

int dayOfYear(DateTime date) {
  Duration diff = date.difference(DateTime(date.year, 1, 1, 0, 0));

  int returnedDayOfYear = diff.inDays + 1; // 1st Jan should be day 1

  return returnedDayOfYear;
}

DateTime roundedMinute(DateTime date,
    {bool precision = true, Rounding rounding = Rounding.nearest}) {
  if (precision && rounding == Rounding.nearest) return date;

  int seconds = date.toUtc().second % 60;
  int offset;

  if (rounding == Rounding.none) {
    return date;
  } else if (rounding == Rounding.up) {
    offset = seconds > 0 ? 60 - seconds : 0;
  } else {
    // Rounding.nearest
    offset = seconds >= 30 ? 60 - seconds : -1 * seconds;
  }

  return dateByAddingSeconds(date, offset);
}
