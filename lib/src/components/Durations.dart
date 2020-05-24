import 'package:prayer_calc/src/components/Prayers.dart';

class Durations {
  DateTime nowLocal;
  DateTime current;
  DateTime next;
  DateTime previous;
  bool isAfterIsha;
  int currentId;
  Duration countDown;
  Duration countUp;

  Durations(
    DateTime _nowLocal,
    Prayers prayersToday,
    Prayers prayersTomorrow,
    Prayers prayersYesterday,
  ) {
    DateTime current;
    DateTime next;
    DateTime previous;
    int currentId;
    bool isAfterIsha = false;

    // now is local
    /* *********************** */
    /* CURRENT, PREVIOUS, NEXT */
    /* *********************** */
    // from midnight to fajr
    if (_nowLocal.isBefore(prayersToday.dawn)) {
      current = prayersYesterday.dusk;
      next = prayersToday.dawn;
      previous = prayersYesterday.sunset;
      currentId = 5;
    } else if (_nowLocal.isBefore(prayersToday.sunrise)) {
      current = prayersToday.dawn;
      next = prayersToday.sunrise;
      previous = prayersYesterday.dusk;
      currentId = 0;
    } else if (_nowLocal.isBefore(prayersToday.midday)) {
      current = prayersToday.sunrise;
      next = prayersToday.midday;
      previous = prayersYesterday.dusk;
      currentId = 1;
    } else if (_nowLocal.isBefore(prayersToday.afternoon)) {
      current = prayersToday.midday;
      next = prayersToday.afternoon;
      previous = prayersYesterday.dusk;
      currentId = 2;
    } else if (_nowLocal.isBefore(prayersToday.sunset)) {
      current = prayersToday.afternoon;
      next = prayersToday.sunset;
      previous = prayersYesterday.dusk;
      currentId = 3;
    } else if (_nowLocal.isBefore(prayersToday.dusk)) {
      current = prayersToday.sunset;
      next = prayersToday.dusk;
      previous = prayersYesterday.dusk;
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
    this.nowLocal = _nowLocal;
    this.current = current;
    this.next = next;
    this.previous = previous;
    this.isAfterIsha = isAfterIsha;
    this.currentId = currentId;
    this.countDown = next.difference(_nowLocal);
    this.countUp = _nowLocal.difference(current);
    //end
  }
}
