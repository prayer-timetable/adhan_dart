// import 'dart:math';

class TimeComponents {
  late int hours;
  late int minutes;
  late int seconds;

  TimeComponents(double number) {
    this.hours = (number).floor();
    this.minutes = ((number - this.hours) * 60).floor();
    this.seconds =
        ((number - (this.hours + this.minutes / 60)) * 60 * 60).floor();
  }

  DateTime utcDate(year, month, date) {
    return new DateTime.utc(
        year, month, date, this.hours, this.minutes, this.seconds);
  }
}
