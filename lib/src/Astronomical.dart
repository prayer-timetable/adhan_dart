import 'dart:math';

import 'package:adhan/src/MathUtils.dart';
import 'package:adhan/src/DateUtils.dart';

class Astronomical {
  /* The geometric mean longitude of the sun in degrees. */
  static double meanSolarLongitude(double julianCentury) {
    double T = julianCentury;
    /* Equation from Astronomical Algorithms page 163 */
    const term1 = 280.4664567;
    double term2 = 36000.76983 * T;
    double term3 = 0.0003032 * pow(T, 2);
    double L0 = term1 + term2 + term3;
    return unwindAngle(L0);
  }

  /* The geometric mean longitude of the moon in degrees. */
  static double meanLunarLongitude(double julianCentury) {
    double T = julianCentury;
    /* Equation from Astronomical Algorithms page 144 */
    const term1 = 218.3165;
    double term2 = 481267.8813 * T;
    double Lp = term1 + term2;
    return unwindAngle(Lp);
  }

  static double ascendingLunarNodeLongitude(double julianCentury) {
    double T = julianCentury;
    /* Equation from Astronomical Algorithms page 144 */
    const term1 = 125.04452;
    double term2 = 1934.136261 * T;
    double term3 = 0.0020708 * pow(T, 2);
    double term4 = pow(T, 3) / 450000;
    double Omega = term1 - term2 + term3 + term4;
    return unwindAngle(Omega);
  }

  /* The mean anomaly of the sun. */
  static double meanSolarAnomaly(double julianCentury) {
    double T = julianCentury;
    /* Equation from Astronomical Algorithms page 163 */
    const term1 = 357.52911;
    double term2 = 35999.05029 * T;
    double term3 = 0.0001537 * pow(T, 2);
    double M = term1 + term2 - term3;
    return unwindAngle(M);
  }

  /* The Sun's equation of the center in degrees. */
  static double solarEquationOfTheCenter(julianCentury, meanAnomaly) {
    double T = julianCentury;
    /* Equation from Astronomical Algorithms page 164 */
    double Mrad = degreesToRadians(meanAnomaly);
    double term1 =
        (1.914602 - (0.004817 * T) - (0.000014 * pow(T, 2))) * sin(Mrad);
    double term2 = (0.019993 - (0.000101 * T)) * sin(2 * Mrad);
    double term3 = 0.000289 * sin(3 * Mrad);
    return term1 + term2 + term3;
  }

  /* The apparent longitude of the Sun, referred to the
        true equinox of the date. */
  static double apparentSolarLongitude(julianCentury, meanLongitude) {
    double T = julianCentury;
    double L0 = meanLongitude;
    /* Equation from Astronomical Algorithms page 164 */
    double longitude = L0 +
        Astronomical.solarEquationOfTheCenter(
            T, Astronomical.meanSolarAnomaly(T));
    double Omega = 125.04 - (1934.136 * T);
    double Lambda =
        longitude - 0.00569 - (0.00478 * sin(degreesToRadians(Omega)));
    return unwindAngle(Lambda);
  }

  /* The mean obliquity of the ecliptic, formula
        adopted by the International Astronomical Union.
        Represented in degrees. */
  static double meanObliquityOfTheEcliptic(double julianCentury) {
    double T = julianCentury;
    /* Equation from Astronomical Algorithms page 147 */
    const term1 = 23.439291;
    double term2 = 0.013004167 * T;
    double term3 = 0.0000001639 * pow(T, 2);
    double term4 = 0.0000005036 * pow(T, 3);
    return term1 - term2 - term3 + term4;
  }

  /* The mean obliquity of the ecliptic, corrected for
        calculating the apparent position of the sun, in degrees. */
  static double apparentObliquityOfTheEcliptic(
      julianCentury, meanObliquityOfTheEcliptic) {
    double T = julianCentury;
    double Epsilon0 = meanObliquityOfTheEcliptic;
    /* Equation from Astronomical Algorithms page 165 */
    double O = 125.04 - (1934.136 * T);
    return Epsilon0 + (0.00256 * cos(degreesToRadians(O)));
  }

  /* Mean sidereal time, the hour angle of the vernal equinox, in degrees. */
  static double meanSiderealTime(double julianCentury) {
    double T = julianCentury;
    /* Equation from Astronomical Algorithms page 165 */
    double JD = (T * 36525) + 2451545.0;
    const term1 = 280.46061837;
    double term2 = 360.98564736629 * (JD - 2451545);
    double term3 = 0.000387933 * pow(T, 2);
    double term4 = pow(T, 3) / 38710000;
    double Theta = term1 + term2 + term3 - term4;
    return unwindAngle(Theta);
  }

