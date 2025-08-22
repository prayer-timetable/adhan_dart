import 'package:adhan_dart/adhan_dart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// During Isha prayer, currentPrayer returns Isha, but nextPrayer returns fajrAfter.
///
/// After Midnight, currentPrayer returns IshaBefore, but nextPrayer returns fajr.
///
/// The latter will persist until the next fajr prayer.
void main() {
  tz.initializeTimeZones();
  // final location = tz.getLocation('America/New_York');
  final location = tz.getLocation('Asia/Riyadh');

  // Definitions
  DateTime date = tz.TZDateTime.from(DateTime.now(), location);
  // set the time of date to 11:45 PM

  final yesterday = date
      .copyWith(hour: 23, minute: 00, second: 0)
      .subtract(const Duration(days: 1));

  // current time in readable format
  print('Current Time: ${date.hour}:${date.minute}');
  print('Yesterday Time: ${yesterday.hour}:${yesterday.minute}');
  // Coordinates coordinates = Coordinates(35.78056, -78.6389);
  Coordinates coordinates = const Coordinates(24.469874, 39.556430);

  const cords = Coordinates(-39.231, 12.412);
  print(Qibla.qibla(cords));

  // Parameters
  CalculationParameters params = CalculationMethodParameters.ummAlQura();
  // params.madhab = Madhab.shafi;
  // params.highLatitudeRule = HighLatitudeRule.seventhOfTheNight;
  PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: params,
      precision: true);

  SunnahTimes sunnahTimes = SunnahTimes(prayerTimes);

  print(prayerTimes.currentPrayer(date: date));
  print(prayerTimes.nextPrayer(date: yesterday));
  print(sunnahTimes.middleOfTheNight.toLocal());
  print(sunnahTimes.lastThirdOfTheNight.toLocal());
}
