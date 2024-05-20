import 'dart:math';

import 'package:adhan_dart/src/Astronomical.dart';
import 'package:adhan_dart/src/MathUtils.dart';
import 'package:adhan_dart/src/SolarCoordinates.dart';
import 'package:adhan_dart/src/Coordinates.dart';

class SolarTime {
  late Coordinates observer;
  late SolarCoordinates solar;
  late SolarCoordinates prevSolar;
  late SolarCoordinates nextSolar;

  double? approxTransit;
  late double transit;
  late double sunrise;
  late double sunset;

  SolarTime(date, coordinates) {
    double julianDay = Astronomical.julianDay(date.year, date.month, date.day, 0);

    observer = coordinates;
    solar = SolarCoordinates(julianDay);

    prevSolar = SolarCoordinates(julianDay - 1);
    nextSolar = SolarCoordinates(julianDay + 1);

    double m0 = Astronomical.approximateTransit(
        coordinates.longitude, solar.apparentSiderealTime, solar.rightAscension);
    const solarAltitude = -50.0 / 60.0;

    approxTransit = m0;

    transit = Astronomical.correctedTransit(m0, coordinates.longitude, solar.apparentSiderealTime,
        solar.rightAscension, prevSolar.rightAscension, nextSolar.rightAscension);

    sunrise = Astronomical.correctedHourAngle(
        m0,
        solarAltitude,
        coordinates,
        false,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);

    sunset = Astronomical.correctedHourAngle(
        m0,
        solarAltitude,
        coordinates,
        true,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);
  }

  double hourAngle(angle, afterTransit) {
    return Astronomical.correctedHourAngle(
        approxTransit,
        angle,
        observer,
        afterTransit,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);
  }

  double afternoon(shadowLength) {
    // TODO source shadow angle calculation
    double tangent = (observer.latitude - solar.declination!).abs();
    double inverse = shadowLength + tan(degreesToRadians(tangent));
    double angle = radiansToDegrees(atan(1.0 / inverse));
    return hourAngle(angle, true);
  }
}
