# Dart Example

Example dart app showing how to use adhan_dart.

```dart
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:adhan_dart/adhan_dart.dart';

void main() {
  tz.initializeTimeZones();
  final location = tz.getLocation('America/New_York');

  // Definitions
  DateTime date = tz.TZDateTime.from(DateTime.now(), location);
  Coordinates coordinates = const Coordinates(35.78056, -78.6389);

  // Parameters
  CalculationParameters params = CalculationMethodParameters.muslimWorldLeague()
    ..madhab = Madhab.hanafi;
  PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: params,
      precision: true);

  // Prayer times (convert from UTC to local timezone)
  DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr, location);
  DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise, location);
  DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr, location);
  DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr, location);
  DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib, location);
  DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha, location);

  // Previous day's Isha and next day's Fajr
  DateTime ishaBeforeTime = tz.TZDateTime.from(prayerTimes.ishaBefore, location);
  DateTime fajrAfterTime = tz.TZDateTime.from(prayerTimes.fajrAfter, location);

  // Convenience Utilities
  Prayer current = prayerTimes.currentPrayer(date: DateTime.now());
  DateTime currentPrayerTime = prayerTimes.timeForPrayer(current);
  Prayer next = prayerTimes.nextPrayer();
  DateTime nextPrayerTime = prayerTimes.timeForPrayer(next);

  // Sunnah Times
  SunnahTimes sunnahTimes = SunnahTimes(prayerTimes);
  DateTime middleOfTheNight =
      tz.TZDateTime.from(sunnahTimes.middleOfTheNight, location);
  DateTime lastThirdOfTheNight =
      tz.TZDateTime.from(sunnahTimes.lastThirdOfTheNight, location);

  // Qibla Direction
  var qiblaDirection = Qibla.qibla(coordinates);

  print('***** Prayer Times');
  print('Fajr:    $fajrTime');
  print('Sunrise: $sunriseTime');
  print('Dhuhr:   $dhuhrTime');
  print('Asr:     $asrTime');
  print('Maghrib: $maghribTime');
  print('Isha:    $ishaTime');

  print('\n***** Current & Next Prayer');
  print('Current: $current at $currentPrayerTime');
  print('Next:    $next at $nextPrayerTime');

  print('\n***** Sunnah Times');
  print('Middle of the Night:    $middleOfTheNight');
  print('Last Third of the Night: $lastThirdOfTheNight');

  print('\n***** Qibla Direction');
  print('Qibla: $qiblaDirection°');
}
```

## Using without timezone package

If you don't want to add the timezone package, you can use timezone offsets directly:

```dart
import 'package:adhan_dart/adhan_dart.dart';

void main() {
  Coordinates coordinates = const Coordinates(24.8607, 67.0011);
  CalculationParameters params = CalculationMethodParameters.karachi();
  PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: DateTime.now(),
      calculationParameters: params);

  // Add your timezone offset manually (e.g., +5 hours for Pakistan)
  int offsetMinutes = 5 * 60;
  print('Fajr: ${prayerTimes.fajr.add(Duration(minutes: offsetMinutes))}');
  print('Dhuhr: ${prayerTimes.dhuhr.add(Duration(minutes: offsetMinutes))}');
}
```

## Available Calculation Methods

```dart
CalculationMethodParameters.muslimWorldLeague()
CalculationMethodParameters.egyptian()
CalculationMethodParameters.karachi()
CalculationMethodParameters.ummAlQura()
CalculationMethodParameters.dubai()
CalculationMethodParameters.qatar()
CalculationMethodParameters.kuwait()
CalculationMethodParameters.moonsightingCommittee()
CalculationMethodParameters.singapore()
CalculationMethodParameters.turkiye()
CalculationMethodParameters.tehran()
CalculationMethodParameters.northAmerica()
CalculationMethodParameters.morocco()
CalculationMethodParameters.other() // for custom angles
```
