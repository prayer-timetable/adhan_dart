import 'package:prayer_calc/src/Sunnah.dart';
import 'package:prayer_calc/src/Prayers.dart';
import 'package:prayer_calc/src/func/helpers.dart';
import 'package:prayer_calc/src/Durations.dart';
import 'package:prayer_calc/src/func/prayerVaktija.dart';

class PrayerVaktija {
  // PrayersStructure prayers;
  Prayers today;
  Prayers yesterday;
  Prayers tomorrow;
  PrayerVaktija prayers;
  Sunnah sunnah;
  Durations durations;

  PrayerVaktija({
    int year,
    int month,
    int day,
    List timetable,
    List<int> difference,
    int hijriOffset,
    bool summerTimeCalc: true,
  }) {
    print(timetable);
    print(year);

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
    Prayers prayersToday = prayersVaktija(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, -0, 0],
      hijriOffset: hijriOffset ?? 0,
    );

    Prayers prayersTomorrow = prayersVaktija(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, -0, 0],
      hijriOffset: hijriOffset ?? 0,
    );

    Prayers prayersYesterday = prayersVaktija(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, -0, 0],
      hijriOffset: hijriOffset ?? 0,
    );

    // define components
    this.prayers =
        PrayerVaktija.prayers(prayersToday, prayersTomorrow, prayersYesterday);

    this.sunnah =
        Sunnah(nowLocal, prayersToday, prayersTomorrow, prayersYesterday);

    this.durations = Durations(
        nowLocal, nowUtc, prayersToday, prayersTomorrow, prayersYesterday);

    //end
  }

  PrayerVaktija.prayers(
      Prayers prayersToday, Prayers prayersTomorrow, Prayers prayersYesterday) {
    today = prayersToday;
    tomorrow = prayersTomorrow;
    yesterday = prayersYesterday;
  }
}