  static double nutationInLongitude(
      julianCentury, solarLongitude, lunarLongitude, ascendingNode) {
    double L0 = solarLongitude;
    double Lp = lunarLongitude;
    double Omega = ascendingNode;
    /* Equation from Astronomical Algorithms page 144 */
    double term1 = (-17.2 / 3600) * sin(degreesToRadians(Omega));
    double term2 = (1.32 / 3600) * sin(2 * degreesToRadians(L0));
    double term3 = (0.23 / 3600) * sin(2 * degreesToRadians(Lp));
    double term4 = (0.21 / 3600) * sin(2 * degreesToRadians(Omega));
    return term1 - term2 - term3 + term4;
  }

  static double nutationInObliquity(
      julianCentury, solarLongitude, lunarLongitude, ascendingNode) {
    double L0 = solarLongitude;
    double Lp = lunarLongitude;
    double Omega = ascendingNode;
    /* Equation from Astronomical Algorithms page 144 */
    double term1 = (9.2 / 3600) * cos(degreesToRadians(Omega));
    double term2 = (0.57 / 3600) * cos(2 * degreesToRadians(L0));
    double term3 = (0.10 / 3600) * cos(2 * degreesToRadians(Lp));
    double term4 = (0.09 / 3600) * cos(2 * degreesToRadians(Omega));
    return term1 + term2 + term3 - term4;
  }

  static double altitudeOfCelestialBody(
      observerLatitude, declination, localHourAngle) {
    double Phi = observerLatitude;
    double delta = declination;
    double H = localHourAngle;
    /* Equation from Astronomical Algorithms page 93 */
    double term1 = sin(degreesToRadians(Phi)) * sin(degreesToRadians(delta));
    double term2 = cos(degreesToRadians(Phi)) *
        cos(degreesToRadians(delta)) *
        cos(degreesToRadians(H));
    return radiansToDegrees(asin(term1 + term2));
  }

  static double approximateTransit(longitude, siderealTime, rightAscension) {
    double L = longitude;
    double Theta0 = siderealTime;
    double a2 = rightAscension;
    /* Equation from page Astronomical Algorithms 102 */
    double Lw = L * -1;
    return normalizeToScale((a2 + Lw - Theta0) / 360, 1);
  }

  /* The time at which the sun is at its highest point in the sky (in universal time) */
  static double correctedTransit(approximateTransit, longitude, siderealTime,
      rightAscension, previousRightAscension, nextRightAscension) {
    double m0 = approximateTransit;
    double L = longitude;
    double Theta0 = siderealTime;
    double a2 = rightAscension;
    double a1 = previousRightAscension;
    double a3 = nextRightAscension;
    /* Equation from page Astronomical Algorithms 102 */
    double Lw = L * -1;
    double Theta = unwindAngle((Theta0 + (360.985647 * m0)));
    double a = unwindAngle(Astronomical.interpolateAngles(a2, a1, a3, m0));
    double H = quadrantShiftAngle(Theta - Lw - a);
    double dm = H / -360;
    return (m0 + dm) * 24;
  }

  static double correctedHourAngle(
      approximateTransit,
      angle,
      coordinates,
      afterTransit,
      siderealTime,
      rightAscension,
      previousRightAscension,
      nextRightAscension,
      declination,
      previousDeclination,
      nextDeclination) {
    double m0 = approximateTransit;
    double h0 = angle;
    double Theta0 = siderealTime;
    double a2 = rightAscension;
    double a1 = previousRightAscension;
    double a3 = nextRightAscension;
    double d2 = declination;
    double d1 = previousDeclination;
    double d3 = nextDeclination;

    /* Equation from page Astronomical Algorithms 102 */
    double Lw = coordinates.longitude * -1;
    double term1 = sin(degreesToRadians(h0)) -
        (sin(degreesToRadians(coordinates.latitude)) *
            sin(degreesToRadians(d2)));
    double term2 =
        cos(degreesToRadians(coordinates.latitude)) * cos(degreesToRadians(d2));

    // TODO: acos with term1/term2 > 1 or < -1
    double H0 =
        (term1 / term2).abs() > 1 ? 1.0 : radiansToDegrees(acos(term1 / term2));

    double m = afterTransit ? m0 + (H0 / 360) : m0 - (H0 / 360);
    double Theta = unwindAngle((Theta0 + (360.985647 * m)));
    double a = unwindAngle(Astronomical.interpolateAngles(a2, a1, a3, m));
    double delta = Astronomical.interpolate(d2, d1, d3, m);
    double H = (Theta - Lw - a);
    double h =
        Astronomical.altitudeOfCelestialBody(coordinates.latitude, delta, H);
    double term3 = h - h0;
    double term4 = 360 *
        cos(degreesToRadians(delta)) *
        cos(degreesToRadians(coordinates.latitude)) *
        sin(degreesToRadians(H));
    double dm = term3 / term4;
    return (m + dm) * 24;
  }

  /* Interpolation of a value given equidistant
        previous and next values and a factor
        equal to the fraction of the interpolated
        point's time over the time between values. */
  static double interpolate(y2, y1, y3, n) {
    /* Equation from Astronomical Algorithms page 24 */
    double a = y2 - y1;
    double b = y3 - y2;
    double c = b - a;
    return y2 + ((n / 2) * (a + b + (n * c)));
  }

