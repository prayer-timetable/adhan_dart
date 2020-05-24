import 'package:prayer_calc/src/components/Sunnah.dart';
import 'package:prayer_calc/src/components/Prayers.dart';
import 'package:prayer_calc/src/components/Durations.dart';
import 'package:prayer_calc/src/func/prayerTimetable.dart';

class PrayerTimetable {
  // PrayersStructure prayers;
  Prayers today;
  Prayers yesterday;
  Prayers tomorrow;
  PrayerTimetable prayers;
  Sunnah sunnah;
  Durations durations;

  PrayerTimetable({
    int year,
    int month,
    int day,
    List timetable,
    List<int> difference,
    int hijriOffset,
    bool summerTimeCalc: true,
  }) {
    DateTime timestamp = DateTime.now();
    DateTime beginingOfYear = DateTime(timestamp.year); // Jan 1, 0:00

    // Local date
    DateTime date = DateTime(year ?? timestamp.year, month ?? timestamp.month,
        day ?? timestamp.day, 0, 0);

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

    // ***** PRAYERS
    Prayers prayersToday = prayersTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: today,
    );

    Prayers prayersTomorrow = prayersTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: tomorrow,
    );

    Prayers prayersYesterday = prayersTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: yesterday,
    );

    // define components
    this.prayers = PrayerTimetable.prayers(
        prayersToday, prayersTomorrow, prayersYesterday);

    this.sunnah =
        Sunnah(nowLocal, prayersToday, prayersTomorrow, prayersYesterday);

    this.durations =
        Durations(nowLocal, prayersToday, prayersTomorrow, prayersYesterday);

    //end
  }

  PrayerTimetable.prayers(
      Prayers prayersToday, Prayers prayersTomorrow, Prayers prayersYesterday) {
    today = prayersToday;
    tomorrow = prayersTomorrow;
    yesterday = prayersYesterday;
  }
}
