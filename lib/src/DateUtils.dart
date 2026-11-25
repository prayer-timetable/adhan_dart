import 'package:adhan_dart/src/Rounding.dart';

DateTime dateByAddingDays(DateTime date, int days) {
  final shifted = date.add(Duration(days: days));
  final expected = DateTime.utc(date.year, date.month, date.day + days,
      date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  final actual = DateTime.utc(
      shifted.year,
      shifted.month,
      shifted.day,
      shifted.hour,
      shifted.minute,
      shifted.second,
      shifted.millisecond,
      shifted.microsecond);
  final candidate = shifted.add(expected.difference(actual));

  // Where the clock moves forward at 00:00 the next day starts an hour later,
  // so the correction above steps back onto the previous calendar day. Keep
  // the shifted instant then: it is already on the wanted day.
  if (candidate.year == expected.year &&
      candidate.month == expected.month &&
      candidate.day == expected.day) {
    return candidate;
  }
  return shifted;
}

DateTime dateByAddingMinutes(DateTime date, int minutes) {
  return dateByAddingSeconds(date, minutes * 60);
}

DateTime dateByAddingSeconds(DateTime date, int seconds) {
  return date.add(Duration(seconds: seconds));
}

int dayOfYear(DateTime date) {
  final day = DateTime.utc(date.year, date.month, date.day);
  return day.difference(DateTime.utc(date.year)).inDays + 1;
}

DateTime roundedMinute(DateTime date,
    {bool precision = true, Rounding rounding = Rounding.nearest}) {
  // When `precision` is true, preserve sub-minute resolution (legacy behavior).
  if (precision) return date;

  if (rounding == Rounding.none) {
    return date;
  }

  int seconds = date.toUtc().second % 60;
  int offset;

  if (rounding == Rounding.up) {
    offset = seconds > 0 ? 60 - seconds : 0;
  } else {
    // Rounding.nearest
    offset = seconds >= 30 ? 60 - seconds : -1 * seconds;
  }

  return dateByAddingSeconds(date, offset);
}
