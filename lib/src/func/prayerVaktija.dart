import 'package:prayer_calc/src/Prayers.dart';
import 'package:prayer_calc/src/func/helpers.dart';

/* *********************** */
/* MAIN FUNCTION           */
/* *********************** */
Prayers prayersVaktija({
  List timetable,
  List difference,
  int hijriOffset,
}) {
  print(timetable);

  /* *********************** */
  /* TIMES                   */
  /* *********************** */

  DateTime now = DateTime.now();

  /* *********************** */
  /* PRAYER LISTS            */
  /* *********************** */

  List<DateTime> prayerTimes = [];

  List prayerCount = Iterable<int>.generate(6).toList();

  prayerCount.forEach((prayerId) {
    DateTime timeToday = convertToDateTime(
            timetable[now.month - 1][now.day - 1][prayerId],
            offset: 0)
        .add(Duration(seconds: difference[prayerId]));

    // bool isNext = false;//TODO

    // DateTime time, int id, bool hasPassed, String name, String when, bool isNext,
    prayerTimes.insert(
      prayerId,
      timeToday,
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
