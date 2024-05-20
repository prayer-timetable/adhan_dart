import 'dart:math';

import 'package:adhan_dart/src/Astronomical.dart';
import 'package:adhan_dart/src/MathUtils.dart';

class SolarCoordinates {
  double? declination;
  double? rightAscension;
  late double apparentSiderealTime;

  SolarCoordinates(double julianDay) {
    double T = Astronomical.julianCentury(julianDay);
    double l0 = Astronomical.meanSolarLongitude(T);
    double lp = Astronomical.meanLunarLongitude(T);
    double omega = Astronomical.ascendingLunarNodeLongitude(T);
    double lambda = degreesToRadians(Astronomical.apparentSolarLongitude(T, l0));
    double theta0 = Astronomical.meanSiderealTime(T);
    double dPsi = Astronomical.nutationInLongitude(T, l0, lp, omega);
    double dEpsilon = Astronomical.nutationInObliquity(T, l0, lp, omega);
    double epsilon0 = Astronomical.meanObliquityOfTheEcliptic(T);
    double epsilonApparent =
        degreesToRadians(Astronomical.apparentObliquityOfTheEcliptic(T, epsilon0));

    /* declination: The declination of the sun, the angle between
            the rays of the Sun and the plane of the Earth's
            equator, in degrees.
            Equation from Astronomical Algorithms page 165 */
    declination = radiansToDegrees(asin(sin(epsilonApparent) * sin(lambda)));

    /* rightAscension: Right ascension of the Sun, the angular distance on the
            celestial equator from the vernal equinox to the hour circle,
            in degrees.
            Equation from Astronomical Algorithms page 165 */
    rightAscension =
        unwindAngle(radiansToDegrees(atan2(cos(epsilonApparent) * sin(lambda), cos(lambda))));

    /* apparentSiderealTime: Apparent sidereal time, the hour angle of the vernal
            equinox, in degrees.
            Equation from Astronomical Algorithms page 88 */
    apparentSiderealTime =
        theta0 + (((dPsi * 3600) * cos(degreesToRadians(epsilon0 + dEpsilon))) / 3600);
  }
}
