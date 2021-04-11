import 'package:adhan_dart/src/SolarTime.dart';
import 'package:adhan_dart/src/TimeComponents.dart';
import 'package:adhan_dart/src/Prayer.dart';
import 'package:adhan_dart/src/Astronomical.dart';
import 'package:adhan_dart/src/DateUtils.dart';
import 'package:adhan_dart/src/Madhab.dart';

import 'package:adhan_dart/src/Coordinates.dart';
import 'package:adhan_dart/src/CalculationParameters.dart';

class PrayerTimes {
  late Coordinates coordinates;
  late DateTime date;
  late CalculationParameters calculationParameters;

  DateTime? fajr;
  DateTime? sunrise;
  DateTime? dhuhr;
  DateTime? asr;
  DateTime? maghrib;
  DateTime? isha;
  DateTime? ishabefore;
  DateTime? fajrafter;

  // TODO: added precision
  // rounded nightfraction
  PrayerTimes(Coordinates coordinates, DateTime date,
      CalculationParameters calculationParameters,
      {precision: false}) {
    this.coordinates = coordinates;
    this.date = date;
    this.calculationParameters = calculationParameters;

    DateTime dateBefore = date.subtract(Duration(days: 1));
    DateTime dateAfter = date.add(Duration(days: 1));
    // todo
    // print(calculationParameters.ishaAngle);
    SolarTime solarTime = new SolarTime(date, coordinates);
    SolarTime solarTimeBefore = new SolarTime(dateBefore, coordinates);
    SolarTime solarTimeAfter = new SolarTime(dateAfter, coordinates);

    DateTime fajrTime;
    DateTime asrTime;
    DateTime maghribTime;
    DateTime ishaTime;
    DateTime ishabeforeTime;
    DateTime fajrafterTime;

    double? nightFraction;

    DateTime dhuhrTime = new TimeComponents(solarTime.transit)
        .utcDate(date.year, date.month, date.day);
    DateTime sunriseTime = new TimeComponents(solarTime.sunrise)
        .utcDate(date.year, date.month, date.day);
    DateTime sunsetTime = new TimeComponents(solarTime.sunset)
        .utcDate(date.year, date.month, date.day);

    DateTime sunriseafterTime = new TimeComponents(solarTimeAfter.sunrise)
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);
    DateTime sunsetbeforeTime = new TimeComponents(solarTimeBefore.sunset)
        .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);

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

    fajrafterTime = new TimeComponents(solarTimeAfter.hourAngle(
            -1 * calculationParameters.fajrAngle, false))
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);

    // special case for moonsighting committee above latitude 55
    if (calculationParameters.method == "MoonsightingCommittee" &&
        coordinates.latitude >= 55) {
      nightFraction = night / 7;
      fajrTime = dateByAddingSeconds(sunriseTime, -nightFraction.round());
      fajrafterTime =
          dateByAddingSeconds(sunriseafterTime, -nightFraction.round());
    }

    DateTime safeFajr() {
      if (calculationParameters.method == "MoonsightingCommittee") {
        return Astronomical.seasonAdjustedMorningTwilight(
            coordinates.latitude, dayOfYear(date), date.year, sunriseTime);
      } else {
        var portion = calculationParameters.nightPortions()["fajr"];
        nightFraction = portion * night;
        return dateByAddingSeconds(sunriseTime, -nightFraction!.round());
      }
    }

    DateTime safeFajrAfter() {
      if (calculationParameters.method == "MoonsightingCommittee") {
        return Astronomical.seasonAdjustedMorningTwilight(
            coordinates.latitude, dayOfYear(date), date.year, sunriseTime);
      } else {
        var portion = calculationParameters.nightPortions()["fajr"];
        nightFraction = portion * night;
        return dateByAddingSeconds(sunriseTime, -nightFraction!.round());
      }
    }

    if (fajrTime == null ||
        fajrTime.millisecondsSinceEpoch == double.nan ||
        safeFajr().isAfter(fajrTime)) {
      fajrTime = safeFajr();
    }

    if (fajrafterTime == null ||
        fajrafterTime.millisecondsSinceEpoch == double.nan ||
        safeFajr().isAfter(fajrafterTime)) {
      fajrafterTime = safeFajr();
    }

    if (calculationParameters.ishaInterval != null &&
        calculationParameters.ishaInterval! > 0) {
      ishaTime =
          dateByAddingMinutes(sunsetTime, calculationParameters.ishaInterval);
      ishabeforeTime = dateByAddingMinutes(
          sunsetbeforeTime, calculationParameters.ishaInterval);
    } else {
      ishaTime = new TimeComponents(
              solarTime.hourAngle(-1 * calculationParameters.ishaAngle, true))
          .utcDate(date.year, date.month, date.day);
      ishabeforeTime = new TimeComponents(solarTimeBefore.hourAngle(
              -1 * calculationParameters.ishaAngle, true))
          .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);
      // special case for moonsighting committee above latitude 55
      if (calculationParameters.method == "MoonsightingCommittee" &&
          coordinates.latitude >= 55) {
        nightFraction = night / 7;
        ishaTime = dateByAddingSeconds(sunsetTime, nightFraction!.round());
        ishabeforeTime =
            dateByAddingSeconds(sunsetbeforeTime, nightFraction!.round());
      }

      DateTime safeIsha() {
        if (calculationParameters.method == "MoonsightingCommittee") {
          return Astronomical.seasonAdjustedEveningTwilight(
              coordinates.latitude, dayOfYear(date), date.year, sunsetTime);
        } else {
          var portion = calculationParameters.nightPortions()["isha"];
          nightFraction = portion * night;
          return dateByAddingSeconds(sunsetTime, nightFraction!.round());
        }
      }

      DateTime safeIshaBefore() {
        if (calculationParameters.method == "MoonsightingCommittee") {
          return Astronomical.seasonAdjustedEveningTwilight(
              coordinates.latitude, dayOfYear(date), date.year, sunsetTime);
        } else {
          var portion = calculationParameters.nightPortions()["isha"];
          nightFraction = portion * night;
          return dateByAddingSeconds(sunsetTime, nightFraction!.round());
        }
      }

      if (ishaTime == null ||
          ishaTime.millisecondsSinceEpoch == double.nan ||
          safeIsha().isBefore(ishaTime)) {
        ishaTime = safeIsha();
      }

      if (ishabeforeTime == null ||
          ishabeforeTime.millisecondsSinceEpoch == double.nan ||
          safeIshaBefore().isBefore(ishabeforeTime)) {
        ishabeforeTime = safeIshaBefore();
      }
    }

    maghribTime = sunsetTime;
    if (calculationParameters.maghribAngle != null) {
      DateTime angleBasedMaghrib = new TimeComponents(solarTime.hourAngle(
              -1 * calculationParameters.maghribAngle!, true))
          .utcDate(date.year, date.month, date.day);
      if (sunsetTime.isBefore(angleBasedMaghrib) &&
          ishaTime.isAfter(angleBasedMaghrib)) {
        maghribTime = angleBasedMaghrib;
      }
    }

    // double fajrAdjustment = (calculationParameters.adjustments["fajr"] && 0) + (calculationParameters.methodAdjustments["fajr"] && 0);
    int fajrAdjustment = (calculationParameters.adjustments["fajr"] ?? 0) +
        (calculationParameters.methodAdjustments["fajr"] ?? 0);
    int sunriseAdjustment =
        (calculationParameters.adjustments["sunrise"] ?? 0) +
            (calculationParameters.methodAdjustments["sunrise"] ?? 0);
    int dhuhrAdjustment = (calculationParameters.adjustments["dhuhr"] ?? 0) +
        (calculationParameters.methodAdjustments["dhuhr"] ?? 0);
    int asrAdjustment = (calculationParameters.adjustments["asr"] ?? 0) +
        (calculationParameters.methodAdjustments["asr"] ?? 0);
    int maghribAdjustment =
        (calculationParameters.adjustments["maghrib"] ?? 0) +
            (calculationParameters.methodAdjustments["maghrib"] ?? 0);
    int ishaAdjustment = (calculationParameters.adjustments["isha"] ?? 0) +
        (calculationParameters.methodAdjustments["isha"] ?? 0);

    this.fajr = roundedMinute(dateByAddingMinutes(fajrTime, fajrAdjustment),
        precision: precision);
    this.sunrise = roundedMinute(
        dateByAddingMinutes(sunriseTime, sunriseAdjustment),
        precision: precision);
    this.dhuhr = roundedMinute(dateByAddingMinutes(dhuhrTime, dhuhrAdjustment),
        precision: precision);
    this.asr = roundedMinute(dateByAddingMinutes(asrTime, asrAdjustment),
        precision: precision);
    this.maghrib = roundedMinute(
        dateByAddingMinutes(maghribTime, maghribAdjustment),
        precision: precision);
    this.isha = roundedMinute(dateByAddingMinutes(ishaTime, ishaAdjustment),
        precision: precision);

    this.fajrafter = roundedMinute(
        dateByAddingMinutes(fajrafterTime, fajrAdjustment),
        precision: precision);
    this.ishabefore = roundedMinute(
        dateByAddingMinutes(ishabeforeTime, ishaAdjustment),
        precision: precision);
  }

  DateTime? timeForPrayer(String prayer) {
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
    } else if (prayer == Prayer.IshaBefore) {
      return this.ishabefore;
    } else if (prayer == Prayer.FajrAfter) {
      return this.fajrafter;
    } else {
      return null;
    }
  }

  currentPrayer({required DateTime date}) {
    // if (date == null) {
    //   date = DateTime.now();
    // }
    if (date.isAfter(this.isha!)) {
      return Prayer.Isha;
    } else if (date.isAfter(this.maghrib!)) {
      return Prayer.Maghrib;
    } else if (date.isAfter(this.asr!)) {
      return Prayer.Asr;
    } else if (date.isAfter(this.dhuhr!)) {
      return Prayer.Dhuhr;
    } else if (date.isAfter(this.sunrise!)) {
      return Prayer.Sunrise;
    } else if (date.isAfter(this.fajr!)) {
      return Prayer.Fajr;
    } else {
      return Prayer.IshaBefore;
    }
  }

  nextPrayer({DateTime? date}) {
    if (date == null) {
      date = DateTime.now();
    }
    if (date.isAfter(this.isha!)) {
      return Prayer.FajrAfter;
    } else if (date.isAfter(this.maghrib!)) {
      return Prayer.Isha;
    } else if (date.isAfter(this.asr!)) {
      return Prayer.Maghrib;
    } else if (date.isAfter(this.dhuhr!)) {
      return Prayer.Asr;
    } else if (date.isAfter(this.sunrise!)) {
      return Prayer.Dhuhr;
    } else if (date.isAfter(this.fajr!)) {
      return Prayer.Sunrise;
    } else {
      return Prayer.Fajr;
    }
  }
}
