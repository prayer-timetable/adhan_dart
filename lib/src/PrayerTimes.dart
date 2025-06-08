import 'package:adhan_dart/adhan_dart.dart';
import 'package:adhan_dart/src/Astronomical.dart';
import 'package:adhan_dart/src/DateUtils.dart';
import 'package:adhan_dart/src/SolarTime.dart';
import 'package:adhan_dart/src/TimeComponents.dart';

class PrayerTimes {
  DateTime date = DateTime.now();
  Coordinates coordinates = Coordinates(0, 0);
  CalculationParameters calculationParameters =
      CalculationMethodParameters.muslimWorldLeague();

  late DateTime fajr;
  late DateTime sunrise;
  late DateTime dhuhr;
  late DateTime asr;
  late DateTime maghrib;
  late DateTime isha;
  late DateTime ishabefore;
  late DateTime fajrafter;

  // TODO: added precision
  // rounded nightfraction
  PrayerTimes({
    required DateTime date,
    required Coordinates coordinates,
    required CalculationParameters calculationParameters,
    precision = false,
  }) {
    this.date = date;
    this.coordinates = coordinates;
    this.calculationParameters = calculationParameters;

    DateTime dateBefore = date.subtract(const Duration(days: 1));
    DateTime dateAfter = date.add(const Duration(days: 1));
    // todo
    // print(calculationParameters.ishaAngle);
    SolarTime solarTime = SolarTime(date, coordinates);
    SolarTime solarTimeBefore = SolarTime(dateBefore, coordinates);
    SolarTime solarTimeAfter = SolarTime(dateAfter, coordinates);

    DateTime fajrTime;
    DateTime asrTime;
    DateTime maghribTime;
    DateTime ishaTime;
    DateTime ishabeforeTime;
    DateTime fajrafterTime;

    double? nightFraction;

    DateTime dhuhrTime = TimeComponents(solarTime.transit)
        .utcDate(date.year, date.month, date.day);
    DateTime sunriseTime = TimeComponents(solarTime.sunrise)
        .utcDate(date.year, date.month, date.day);
    DateTime sunsetTime = TimeComponents(solarTime.sunset)
        .utcDate(date.year, date.month, date.day);

    DateTime sunriseafterTime = TimeComponents(solarTimeAfter.sunrise)
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);
    DateTime sunsetbeforeTime = TimeComponents(solarTimeBefore.sunset)
        .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);

    asrTime = TimeComponents(
            solarTime.afternoon(shadowLength(calculationParameters.madhab)))
        .utcDate(date.year, date.month, date.day);

    DateTime tomorrow = dateByAddingDays(date, 1);
    var tomorrowSolarTime = SolarTime(tomorrow, coordinates);
    DateTime tomorrowSunrise = TimeComponents(tomorrowSolarTime.sunrise)
        .utcDate(tomorrow.year, tomorrow.month, tomorrow.day);
    // var night = (tomorrowSunrise - sunsetTime) / 1000;
    int night = (tomorrowSunrise.difference(sunsetTime)).inSeconds;

    fajrTime = TimeComponents(
            solarTime.hourAngle(-1 * calculationParameters.fajrAngle, false))
        .utcDate(date.year, date.month, date.day);

    fajrafterTime = TimeComponents(solarTimeAfter.hourAngle(
            -1 * calculationParameters.fajrAngle, false))
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);

    // special case for moonsighting committee above latitude 55
    if (calculationParameters.method ==
            CalculationMethod.moonsightingCommittee &&
        coordinates.latitude >= 55) {
      nightFraction = night / 7;
      fajrTime = dateByAddingSeconds(sunriseTime, -nightFraction.round());
      fajrafterTime =
          dateByAddingSeconds(sunriseafterTime, -nightFraction.round());
    }

    DateTime safeFajr() {
      if (calculationParameters.method ==
          CalculationMethod.moonsightingCommittee) {
        return Astronomical.seasonAdjustedMorningTwilight(
            coordinates.latitude, dayOfYear(date), date.year, sunriseTime);
      } else {
        var portion = calculationParameters.nightPortions()[Prayer.fajr]!;
        nightFraction = portion * night;
        return dateByAddingSeconds(sunriseTime, -nightFraction!.round());
      }
    }

    // TODO?
    // DateTime safeFajrAfter() {
    //   if (calculationParameters.method == CalculationMethod.moonsightingCommittee) {
    //     return Astronomical.seasonAdjustedMorningTwilight(
    //         coordinates.latitude, dayOfYear(date), date.year, sunriseTime);
    //   } else {
    //     var portion = calculationParameters.nightPortions()[fajr];
    //     nightFraction = portion * night;
    //     return dateByAddingSeconds(sunriseTime, -nightFraction!.round());
    //   }
    // }

    if (fajrTime.millisecondsSinceEpoch.isNaN || safeFajr().isAfter(fajrTime)) {
      fajrTime = safeFajr();
    }

    if (fajrafterTime.millisecondsSinceEpoch.isNaN ||
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
      ishaTime = TimeComponents(
              solarTime.hourAngle(-1 * calculationParameters.ishaAngle, true))
          .utcDate(date.year, date.month, date.day);
      ishabeforeTime = TimeComponents(solarTimeBefore.hourAngle(
              -1 * calculationParameters.ishaAngle, true))
          .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);
      // special case for moonsighting committee above latitude 55
      if (calculationParameters.method ==
              CalculationMethod.moonsightingCommittee &&
          coordinates.latitude >= 55) {
        nightFraction = night / 7;
        ishaTime = dateByAddingSeconds(sunsetTime, nightFraction!.round());
        ishabeforeTime =
            dateByAddingSeconds(sunsetbeforeTime, nightFraction!.round());
      }

      DateTime safeIsha() {
        if (calculationParameters.method ==
            CalculationMethod.moonsightingCommittee) {
          return Astronomical.seasonAdjustedEveningTwilight(
              coordinates.latitude, dayOfYear(date), date.year, sunsetTime);
        } else {
          double portion = calculationParameters.nightPortions()[Prayer.isha]!;
          nightFraction = portion * night;
          return dateByAddingSeconds(sunsetTime, nightFraction!.round());
        }
      }

      DateTime safeIshaBefore() {
        if (calculationParameters.method ==
            CalculationMethod.moonsightingCommittee) {
          return Astronomical.seasonAdjustedEveningTwilight(
              coordinates.latitude, dayOfYear(date), date.year, sunsetTime);
        } else {
          var portion = calculationParameters.nightPortions()[Prayer.isha]!;
          nightFraction = portion * night;
          return dateByAddingSeconds(sunsetTime, nightFraction!.round());
        }
      }

      if (ishaTime.millisecondsSinceEpoch.isNaN ||
          safeIsha().isBefore(ishaTime)) {
        ishaTime = safeIsha();
      }

      if (ishabeforeTime.millisecondsSinceEpoch.isNaN ||
          safeIshaBefore().isBefore(ishabeforeTime)) {
        ishabeforeTime = safeIshaBefore();
      }
    }

    maghribTime = sunsetTime;
    if (calculationParameters.maghribAngle != null) {
      DateTime angleBasedMaghrib = TimeComponents(solarTime.hourAngle(
              -1 * calculationParameters.maghribAngle!, true))
          .utcDate(date.year, date.month, date.day);
      if (sunsetTime.isBefore(angleBasedMaghrib) &&
          ishaTime.isAfter(angleBasedMaghrib)) {
        maghribTime = angleBasedMaghrib;
      }
    }

    // double fajrAdjustment = (calculationParameters.adjustments["fajr"] && 0) + (calculationParameters.methodAdjustments["fajr"] && 0);
    int fajrAdjustment = (calculationParameters.adjustments[Prayer.fajr] ?? 0) +
        (calculationParameters.methodAdjustments[Prayer.fajr] ?? 0);
    int sunriseAdjustment =
        (calculationParameters.adjustments[Prayer.sunrise] ?? 0) +
            (calculationParameters.methodAdjustments[Prayer.sunrise] ?? 0);
    int dhuhrAdjustment =
        (calculationParameters.adjustments[Prayer.dhuhr] ?? 0) +
            (calculationParameters.methodAdjustments[Prayer.dhuhr] ?? 0);
    int asrAdjustment = (calculationParameters.adjustments[Prayer.asr] ?? 0) +
        (calculationParameters.methodAdjustments[Prayer.asr] ?? 0);
    int maghribAdjustment =
        (calculationParameters.adjustments[Prayer.maghrib] ?? 0) +
            (calculationParameters.methodAdjustments[Prayer.maghrib] ?? 0);
    int ishaAdjustment = (calculationParameters.adjustments[Prayer.isha] ?? 0) +
        (calculationParameters.methodAdjustments[Prayer.isha] ?? 0);

    fajr = roundedMinute(dateByAddingMinutes(fajrTime, fajrAdjustment),
        precision: precision);
    sunrise = roundedMinute(dateByAddingMinutes(sunriseTime, sunriseAdjustment),
        precision: precision);
    dhuhr = roundedMinute(dateByAddingMinutes(dhuhrTime, dhuhrAdjustment),
        precision: precision);
    asr = roundedMinute(dateByAddingMinutes(asrTime, asrAdjustment),
        precision: precision);
    maghrib = roundedMinute(dateByAddingMinutes(maghribTime, maghribAdjustment),
        precision: precision);
    isha = roundedMinute(dateByAddingMinutes(ishaTime, ishaAdjustment),
        precision: precision);

    fajrafter = roundedMinute(
        dateByAddingMinutes(fajrafterTime, fajrAdjustment),
        precision: precision);
    ishabefore = roundedMinute(
        dateByAddingMinutes(ishabeforeTime, ishaAdjustment),
        precision: precision);
  }

  Prayer currentPrayer({required DateTime date}) {
    // if (date == null) {
    //   date = DateTime.now();
    // }
    if (date.isAfter(isha)) {
      return Prayer.isha;
    } else if (date.isAfter(maghrib)) {
      return Prayer.maghrib;
    } else if (date.isAfter(asr)) {
      return Prayer.asr;
    } else if (date.isAfter(dhuhr)) {
      return Prayer.dhuhr;
    } else if (date.isAfter(sunrise)) {
      return Prayer.sunrise;
    } else if (date.isAfter(fajr)) {
      return Prayer.fajr;
    } else {
      return Prayer.ishaBefore;
    }
  }

  Prayer nextPrayer({DateTime? date}) {
    date ??= DateTime.now();
    if (date.isAfter(isha)) {
      return Prayer.fajrAfter;
    } else if (date.isAfter(maghrib)) {
      return Prayer.isha;
    } else if (date.isAfter(asr)) {
      return Prayer.maghrib;
    } else if (date.isAfter(dhuhr)) {
      return Prayer.asr;
    } else if (date.isAfter(sunrise)) {
      return Prayer.dhuhr;
    } else if (date.isAfter(fajr)) {
      return Prayer.sunrise;
    } else {
      return Prayer.fajr;
    }
  }

  DateTime? timeForPrayer(Prayer prayer) {
    if (prayer == Prayer.fajr) {
      return fajr;
    } else if (prayer == Prayer.sunrise) {
      return sunrise;
    } else if (prayer == Prayer.dhuhr) {
      return dhuhr;
    } else if (prayer == Prayer.asr) {
      return asr;
    } else if (prayer == Prayer.maghrib) {
      return maghrib;
    } else if (prayer == Prayer.isha) {
      return isha;
    } else if (prayer == Prayer.ishaBefore) {
      return ishabefore;
    } else if (prayer == Prayer.fajrAfter) {
      return fajrafter;
    } else {
      return null;
    }
  }
}
