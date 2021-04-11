import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:adhan_dart/adhan_dart.dart';

main() {
  tz.initializeTimeZones();
  final location = tz.getLocation('America/New_York');

  // Definitions
  DateTime date = tz.TZDateTime.from(DateTime.now(), location);
  Coordinates coordinates = Coordinates(35.78056, -78.6389);

  // Parameters
  CalculationParameters params = CalculationMethod.MuslimWorldLeague();
  params.madhab = Madhab.Hanafi;
  PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params);

  // Prayer times
  DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr!, location);
  DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise!, location);
  DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr!, location);
  DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr!, location);
  DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib!, location);
  DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha!, location);

  // Convenience Utilities
  String current =
      prayerTimes.currentPrayer(date: DateTime.now()); // date: date
  DateTime currentPrayerTime =
      tz.TZDateTime.from(prayerTimes.timeForPrayer(current)!, location);
  String next = prayerTimes.nextPrayer();
  DateTime nextPrayerTime =
      tz.TZDateTime.from(prayerTimes.timeForPrayer(next)!, location);

  // Sunnah Times
  SunnahTimes sunnahTimes = SunnahTimes(prayerTimes);
  DateTime middleOfTheNight =
      tz.TZDateTime.from(sunnahTimes.middleOfTheNight, location);
  DateTime lastThirdOfTheNight =
      tz.TZDateTime.from(sunnahTimes.lastThirdOfTheNight, location);

  // Qibla Direction
  var qiblaDirection = Qibla.qibla(coordinates);

  print('***** Current Time');
  print('local time:\t$date');

  print('\n***** Prayer Times');
  print('fajrTime:\t$fajrTime');
  print('sunriseTime:\t$sunriseTime');
  print('dhuhrTime:\t$dhuhrTime');
  print('asrTime:\t$asrTime');
  print('maghribTime:\t$maghribTime');
  print('ishaTime:\t$ishaTime');

  print('\n***** Convenience Utilities');
  print('current:\t$current\t$currentPrayerTime');
  print('next:   \t$next\t$nextPrayerTime');

  print('\n***** Sunnah Times');
  print('middleOfTheNight:  \t$middleOfTheNight');
  print('lastThirdOfTheNight:  \t$lastThirdOfTheNight');

  print('\n***** Qibla Direction');
  print('qibla:  \t$qiblaDirection');
}
// main() => timetableTest();
