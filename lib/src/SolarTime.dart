import 'dart:math';

import 'package:adhan_dart/src/Astronomical.dart';
import 'package:adhan_dart/src/MathUtils.dart';
import 'package:adhan_dart/src/SolarCoordinates.dart';
import 'package:adhan_dart/src/Coordinates.dart';

class SolarTime {
  Coordinates observer;
  SolarCoordinates solar;
  SolarCoordinates prevSolar;
  SolarCoordinates nextSolar;

  double approxTransit;
  double transit;
  double sunrise;
  double sunset;

  SolarTime(date, coordinates) {
    double julianDay =
        Astronomical.julianDay(date.year, date.month, date.day, 0);

    this.observer = coordinates;
    this.solar = new SolarCoordinates(julianDay);

    this.prevSolar = new SolarCoordinates(julianDay - 1);
    this.nextSolar = new SolarCoordinates(julianDay + 1);

    double m0 = Astronomical.approximateTransit(coordinates.longitude,
        this.solar.apparentSiderealTime, this.solar.rightAscension);
    const solarAltitude = -50.0 / 60.0;

    this.approxTransit = m0;

    this.transit = Astronomical.correctedTransit(
        m0,
        coordinates.longitude,
        this.solar.apparentSiderealTime,
        this.solar.rightAscension,
        this.prevSolar.rightAscension,
        this.nextSolar.rightAscension);

    this.sunrise = Astronomical.correctedHourAngle(
        m0,
        solarAltitude,
        coordinates,
        false,
        this.solar.apparentSiderealTime,
        this.solar.rightAscension,
        this.prevSolar.rightAscension,
        this.nextSolar.rightAscension,
        this.solar.declination,
        this.prevSolar.declination,
        this.nextSolar.declination);

    this.sunset = Astronomical.correctedHourAngle(
        m0,
        solarAltitude,
        coordinates,
        true,
        this.solar.apparentSiderealTime,
        this.solar.rightAscension,
        this.prevSolar.rightAscension,
        this.nextSolar.rightAscension,
        this.solar.declination,
        this.prevSolar.declination,
        this.nextSolar.declination);
  }

  double hourAngle(angle, afterTransit) {
    return Astronomical.correctedHourAngle(
        this.approxTransit,
        angle,
        this.observer,
        afterTransit,
        this.solar.apparentSiderealTime,
        this.solar.rightAscension,
        this.prevSolar.rightAscension,
        this.nextSolar.rightAscension,
        this.solar.declination,
        this.prevSolar.declination,
        this.nextSolar.declination);
  }

  double afternoon(shadowLength) {
    // TODO source shadow angle calculation
    double tangent = (this.observer.latitude - this.solar.declination).abs();
    double inverse = shadowLength + tan(degreesToRadians(tangent));
    double angle = radiansToDegrees(atan(1.0 / inverse));
    return this.hourAngle(angle, true);
  }
}
