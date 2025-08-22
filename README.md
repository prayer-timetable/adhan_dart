# Adhan Dart

Adhan Dart is a port of excellent [Adhan JavaScript](https://github.com/batoulapps/adhan-js). Ported to Dart, preserving the calculation logic. Adapted to use Dart's superior DateTime class for quick and convenient time calculations. No extra dependencies (_timezone_ package used for tests, in your code you can use timezone offset instead).

Adhan Dart is a well tested and well documented library for calculating Islamic prayer times in Dart.

All astronomical calculations are high precision equations directly from the book [“Astronomical Algorithms” by Jean Meeus](https://www.willbell.com/math/mc1.htm). This book is recommended by the Astronomical Applications Department of the U.S. Naval Observatory and the Earth System Research Laboratory of the National Oceanic and Atmospheric Administration.

Implementations of Adhan (JavaScript only for now) in other languages can be found in the original repo [Adhan](https://github.com/batoulapps/Adhan).

## Another Adhan package?

There are other 'adhan' packages available in this repository. This one is like-for-like port of tried and tested JS repo mentioned above. Several aspects are adjusted to take advantage of Dart's features and some functionality added in the process. For example, `prayerTimes.currentPrayer()` will not return null in case the time is after midnight and before fajr; rather it will return 'ishabefore', isha prayer of the day before. Likewise `prayerTimes.nextPrayer()` will return 'fajrafter' - meaning fajr prayer for the day after.

Another addition is 'precise: true' parameter for prayer calculations. On absence of this parameter, the time returned will be rounded to the nearest minute; having precision as a parameter will return second-precision DateTime value. For example: `PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params, precision: true);`.

## Installation

Adhan was designed to work be easy to import to any Dart or Flutter project.

Insert under dependencies in your pubspec.yaml file:

```
  adhan_dart: ^1.1.1
```

Or use the latest dev version:

```
  adhan_dart:
    git:
      url: git://github.com/prayer-timetable/adhan_dart.git
```

### Import

```
import 'package:adhan_dart/adhan_dart.dart';
```

## Usage

To get prayer times initialize a new `PrayerTimes` object passing in coordinates,
date, and calculation parameters.

```dart
PrayerTimes prayerTimes = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params, precision: true);
```

### Initialization parameters

#### Coordinates

Create a `Coordinates` object with the latitude and longitude for the location
you want prayer times for.

```dart
Coordinates coordinates = const Coordinates(35.78056, -78.6389);
```

#### Date

The date parameter passed in should be an instance of the Dart `DateTime`
object. The year, month, and day values can be populated. The year, month and day values should be for the date that you want prayer times for. These date values are expected to be for the
Gregorian calendar.

```dart
DateTime date = DateTime.now(); // this is default
DateTime date = DateTime(2015, 11, 1); // set specific date
```

#### Calculation parameters

The rest of the needed information is contained within the `CalculationParameters` object.
Instead of manually initializing this object it is recommended to use one of the pre-populated
objects in the `CalculationMethod` object. You can then further
customize the calculation parameters if needed.

```dart
CalculationParameters params = CalculationMethodParameters.muslimWorldLeague();
params.madhab = Madhab.hanafi;
params.adjustments[Prayer.fajr] = 2;
```

| Property         | Description                                                                                         |
| ---------------- | --------------------------------------------------------------------------------------------------- |
| method           | CalculationMethod name                                                                              |
| fajrAngle        | Angle of the sun used to calculate Fajr                                                             |
| ishaAngle        | Angle of the sun used to calculate Isha                                                             |
| ishaInterval     | Minutes after Maghrib (if set, the time for Isha will be Maghrib plus ishaInterval)                 |
| madhab           | Value from the Madhab object, used to calculate Asr                                                 |
| highLatitudeRule | Value from the HighLatitudeRule object, used to set a minimum time for Fajr and a max time for Isha |
| adjustments      | Object with custom prayer time adjustments (in minutes) for each prayer time                        |

#### CalculationMethod

| Value                                     | Description                                                                                                                                                                                                                                                                                                     |
| ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CalculationMethodParameters.muslimWorldLeague()     | Muslim World League. Standard Fajr time with an angle of 18°. Earlier Isha time with an angle of 17°.                                                                                                                                                                                                           |
| CalculationMethodParameters.egyptian()              | Egyptian General Authority of Survey. Early Fajr time using an angle 19.5° and a slightly earlier Isha time using an angle of 17.5°.                                                                                                                                                                            |
| CalculationMethodParameters.karachi()               | University of Islamic Sciences, Karachi. A generally applicable method that uses standard Fajr and Isha angles of 18°.                                                                                                                                                                                          |
| CalculationMethodParameters.ummAlQura()             | Umm al-Qura University, Makkah. Uses a fixed interval of 90 minutes from maghrib to calculate Isha. And a slightly earlier Fajr time with an angle of 18.5°. _Note: you should add a +30 minute custom adjustment for Isha during Ramadan._                                                                     |
| CalculationMethodParameters.dubai()                 | Used in the UAE. Slightly earlier Fajr time and slightly later Isha time with angles of 18.2° for Fajr and Isha in addition to 3 minute offsets for sunrise, Dhuhr, Asr, and Maghrib.                                                                                                                           |
| CalculationMethodParameters.qatar()                 | Same Isha interval as `ummAlQura` but with the standard Fajr time using an angle of 18°.                                                                                                                                                                                                                        |
| CalculationMethodParameters.kuwait()                | Standard Fajr time with an angle of 18°. Slightly earlier Isha time with an angle of 17.5°.                                                                                                                                                                                                                     |
| CalculationMethodParameters.moonsightingCommittee() | Method developed by Khalid Shaukat, founder of Moonsighting Committee Worldwide. Uses standard 18° angles for Fajr and Isha in addition to seasonal adjustment values. This method automatically applies the 1/7 approximation rule for locations above 55° latitude. Recommended for North America and the UK. |
| CalculationMethodParameters.singapore()             | Used in Singapore, Malaysia, and Indonesia. Early Fajr time with an angle of 20° and standard Isha time with an angle of 18°.                                                                                                                                                                                   |
| CalculationMethodParameters.turkiye()               | An approximation of the Diyanet method used in Turkey. This approximation is less accurate outside the region of Turkey.                                                                                                                                                                                        |
| CalculationMethodParameters.tehran()                | Institute of Geophysics, University of Tehran. Early Isha time with an angle of 14°. Slightly later Fajr time with an angle of 17.7°. Calculates Maghrib based on the sun reaching an angle of 4.5° below the horizon.                                                                                          |
| CalculationMethodParameters.northAmerica()          | Also known as the ISNA method. Can be used for North America, but the moonsightingCommittee method is preferable. Gives later Fajr times and early Isha times with angles of 15°.                                                                                                                               |
| CalculationMethodParameters.other()                 | Defaults to angles of 0°, should generally be used for making a custom method and setting your own values.                                                                                                                                                                                                      |

#### Madhab

| Value         | Description      |
| ------------- | ---------------- |
| Madhab.shafi  | Earlier Asr time |
| Madhab.hanafi | Later Asr time   |

#### HighLatitudeRule

| Value                              | Description                                                                                                                                                |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| HighLatitudeRule.middleOfTheNight  | Fajr will never be earlier than the middle of the night and Isha will never be later than the middle of the night                                          |
| HighLatitudeRule.seventhOfTheNight | Fajr will never be earlier than the beginning of the last seventh of the night and Isha will never be later than the end of the first seventh of the night |
| HighLatitudeRule.twilightAngle     | Similar to SeventhOfTheNight, but instead of 1/7, the fraction of the night used is fajrAngle/60 and ishaAngle/60                                          |

### Prayer Times

Once the `PrayerTimes` object has been initialized it will contain values
for all five prayer times and the time for sunrise. The prayer times will be
DateTime object instances initialized with UTC values. You will then need to format
the times for the correct timezone. You can do that by using a timezone aware
date formatting library like _timezone_.

```dart
final timezone = tz.getLocation('America/New_York');
tz.TZDateTime.from(prayerTimes.fajr, timezone);
```

### Full Example

```dart
DateTime date = tz.TZDateTime.from(DateTime.now(), timezone);
final timezone = tz.getLocation('America/New_York');
Coordinates coordinates = const Coordinates(35.78056, -78.6389);
CalculationParameters params = CalculationMethodParameters.muslimWorldLeague()
  ..madhab = Madhab.hanafi;
PrayerTimes prayerTimes = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params, precision: true);

DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr, timezone);
DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise, timezone);
DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr, timezone);
DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr, timezone);
DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib, timezone);
DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha, timezone);
```

### Convenience Utilities

The `PrayerTimes` object has functions for getting the current prayer and the next prayer. You can also get the time for a specified prayer, making it
easier to dynamically show countdowns until the next prayer.

```dart
var prayerTimes = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params, precision: true);

var current = prayerTimes.currentPrayer(date: DateTime.now());
var next = prayerTimes.nextPrayer();
var nextPrayerTime = prayerTimes.timeForPrayer(next);
```

### Sunnah Times

The Adhan library can also calulate Sunnah times. Given an instance of `PrayerTimes`, you can get a `SunnahTimes` object with the times for Qiyam.

```dart
final timezone = tz.getLocation('America/New_York');
SunnahTimes sunnahTimes = SunnahTimes(prayerTimes);
DateTime middleOfTheNight =
    tz.TZDateTime.from(sunnahTimes.middleOfTheNight, timezone);
DateTime lastThirdOfTheNight =
    tz.TZDateTime.from(sunnahTimes.lastThirdOfTheNight, timezone);
```

### Qibla Direction

Get the direction, in degrees from North, of the Qibla from a given set of coordinates.

```dart
var coordinates = const Coordinates(35.78056, -78.6389);
var qiblaDirection = Qibla.qibla(coordinates);
```

## Contributing

Adhan is made publicly available to provide a well tested and well documented library for Islamic prayer times to all
developers. We accept feature contributions provided that they are properly documented and include the appropriate
unit tests. We are also looking for contributions in the form of unit tests of of prayer times for different
locations, we do ask that the source of the comparison values be properly documented.

## License

Adhan is available under the MIT license. See the LICENSE file for more info.
