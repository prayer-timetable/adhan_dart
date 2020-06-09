# Dart Prayer Calc Library

Library for calculating muslim prayer times based on work published here:

https://www.academia.edu/35801795/Prayer_Time_Algorithm_for_Software_Development

# Dart Classes

## PrayerCalc

This class returns 5 daily prayers plus Sunrise. Takes following input parameters:

- _int_ timezone,
- _double_ latitude,
- _double_ longitude,
- _double_ angle (for both Dusk and Dawn)

Optional parameters:

- _int_ year,
- _int_ month,
- _int_ day,
- _int_ hour,
- _int_ minute,
- _int_ second,
- _int_ asrMethod,
- _double_ ishaAngle,
- _bool_ summerTimeCalc: true,
- _DateTime_ time,
- _bool_ showSeconds,
- _double_ altitude,

If no date is used, the library uses current date and time. It returns **_prayers_**, **_durations_**, **_sunnah_** and **_qibla_**.

## Durations

This class calculates durations to and from the prayers, taking into account next day Dawn for Isha prayer, as well as Previous day Isha when calculating Dawn for day after midnight. It also determines current, next and previous prayers based on current time. It returns the following:

- _DateTime_ now
- _DateTime_ current - current prayer time
- _DateTime_ next - next prayer time
- _DateTime_ previous - previous prayer time
- _bool_ isAfterIsha - is the current time after isha and before the midnight
- _int_ currentId - id of the current prayer (0 - 5)
- _Duration_ countDown - time until the next prayer
- _Duration_ countUp - time passed since the current prayer begun
- _double_ percentage: percentage of time passed between current and next prayer

## Sunnah

This class calculates times that apply to certain sunnah-defined times. It provides the following:

- _DateTime_ midnight - mid-point between the Sunset-Maghrib and Dawn-Fajr
- _DateTime_ lastThird - as above, time indicating the beginning of the last third of the night

## Qibla

Class returning single value:

- _double_ qibla - direction (bearing) to Qibla, in degrees

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

      location = new PrayerCalc(timezone, lat, lng, angle);

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