  /* Interpolation of three angles, accounting for
        angle unwinding. */
  static double interpolateAngles(y2, y1, y3, n) {
    /* Equation from Astronomical Algorithms page 24 */
    double a = unwindAngle(y2 - y1);
    double b = unwindAngle(y3 - y2);
    double c = b - a;
    return y2 + ((n / 2) * (a + b + (n * c)));
  }

  /* The Julian Day for the given Gregorian date components. */
  static double julianDay(year, month, day, hours) {
    /* Equation from Astronomical Algorithms page 60 */
    if (hours == null) {
      hours = 0;
    }

    // const trunc = Math.trunc || function (x) { return x < 0 ? Math.ceil(x) : Math.floor(x); };
    trunc(val) => val.truncate();

    int Y = trunc(month > 2 ? year : year - 1);
    int M = trunc(month > 2 ? month : month + 12);
    double D = day + (hours / 24);

    int A = trunc(Y / 100);
    int B = trunc(2 - A + trunc(A / 4));

    int i0 = trunc(365.25 * (Y + 4716));
    int i1 = trunc(30.6001 * (M + 1));

    return i0 + i1 + D + B - 1524.5;
  }

  /* Julian century from the epoch. */
  static double julianCentury(double julianDay) {
    /* Equation from Astronomical Algorithms page 163 */
    return (julianDay - 2451545.0) / 36525;
  }

  /* Whether or not a year is a leap year (has 366 days). */
  static bool isLeapYear(year) {
    if (year % 4 != 0) {
      return false;
    }

    if (year % 100 == 0 && year % 400 != 0) {
      return false;
    }

    return true;
  }

  static DateTime seasonAdjustedMorningTwilight(
      double latitude, int dayOfYear, int year, DateTime sunrise) {
    double a = 75 + ((28.65 / 55.0) * (latitude).abs());
    double b = 75 + ((19.44 / 55.0) * (latitude).abs());
    double c = 75 + ((32.74 / 55.0) * (latitude).abs());
    double d = 75 + ((48.10 / 55.0) * (latitude).abs());

    double adjustment() {
      int dyy = Astronomical.daysSinceSolstice(dayOfYear, year, latitude);
      if (dyy < 91) {
        return a + (b - a) / 91.0 * dyy;
      } else if (dyy < 137) {
        return b + (c - b) / 46.0 * (dyy - 91);
      } else if (dyy < 183) {
        return c + (d - c) / 46.0 * (dyy - 137);
      } else if (dyy < 229) {
        return d + (c - d) / 46.0 * (dyy - 183);
      } else if (dyy < 275) {
        return c + (b - c) / 46.0 * (dyy - 229);
      } else {
        return b + (a - b) / 91.0 * (dyy - 275);
      }
    }

    ;

    return dateByAddingSeconds(sunrise, (adjustment() * -60.0).round());
  }

  static DateTime seasonAdjustedEveningTwilight(
      double latitude, int dayOfYear, int year, DateTime sunset) {
    double a = 75 + ((25.60 / 55.0) * (latitude).abs());
    double b = 75 + ((2.050 / 55.0) * (latitude).abs());
    double c = 75 - ((9.210 / 55.0) * (latitude).abs());
    double d = 75 + ((6.140 / 55.0) * (latitude).abs());

    double adjustment() {
      int dyy = Astronomical.daysSinceSolstice(dayOfYear, year, latitude);
      if (dyy < 91) {
        return a + (b - a) / 91.0 * dyy;
      } else if (dyy < 137) {
        return b + (c - b) / 46.0 * (dyy - 91);
      } else if (dyy < 183) {
        return c + (d - c) / 46.0 * (dyy - 137);
      } else if (dyy < 229) {
        return d + (c - d) / 46.0 * (dyy - 183);
      } else if (dyy < 275) {
        return c + (b - c) / 46.0 * (dyy - 229);
      } else {
        return b + (a - b) / 91.0 * (dyy - 275);
      }
    }

    ;

    return dateByAddingSeconds(sunset, (adjustment() * 60.0).round());
  }

  static int daysSinceSolstice(int dayOfYear, int year, double latitude) {
    int daysSinceSolstice = 0;
    int northernOffset = 10;
    int southernOffset = Astronomical.isLeapYear(year) ? 173 : 172;
    int daysInYear = Astronomical.isLeapYear(year) ? 366 : 365;

    if (latitude >= 0) {
      daysSinceSolstice = dayOfYear + northernOffset;
      if (daysSinceSolstice >= daysInYear) {
        daysSinceSolstice = daysSinceSolstice - daysInYear;
      }
    } else {
      daysSinceSolstice = dayOfYear - southernOffset;
      if (daysSinceSolstice < 0) {
        daysSinceSolstice = daysSinceSolstice + daysInYear;
      }
    }

    return daysSinceSolstice;
  }
}
