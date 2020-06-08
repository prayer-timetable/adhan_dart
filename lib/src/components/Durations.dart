import 'package:prayer_calc/src/components/Prayers.dart';
import 'package:prayer_calc/src/func/helpers.dart';

class Durations {
  DateTime now;
  DateTime current;
  DateTime next;
  DateTime previous;
  bool isAfterIsha;
  int currentId;
  Duration countDown;
  Duration countUp;
  double percentage;

  Durations(
    DateTime _now,
    Prayers prayersToday,
    Prayers prayersTomorrow,
    Prayers prayersYesterday,
  ) {
    DateTime current;
    DateTime next;
    DateTime previous;
    int currentId;
    bool isAfterIsha = false;

    // now is local for PrayerTimetable and PrayerCalcAlt
    // utc for PrayerCalc
    /* *********************** */
    /* CURRENT, PREVIOUS, NEXT */
    /* *********************** */
    // from midnight to fajr
    if (_now.isBefore(prayersToday.dawn)) {
      current = prayersYesterday.dusk;
      next = prayersToday.dawn;
      previous = prayersYesterday.sunset;
      currentId = 5;
    } else if (_now.isBefore(prayersToday.sunrise)) {
      current = prayersToday.dawn;
      next = prayersToday.sunrise;
      previous = prayersYesterday.dusk;
      currentId = 0;
    } else if (_now.isBefore(prayersToday.midday)) {
      current = prayersToday.sunrise;
      next = prayersToday.midday;
      previous = prayersToday.dawn;
      currentId = 1;
    } else if (_now.isBefore(prayersToday.afternoon)) {
      current = prayersToday.midday;
      next = prayersToday.afternoon;
      previous = prayersToday.sunrise;
      currentId = 2;
    } else if (_now.isBefore(prayersToday.sunset)) {
      current = prayersToday.afternoon;
      next = prayersToday.sunset;
      previous = prayersToday.midday;
      currentId = 3;
    } else if (_now.isBefore(prayersToday.dusk)) {
      current = prayersToday.sunset;
      next = prayersToday.dusk;
      previous = prayersToday.afternoon;
      currentId = 4;
    } else {
      // dusk till midnight
      current = prayersToday.dusk;
      next = prayersTomorrow.dawn;
      previous = prayersToday.sunset;
      currentId = 5;
      isAfterIsha = true;
    }

    // components
    this.now = _now;
    this.current = current;
    this.next = next;
    this.previous = previous;
    this.isAfterIsha = isAfterIsha;
    this.currentId = currentId;
    this.countDown = next.difference(_now);
    this.countUp = _now.difference(current);
    this.percentage = round2Decimals(100 *
        (this.countUp.inSeconds /
            (this.countDown.inSeconds + this.countUp.inSeconds)));
    //end
  }
}
