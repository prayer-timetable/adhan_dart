import 'package:adhan_dart/src/DateUtils.dart';
import 'package:adhan_dart/src/PrayerTimes.dart';

/// A class that contains the value of some sunnah times which are:
/// - Middle of the Night
/// - Last Third of the Night
///
/// Example:
/// ```dart
/// final sunnahTimes = SunnahTimes(prayerTimes);
/// // for precise times, set precision to true
/// final sunnahTimes = SunnahTimes(prayerTimes, precision: true);
/// print(sunnahTimes.middleOfTheNight);
/// print(sunnahTimes.lastThirdOfTheNight);
/// ```
class SunnahTimes {
  late DateTime middleOfTheNight;
  late DateTime lastThirdOfTheNight;

  SunnahTimes(PrayerTimes prayerTimes, {bool precision = true}) {
    DateTime date = prayerTimes.date;
    DateTime nextDay = dateByAddingDays(date, 1);
    PrayerTimes nextDayPrayerTimes = PrayerTimes(
        coordinates: prayerTimes.coordinates,
        date: nextDay,
        calculationParameters: prayerTimes.calculationParameters,
        precision: precision);

    Duration nightDuration =
        (nextDayPrayerTimes.fajr.difference(prayerTimes.maghrib));

    middleOfTheNight = roundedMinute(
        dateByAddingSeconds(
            prayerTimes.maghrib, (nightDuration.inSeconds / 2).floor()),
        precision: precision);
    lastThirdOfTheNight = roundedMinute(
        dateByAddingSeconds(
            prayerTimes.maghrib, (nightDuration.inSeconds * (2 / 3)).floor()),
        precision: precision);
  }
}
