// import 'package:prayer_calc/src/classes/SunnahTimes.dart';
import 'package:prayer_calc/src/classes/HighLatitudeRule.dart';
import 'package:prayer_calc/src/classes/Qibla.dart';
import 'package:prayer_calc/src/components/Sunnah.dart';
import 'package:prayer_calc/src/components/Prayers.dart';
import 'package:prayer_calc/src/components/Durations.dart';
// import 'package:prayer_calc/src/func/prayerCalc.dart';

import 'package:prayer_calc/src/classes/Coordinates.dart';
import 'package:prayer_calc/src/classes/CalculationMethod.dart';
import 'package:prayer_calc/src/classes/CalculationParameters.dart';
import 'package:prayer_calc/src/classes/Madhab.dart';
import 'package:prayer_calc/src/classes/PrayerTimes.dart';

import 'package:prayer_calc/src/func/helpers.dart';

class PrayerCalc {
  // PrayersStructure prayers;
  Prayers current;
  Prayers next;
  Prayers previous;
  PrayerCalc prayers;
  Sunnah sunnah;
  // SunnahTimes sunnah;
  Durations durations;
  double qibla;

  PrayerCalc(
    int timezone,
    double lat,
    double lng,
    double angle, {
    double altitude,
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    int asrMethod,
    double ishaAngle,
    bool summerTimeCalc: true,
    DateTime time,
    bool precision,
  }) {
    DateTime timestamp = DateTime.now().toUtc();

    // UTC date
    // DateTime date = DateTime.utc(year ?? timestamp.year,
    //     month ?? timestamp.month, day ?? timestamp.day, 0, 0);
    // DateTime nowUtc = DateTime.now().toUtc();

    // Local dates needed for dst calc and local midnight past (0:00)
    DateTime date = DateTime.utc(
        year ?? timestamp.year,
        month ?? timestamp.month,
        day ?? timestamp.day,
        hour ?? 12,
        minute ?? 0,
        second ?? 0); // using noon of local date to avoid +- 1 hour
    // define now (local)
    // DateTime nowLocal = time ?? timestamp;
    DateTime now = time ?? timestamp;

    // ***** current, next and previous day
    DateTime dayCurrent = date;
    DateTime dayNext = date.add(Duration(days: 1));
    DateTime dayPrevious = date.subtract(Duration(days: 1));

    // ***** today, tomorrow and yesterday
    DateTime dayToday = time ?? timestamp;
    DateTime dayTomorrow = dayToday.add(Duration(days: 1));
    DateTime dayYesterday = dayToday.subtract(Duration(days: 1));

    // DEFINITIONS
    Coordinates coordinates = Coordinates(lat, lng);
    CalculationParameters params = CalculationMethod.Other();
    params.highLatitudeRule = HighLatitudeRule.TwilightAngle;
    params.madhab = asrMethod == 2 ? Madhab.Hanafi : Madhab.Shafi;
    // params.methodAdjustments = {'dhuhr': 0};
    params.fajrAngle = angle;
    params.ishaAngle = ishaAngle != null ? ishaAngle : angle;

    // print(date.toLocal());

    Prayers toPrayers(PrayerTimes prayerTimes) {
      Prayers prayers = new Prayers();
      int summerTime =
          (isDSTCalc(prayerTimes.date.toLocal()) && summerTimeCalc) ? 1 : 0;

      // (toLocal?)
      prayers.dawn =
          prayerTimes.fajr.add(Duration(hours: timezone + summerTime));
      prayers.sunrise =
          prayerTimes.sunrise.add(Duration(hours: timezone + summerTime));
      prayers.midday =
          prayerTimes.dhuhr.add(Duration(hours: timezone + summerTime));
      prayers.afternoon =
          prayerTimes.asr.add(Duration(hours: timezone + summerTime));
      prayers.sunset =
          prayerTimes.maghrib.add(Duration(hours: timezone + summerTime));
      prayers.dusk =
          prayerTimes.isha.add(Duration(hours: timezone + summerTime));
      return prayers;
    }

    // print(PrayerTimes(coordinates, dayCurrent, params).fajr);
    // ***** PRAYERS CURRENT, NEXT, PREVIOUS
    Prayers prayersCurrent = toPrayers(
        PrayerTimes(coordinates, dayCurrent, params, precision: precision));
    Prayers prayersNext = toPrayers(
        PrayerTimes(coordinates, dayNext, params, precision: precision));
    Prayers prayersPrevious = toPrayers(
        PrayerTimes(coordinates, dayPrevious, params, precision: precision));
    Prayers prayersToday = toPrayers(
        PrayerTimes(coordinates, dayToday, params, precision: precision));
    Prayers prayersTomorrow = toPrayers(
        PrayerTimes(coordinates, dayTomorrow, params, precision: precision));
    Prayers prayersYesterday = toPrayers(
        PrayerTimes(coordinates, dayYesterday, params, precision: precision));

    int _summerTime = (isDSTCalc(now.toLocal()) && summerTimeCalc) ? 1 : 0;

    // define components
    this.prayers =
        PrayerCalc.prayers(prayersCurrent, prayersNext, prayersPrevious);

    this.sunnah = Sunnah(now, prayersCurrent, prayersNext, prayersPrevious);
    // this.sunnah = SunnahTimes(PrayerTimes(coordinates, dayCurrent, params, precision: precision));

    this.durations = Durations(now.add(Duration(hours: timezone + _summerTime)),
        prayersToday, prayersTomorrow, prayersYesterday);

    this.qibla = Qibla().qibla(new Coordinates(lat, lng));
    //end
  }

  PrayerCalc.prayers(Prayers prayersCurrent, Prayers prayersTomorrow,
      Prayers prayersYesterday) {
    current = prayersCurrent;
    next = prayersTomorrow;
    previous = prayersYesterday;
  }
}
