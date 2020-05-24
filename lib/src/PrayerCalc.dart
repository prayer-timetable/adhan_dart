import 'package:prayer_calc/src/Sunnah.dart';
import 'package:prayer_calc/src/Prayers.dart';
import 'package:prayer_calc/src/func/helpers.dart';
import 'package:prayer_calc/src/Durations.dart';
import 'package:prayer_calc/src/func/prayerAngle.dart';

class PrayerCalc {
  // PrayersStructure prayers;
  Prayers today;
  Prayers yesterday;
  Prayers tomorrow;
  PrayerCalc prayers;
  Sunnah sunnah;
  Durations durations;

  PrayerCalc(
    int timezone,
    double lat,
    double long,
    double altitude,
    double angle, {
    int year,
    int month,
    int day,
    int asrMethod,
    double ishaAngle,
    bool summerTimeCalc: true,
  }) {
    DateTime timestamp = DateTime.now().toUtc();
    DateTime beginingOfYear = DateTime.utc(timestamp.year); // Jan 1, 0:00

    // UTC date
    DateTime date = DateTime.utc(year ?? timestamp.year,
        month ?? timestamp.month, day ?? timestamp.day, 0, 0);
    DateTime nowUtc = DateTime.now().toUtc();

    // Local dates needed for dst calc and local midnight past (0:00)
    DateTime dateLocal = DateTime(
        year ?? timestamp.year,
        month ?? timestamp.month,
        day ?? timestamp.day,
        12,
        0); // using noon of local date to avoid +- 1 hour
    // define now (local)
    DateTime nowLocal = DateTime.now();

    // ***** tomorrow and yesterday
    DateTime today = date;
    DateTime tomorrow = date.add(Duration(days: 1));
    DateTime yesterday = date.subtract(Duration(days: 1));

    // check if leap year
    bool isLeap = date.year % 4 == 0;

    // adjust times for dst
    int adjustDST = summerTimeCalc && isDSTCalc(dateLocal) ? 1 : 0;
    Duration adjustTime = Duration(hours: adjustDST);

    //	Day of Year
    // date needs to be utc for accurate calculation
    int dayOfYearToday = today.difference(beginingOfYear).inDays;
    int dayOfYearTomorrow = tomorrow.difference(beginingOfYear).inDays;
    int dayOfYearYesterday = yesterday.difference(beginingOfYear).inDays;

    // ***** PRAYERS
    Prayers prayersToday = prayersAngle(
      timezone: timezone,
      lat: lat,
      long: long,
      altitude: altitude,
      angle: angle,
      date: today,
      dayOfYear: dayOfYearToday,
      isLeap: isLeap,
      adjustTime: adjustTime,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
      summerTimeCalc: summerTimeCalc ?? true,
    );

    Prayers prayersTomorrow = prayersAngle(
      timezone: timezone,
      lat: lat,
      long: long,
      altitude: altitude,
      angle: angle,
      date: tomorrow,
      dayOfYear: dayOfYearTomorrow,
      isLeap: isLeap,
      adjustTime: adjustTime,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
      summerTimeCalc: summerTimeCalc ?? true,
    );

    Prayers prayersYesterday = prayersAngle(
      timezone: timezone,
      lat: lat,
      long: long,
      altitude: altitude,
      angle: angle,
      date: yesterday,
      dayOfYear: dayOfYearYesterday,
      isLeap: isLeap,
      adjustTime: adjustTime,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
      summerTimeCalc: summerTimeCalc ?? true,
    );

    // define components
    this.prayers =
        PrayerCalc.prayers(prayersToday, prayersTomorrow, prayersYesterday);

    this.sunnah =
        Sunnah(nowLocal, prayersToday, prayersTomorrow, prayersYesterday);

    this.durations =
        Durations(nowLocal, prayersToday, prayersTomorrow, prayersYesterday);

    //end
  }

  PrayerCalc.prayers(
      Prayers prayersToday, Prayers prayersTomorrow, Prayers prayersYesterday) {
    today = prayersToday;
    tomorrow = prayersTomorrow;
    yesterday = prayersYesterday;
  }
}
