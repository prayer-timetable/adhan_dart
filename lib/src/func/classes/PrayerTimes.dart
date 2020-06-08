import 'package:prayer_calc/src/func/classes/SolarTime.dart';
import 'package:prayer_calc/src/func/classes/TimeComponents.dart';
import 'package:prayer_calc/src/func/classes/Prayer.dart';
import 'package:prayer_calc/src/func/classes/Astronomical.dart';
import 'package:prayer_calc/src/func/classes/DateUtils.dart';
import 'package:prayer_calc/src/func/classes/Madhab.dart';

import 'package:prayer_calc/src/func/classes/Coordinates.dart';
import 'package:prayer_calc/src/func/classes/CalculationParameters.dart';

class PrayerTimes {
  Coordinates coordinates;
  DateTime date;
  CalculationParameters calculationParameters;

  DateTime fajr;
  DateTime sunrise;
  DateTime dhuhr;
  DateTime asr;
  DateTime maghrib;
  DateTime isha;

  PrayerTimes(Coordinates coordinates, DateTime date,
      CalculationParameters calculationParameters) {
    this.coordinates = coordinates;
    this.date = date;
    this.calculationParameters = calculationParameters;

    var solarTime = new SolarTime(date, coordinates);

    DateTime fajrTime;
    DateTime asrTime;
    DateTime maghribTime;
    DateTime ishaTime;

    var nightFraction;

    DateTime dhuhrTime = new TimeComponents(solarTime.transit)
        .utcDate(date.year, date.month, date.day);
    DateTime sunriseTime = new TimeComponents(solarTime.sunrise)
        .utcDate(date.year, date.month, date.day);
    DateTime sunsetTime = new TimeComponents(solarTime.sunset)
        .utcDate(date.year, date.month, date.day);

    asrTime = new TimeComponents(
            solarTime.afternoon(shadowLength(calculationParameters.madhab)))
        .utcDate(date.year, date.month, date.day);

    DateTime tomorrow = dateByAddingDays(date, 1);
    var tomorrowSolarTime = new SolarTime(tomorrow, coordinates);
    DateTime tomorrowSunrise = new TimeComponents(tomorrowSolarTime.sunrise)
        .utcDate(tomorrow.year, tomorrow.month, tomorrow.day);
    // var night = (tomorrowSunrise - sunsetTime) / 1000;
    int night = (tomorrowSunrise.difference(sunsetTime)).inSeconds;

    fajrTime = new TimeComponents(
            solarTime.hourAngle(-1 * calculationParameters.fajrAngle, false))
        .utcDate(date.year, date.month, date.day);

    // special case for moonsighting committee above latitude 55
    if (calculationParameters.method == "MoonsightingCommittee" &&
        coordinates.latitude >= 55) {
      nightFraction = night / 7;
      fajrTime = dateByAddingSeconds(sunriseTime, -nightFraction);
    }

    DateTime safeFajr() {
      if (calculationParameters.method == "MoonsightingCommittee") {
        return Astronomical.seasonAdjustedMorningTwilight(
            coordinates.latitude, dayOfYear(date), date.year, sunriseTime);
      } else {
        var portion = calculationParameters.nightPortions().fajr;
        nightFraction = portion * night;
        return dateByAddingSeconds(sunriseTime, -nightFraction);
      }
    }

    if (fajrTime == null ||
        fajrTime.millisecondsSinceEpoch == double.nan ||
        safeFajr().isAfter(fajrTime)) {
      fajrTime = safeFajr();
    }

    if (calculationParameters.ishaInterval > 0) {
      ishaTime =
          dateByAddingMinutes(sunsetTime, calculationParameters.ishaInterval);
    } else {
      ishaTime = new TimeComponents(
              solarTime.hourAngle(-1 * calculationParameters.ishaAngle, true))
          .utcDate(date.year, date.month, date.day);

      // special case for moonsighting committee above latitude 55
      if (calculationParameters.method == "MoonsightingCommittee" &&
          coordinates.latitude >= 55) {
        nightFraction = night / 7;
        ishaTime = dateByAddingSeconds(sunsetTime, nightFraction);
      }

      DateTime safeIsha() {
        if (calculationParameters.method == "MoonsightingCommittee") {
          return Astronomical.seasonAdjustedEveningTwilight(
              coordinates.latitude, dayOfYear(date), date.year, sunsetTime);
        } else {
          var portion = calculationParameters.nightPortions().isha;
          nightFraction = portion * night;
          return dateByAddingSeconds(sunsetTime, nightFraction);
        }
      }

      if (ishaTime == null ||
          ishaTime.millisecondsSinceEpoch == double.nan ||
          safeIsha().isBefore(ishaTime)) {
        ishaTime = safeIsha();
      }
    }

    maghribTime = sunsetTime;
    if (calculationParameters.maghribAngle != null) {
      DateTime angleBasedMaghrib = new TimeComponents(solarTime.hourAngle(
              -1 * calculationParameters.maghribAngle, true))
          .utcDate(date.year, date.month, date.day);
      if (sunsetTime.isBefore(angleBasedMaghrib) &&
          ishaTime.isAfter(angleBasedMaghrib)) {
        maghribTime = angleBasedMaghrib;
      }
    }

    // double fajrAdjustment = (calculationParameters.adjustments["fajr"] && 0) + (calculationParameters.methodAdjustments["fajr"] && 0);
    double fajrAdjustment = (calculationParameters.adjustments["fajr"]) +
        (calculationParameters.methodAdjustments["fajr"]);
    double sunriseAdjustment = (calculationParameters.adjustments["sunrise"]) +
        (calculationParameters.methodAdjustments["sunrise"]);
    double dhuhrAdjustment = (calculationParameters.adjustments["dhuhr"]) +
        (calculationParameters.methodAdjustments["dhuhr"]);
    double asrAdjustment = (calculationParameters.adjustments["asr"]) +
        (calculationParameters.methodAdjustments["asr"]);
    double maghribAdjustment = (calculationParameters.adjustments["maghrib"]) +
        (calculationParameters.methodAdjustments["maghrib"]);
    double ishaAdjustment = (calculationParameters.adjustments["isha"]) +
        (calculationParameters.methodAdjustments["isha"]);

    this.fajr = roundedMinute(dateByAddingMinutes(fajrTime, fajrAdjustment));
    this.sunrise =
        roundedMinute(dateByAddingMinutes(sunriseTime, sunriseAdjustment));
    this.dhuhr = roundedMinute(dateByAddingMinutes(dhuhrTime, dhuhrAdjustment));
    this.asr = roundedMinute(dateByAddingMinutes(asrTime, asrAdjustment));
    this.maghrib =
        roundedMinute(dateByAddingMinutes(maghribTime, maghribAdjustment));
    this.isha = roundedMinute(dateByAddingMinutes(ishaTime, ishaAdjustment));
  }

