import 'dart:math';
import 'package:prayers_calc/src/Prayers.dart';
import 'package:prayers_calc/src/func.dart';
import 'package:prayers_calc/src/Prayers.dart';
// import 'package:prayers_calc/src/Sunnah.dart';
// import 'package:prayers_calc/src/Durations.dart';

class Index {
  // PrayersStructure prayers;
  DateTime dawn;
  DateTime sunrise;
  DateTime midday;
  DateTime afternoon;
  DateTime sunset;
  DateTime dusk;
  DateTime midnight;
  DateTime lastThird;
  Prayers today;
  Prayers yesterday;
  Prayers tomorrow;
  Index prayers;

  Index(
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

    // Local dates needed for dst calc and local midnight past (0:00)
    DateTime dateLocal = DateTime(
        year ?? timestamp.year,
        month ?? timestamp.month,
        day ?? timestamp.day,
        12,
        0); // using noon of local date to avoid +- 1 hour
    // define now (local)
    DateTime now = DateTime.now();

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
    Prayers prayersToday = Prayers(
      timezone,
      lat,
      long,
      altitude,
      angle,
      today,
      dayOfYearToday,
      isLeap,
      adjustTime,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
      summerTimeCalc: summerTimeCalc ?? true,
    );

    Prayers prayersTomorrow = Prayers(
      timezone,
      lat,
      long,
      altitude,
      angle,
      tomorrow,
      dayOfYearTomorrow,
      isLeap,
      adjustTime,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
      summerTimeCalc: summerTimeCalc ?? true,
    );

    Prayers prayersYesterday = Prayers(
      timezone,
      lat,
      long,
      altitude,
      angle,
      yesterday,
      dayOfYearYesterday,
      isLeap,
      adjustTime,
      asrMethod: asrMethod,
      ishaAngle: ishaAngle,
      summerTimeCalc: summerTimeCalc ?? true,
    );
    print(
        '${prayersToday.sunset}, ${prayersTomorrow.sunset}, ${prayersYesterday.sunset}');
    // define components
    // this.prayers. set today;
    // this.prayers;
    // this.prayers.today = prayersToday;
    this.prayers =
        Index.prayers(prayersToday, prayersTomorrow, prayersYesterday);
  }

  Index.prayers(
      Prayers prayersToday, Prayers prayersTomorrow, Prayers prayersYesterday) {
    today = prayersToday;
    tomorrow = prayersTomorrow;
    yesterday = prayersYesterday;
  }
}
