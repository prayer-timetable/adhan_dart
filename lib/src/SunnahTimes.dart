import 'dart:math';
import 'package:prayer_calc/src/PrayerCalc.dart';

class SunnahTimes {
  DateTime midnight;
  DateTime lastThird;

  SunnahTimes(
    double lat,
    double long,
    double altitude,
    double angle,
    int timezone, {
    DateTime date,
    int asrMethod,
    double ishaAngle,
  }) {
    // ***** tomorrow and yesterday
    DateTime tomorrow = date.add(Duration(days: 1));
    DateTime yesterday = date.subtract(Duration(days: 1));

    PrayerCalc prayersToday = PrayerCalc(
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

    PrayerCalc prayersTomorrow = PrayerCalc(
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

    PrayerCalc prayersYesterday = PrayerCalc(
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
            (prayersTomorrow.dawn.difference(prayersToday.dusk).inMinutes / 2)
                .floor()));
  }
}
