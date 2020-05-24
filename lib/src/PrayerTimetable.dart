import 'package:prayer_calc/src/components/Sunnah.dart';
import 'package:prayer_calc/src/components/Prayers.dart';
import 'package:prayer_calc/src/components/Durations.dart';
import 'package:prayer_calc/src/func/prayerTimetable.dart';

class PrayerTimetable {
  // PrayersStructure prayers;
  Prayers current;
  Prayers previous;
  Prayers next;
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

    // ***** current, next and previous
    DateTime current = date;
    DateTime next = date.add(Duration(days: 1));
    DateTime previous = date.subtract(Duration(days: 1));

    // ***** today, tomorrow and yesterday
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));
    DateTime yesterday = today.subtract(Duration(days: 1));

    // ***** PRAYERS CURRENT, NEXT, PREVIOUS
    Prayers prayersCurrent = prayerTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: current,
    );

    Prayers prayersNext = prayerTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: next,
    );

    Prayers prayersPrevious = prayerTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: previous,
    );

    // ***** PRAYERS TODAY, TOMORROW, YESTERDAY
    Prayers prayersToday = prayerTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: today,
    );

    Prayers prayersTomorrow = prayerTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: tomorrow,
    );

    Prayers prayersYesterday = prayerTimetable(
      timetable: timetable,
      difference: difference ?? [0, 0, 0, 0, 0, 0],
      hijriOffset: hijriOffset ?? 0,
      date: yesterday,
    );

    // define components
    this.prayers =
        PrayerTimetable.prayers(prayersCurrent, prayersNext, prayersPrevious);

    this.sunnah =
        Sunnah(nowLocal, prayersCurrent, prayersNext, prayersPrevious);

    this.durations =
        Durations(nowLocal, prayersToday, prayersTomorrow, prayersYesterday);

    //end
  }

  PrayerTimetable.prayers(
      Prayers prayersCurrent, Prayers prayersNext, Prayers prayersPrevious) {
    current = prayersCurrent;
    next = prayersNext;
    previous = prayersPrevious;
  }
}
