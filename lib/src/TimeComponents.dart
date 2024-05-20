// import 'dart:math';

class TimeComponents {
  late int hours;
  late int minutes;
  late int seconds;

  TimeComponents(double number) {
    hours = (number).floor();
    minutes = ((number - hours) * 60).floor();
    seconds = ((number - (hours + minutes / 60)) * 60 * 60).floor();
  }

  DateTime utcDate(year, month, date) {
    return DateTime.utc(year, month, date, hours, minutes, seconds);
  }
}
