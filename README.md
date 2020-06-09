# Dart Prayer Calc Library

Library for calculating muslim prayer times based on excellent [Adhan JavaScript](https://github.com/batoulapps/adhan-js). Ported to Dart, preserving the calculation logic. Adapted to use Dart's superior DateTime class for quick and convenient time calculations.

> All astronomical calculations are high precision equations directly from the book [“Astronomical Algorithms”](http://www.willbell.com/math/mc1.htm) by Jean Meeus. This book is recommended by the Astronomical Applications Department of the U.S. Naval Observatory and the Earth System Research Laboratory of the National Oceanic and Atmospheric Administration.

# Dart Classes

## PrayerCalc

This class returns 5 daily prayers plus Sunrise. Takes the following input parameters:

- _int_ **timezone**,
- _double_ **latitude**,
- _double_ **longitude**,
- _double_ **angle**

Optional parameters:

- _int_ **year**,
- _int_ **month**,
- _int_ **day**,
- _int_ **hour**,
- _int_ **minute**,
- _int_ **second**,
- _int_ **asrMethod**: 1,
- _double_ **ishaAngle**,
- _bool_ **summerTimeCalc**: true,
- _DateTime_ **time**,
- _double_ **altitude**,
- _bool_ **precision**: true,

**Some notes**:

- if no date is used, the library uses current date and time
- **asrMethod** defaults to 1 (_Shafi_), 2 would mean _Hanafi_
- **ishaAngle** would default to _angle_, in other words if ishaAngle is not used, _angle_ value would be used for both dusk and dawn
- **summerTimeCalc** is true by default, optionally it can be forced to false (no hour adjustments)
- **time** is used for calculation of **now** as per below, otherwise current time is used
- **altitude** currently not used
- **precision** enables the display of seconds, otherwise if false, output times are rounded to nearest minute

This class returns **_prayers_**, **_durations_**, **_sunnah_** and **_qibla_** classes.

## Prayers

This class returns the following:

- _DateTime_ **now** - current time at the location
- _DateTime_ **current** - current prayer time
- _DateTime_ **next** - next prayer time
- _DateTime_ **previous** - previous prayer time
- _bool_ **isAfterIsha** - is the current time after isha and before the midnight
- _int_ **currentId** - id of the current prayer/time (0 - 5)

Each of the **current**, **next** and **previous** returns 6 prayer times (ie. current.sunrise):

- _DateTime_ **dawn** - fajr prayer time
- _DateTime_ **sunrise** - shurooq time
- _DateTime_ **midday** - dhuhr prayer time
- _DateTime_ **afternoon** - asr prayer time
- _DateTime_ **sunset** - maghrib prayer time
- _DateTime_ **dusk** - isha prayer time

## Durations

This class calculates durations to and from the prayers, taking into account next day Dawn for Isha prayer, as well as Previous day Isha when calculating Dawn for day after midnight. It also determines current, next and previous prayers based on current time. It returns the following:

- _Duration_ **countDown** - time until the next prayer
- _Duration_ **countUp** - time passed since the current prayer begun
- _double_ **percentage**: percentage of time passed between current and next prayer

## Sunnah

This class calculates times that apply to certain sunnah-defined times. It provides the following:

- _DateTime_ **midnight** - mid-point between the Sunset-Maghrib and Dawn-Fajr
- _DateTime_ **lastThird** - as above, time indicating the beginning of the last third of the night

## Qibla

Class returning single value:

- _double_ **qibla** - direction (bearing) to Qibla, in degrees

## Installation

Add to your pubspec.yaml file:

```
  prayer_calc:
    git:
      url: git://github.com/prayer-timetable/prayer_calc_dart.git
```

## Example

```
      int timezone = 1;
      double lat = 43.8563;
      double lng = 18.4131;
      double angle = 14.6;

      PrayerCalc location = new PrayerCalc(timezone, lat, lng, angle);

      // current day fajr
      print('${location.prayers.current.dawn');
      // next day asr
      print('${location.prayers.next.afternoon');
      // previous day isha
      print('${location.prayers.previous.dusk');
      // last third of the night
      print('${location.sunnah.lastThird}');
      // countdown to next prayer
      print('${location.durations.countDown}');
      // Qibla direction
      print('${location.qibla}');


```

This document still under review and more updates coming insha'Allah soon.
