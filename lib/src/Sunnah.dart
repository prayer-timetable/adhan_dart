import 'dart:math';
import 'package:prayers_calc/src/Prayers.dart';

class Sunnah {
  DateTime midnight;
  DateTime lastThird;

  Sunnah(
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
    DateTime beginingOfYear = DateTime(timestamp.year, 1, 1).toUtc();

    DateTime date = DateTime(
        year ?? timestamp.year, month ?? timestamp.month, day ?? timestamp.day);

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
      day: date.year,
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
      day: tomorrow.year,
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
      day: yesterday.year,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
    );

    DateTime dawnTomorrow = prayersTomorrow.dawn;
    DateTime duskYesterday = prayersYesterday.dusk;

    // midnight
    this.midnight = date.add(Duration(
        minutes:
            (dawnTomorrow.difference(duskYesterday).inMinutes / 2).floor()));
  }
}
