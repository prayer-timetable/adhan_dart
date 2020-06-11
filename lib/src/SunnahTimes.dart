import 'package:adhan/src/PrayerTimes.dart';
import 'package:adhan/src/DateUtils.dart';

class SunnahTimes {
  DateTime middleOfTheNight;
  DateTime lastThirdOfTheNight;

  SunnahTimes(PrayerTimes prayerTimes, {precision: true}) {
    DateTime date = prayerTimes.date;
    DateTime nextDay = dateByAddingDays(date, 1);
    PrayerTimes nextDayPrayerTimes = new PrayerTimes(
        prayerTimes.coordinates, nextDay, prayerTimes.calculationParameters,
        precision: precision);

    Duration nightDuration =
        (nextDayPrayerTimes.fajr.difference(prayerTimes.maghrib));

    this.middleOfTheNight = roundedMinute(
        dateByAddingSeconds(
            prayerTimes.maghrib, (nightDuration.inSeconds / 2).floor()),
        precision: precision);
    this.lastThirdOfTheNight = roundedMinute(
        dateByAddingSeconds(
            prayerTimes.maghrib, (nightDuration.inSeconds * (2 / 3)).floor()),
        precision: precision);
  }
}
