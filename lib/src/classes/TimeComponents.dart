// import 'dart:math';

class TimeComponents {
  int hours;
  int minutes;
  int seconds;

  TimeComponents(double number) {
    this.hours = (number).floor();
    this.minutes = ((number - this.hours) * 60).floor();
    this.seconds =
        ((number - (this.hours + this.minutes / 60)) * 60 * 60).floor();
    // print(seconds);
    // return this;
  }

  DateTime utcDate(year, month, date) {
    return new DateTime.utc(
        year, month, date, this.hours, this.minutes, this.seconds);
  }
}