  timeForPrayer(prayer) {
    if (prayer == Prayer.Fajr) {
      return this.fajr;
    } else if (prayer == Prayer.Sunrise) {
      return this.sunrise;
    } else if (prayer == Prayer.Dhuhr) {
      return this.dhuhr;
    } else if (prayer == Prayer.Asr) {
      return this.asr;
    } else if (prayer == Prayer.Maghrib) {
      return this.maghrib;
    } else if (prayer == Prayer.Isha) {
      return this.isha;
    } else {
      return null;
    }
  }

  currentPrayer(date) {
    if (date == null) {
      date = DateTime.now();
    }
    if (date >= this.isha) {
      return Prayer.Isha;
    } else if (date >= this.maghrib) {
      return Prayer.Maghrib;
    } else if (date >= this.asr) {
      return Prayer.Asr;
    } else if (date >= this.dhuhr) {
      return Prayer.Dhuhr;
    } else if (date >= this.sunrise) {
      return Prayer.Sunrise;
    } else if (date >= this.fajr) {
      return Prayer.Fajr;
    } else {
      return Prayer.None;
    }
  }

  nextPrayer(date) {
    if (date == null) {
      date = DateTime.now();
    }
    if (date >= this.isha) {
      return Prayer.None;
    } else if (date >= this.maghrib) {
      return Prayer.Isha;
    } else if (date >= this.asr) {
      return Prayer.Maghrib;
    } else if (date >= this.dhuhr) {
      return Prayer.Asr;
    } else if (date >= this.sunrise) {
      return Prayer.Dhuhr;
    } else if (date >= this.fajr) {
      return Prayer.Sunrise;
    } else {
      return Prayer.Fajr;
    }
  }
}
