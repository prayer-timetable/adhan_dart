import 'package:prayer_calc/src/classes/PrayerTimes.dart';
import 'package:prayer_calc/src/classes/DateUtils.dart';

class SunnahTimes {
  DateTime midnight;
  DateTime lastThird;

  SunnahTimes(PrayerTimes prayerTimes, {precision: true}) {
    DateTime date = prayerTimes.date;
    DateTime nextDay = dateByAddingDays(date, 1);
    PrayerTimes nextDayPrayerTimes = new PrayerTimes(
        prayerTimes.coordinates, nextDay, prayerTimes.calculationParameters,
        precision: precision);

    Duration nightDuration =
        (nextDayPrayerTimes.fajr.difference(prayerTimes.maghrib));

    this.midnight = roundedMinute(
        dateByAddingSeconds(
            prayerTimes.maghrib, (nightDuration.inSeconds / 2).floor()),
        precision: precision);
    this.lastThird = roundedMinute(
        dateByAddingSeconds(
            prayerTimes.maghrib, (nightDuration.inSeconds * (2 / 3)).floor()),
        precision: precision);
  }
}
