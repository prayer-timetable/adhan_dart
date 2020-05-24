import 'package:prayer_calc/src/components/Prayers.dart';
import 'package:prayer_calc/src/func/helpers.dart';

/* *********************** */
/* MAIN FUNCTION           */
/* *********************** */
Prayers prayerTimetable({
  List timetable,
  List difference,
  int hijriOffset,
  DateTime date,
}) {
  /* *********************** */
  /* TIMES                   */
  /* *********************** */

  // print('###');
  // print(date);
  DateTime timestamp = date ?? DateTime.now();

  // check if leap year
  // bool isLeap = date.year % 4 == 0;

  /* *********************** */
  /* PRAYER LISTS            */
  /* *********************** */

  List<DateTime> prayerTimes = [];

  List prayerCount = Iterable<int>.generate(6).toList();

  prayerCount.forEach((prayerId) {
    DateTime prayerTime = secondsToDateTime(
            timetable[timestamp.month - 1][timestamp.day - 1][prayerId],
            timestamp,
            offset: 0)
        .add(Duration(seconds: difference[prayerId]));

    // bool isNext = false;//TODO

    // DateTime time, int id, bool hasPassed, String name, String when, bool isNext,
    prayerTimes.insert(
      prayerId,
      prayerTime,
    );
  });

  // next prayer - add isNext
  // prayersList[next.id].isNext = true;//TODO

  Prayers prayers = new Prayers();
  prayers.dawn = prayerTimes[0];
  prayers.sunrise = prayerTimes[1];
  prayers.midday = prayerTimes[2];
  prayers.afternoon = prayerTimes[3];
  prayers.sunset = prayerTimes[4];
  prayers.dusk = prayerTimes[5];

  return prayers;
}

//export { prayersCalc, dayCalc }
