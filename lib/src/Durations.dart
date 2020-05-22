import 'package:prayers_calc/src/Prayers.dart';

class Durations {
  DateTime midnight;
  DateTime lastThird;

  Durations(
    double lat,
    double long,
    double altitude,
    double angle,
    int timezone, {
    int year,
    int month,
    int day,
    int asrMethod,
    double ishaAngle,
  }) {
    DateTime timestamp = DateTime.now().toUtc();

    // define date in utc
    DateTime date = DateTime.utc(year ?? timestamp.year,
        month ?? timestamp.month, day ?? timestamp.day, 0, 0);

    // define now (local)
    DateTime now = DateTime.now();

    // ***** tomorrow and yesterday
    DateTime tomorrow = date.add(Duration(days: 1));
    DateTime yesterday = date.subtract(Duration(days: 1));

    Prayers prayersToday = Prayers(
      lat,
      long,
      altitude,
      angle,
      timezone,
      year: date.year,
      month: date.month,
      day: date.day,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
    );

    Prayers prayersTomorrow = Prayers(
      lat,
      long,
      altitude,
      angle,
      timezone,
      year: tomorrow.year,
      month: tomorrow.month,
      day: tomorrow.day,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
    );

    Prayers prayersYesterday = Prayers(
      lat,
      long,
      altitude,
      angle,
      timezone,
      year: yesterday.year,
      month: yesterday.month,
      day: yesterday.day,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
    );

    DateTime dawnTomorrow = prayersTomorrow.dawn;
    DateTime dawnToday = prayersToday.dawn;
    DateTime sunsetToday = prayersToday.sunset;
    DateTime sunsetYesterday = prayersYesterday.sunset;

    // print(now.isBefore(dawnToday));
    // midnight
    this.midnight = now.isBefore(dawnToday)
        ? sunsetYesterday.add(Duration(
            minutes:
                (dawnToday.difference(sunsetYesterday).inMinutes / 2).floor()))
        : sunsetToday.add(Duration(
            minutes:
                (dawnTomorrow.difference(sunsetToday).inMinutes / 2).floor()));

    this.lastThird = now.isBefore(dawnToday)
        ? sunsetYesterday.add(Duration(
            minutes: (2 * dawnToday.difference(sunsetYesterday).inMinutes / 3)
                .floor()))
        : sunsetToday.add(Duration(
            minutes: (2 * dawnTomorrow.difference(sunsetToday).inMinutes / 3)
                .floor()));
  }
}
