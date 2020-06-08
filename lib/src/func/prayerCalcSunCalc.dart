import 'dart:math' as Math;
// import 'package:prayer_calc/src/func/classes.dart';

// shortcuts for easier to read formulas
// Sarajevo
const double lat = 43.8563;
const double lng = 18.4131;
const double alt = 518;
const double angleF = 14.6; //iz =19
const double angleI = 14.6; // iz = 17
const int timezone = 1;
const double height = 1.8;

const PI = Math.pi,
    sin = Math.sin,
    cos = Math.cos,
    tan = Math.tan,
    asin = Math.asin,
    atan = Math.atan2,
    acos = Math.acos,
    rad = PI / 180;

// sun calculations are based on http://aa.quae.nl/en/reken/zonpositie.html formulas

// date/time constants and conversions

const int dayMs = 1000 * 60 * 60 * 24, J1970 = 2440588, J2000 = 2451545;

double toJulian(DateTime date) =>
    date.millisecondsSinceEpoch / dayMs - 0.5 + J1970;
DateTime fromJulian(j) => new DateTime.fromMillisecondsSinceEpoch(
    ((j + 0.5 - J1970) * dayMs).floor());

double toDays(date) => toJulian(date) - J2000;

// general calculations for position

const e = rad * 23.4397; // obliquity of the Earth

double rightAscension(l, b) => atan(sin(l) * cos(e) - tan(b) * sin(e), cos(l));
double declination(l, b) => asin(sin(b) * cos(e) + cos(b) * sin(e) * sin(l));

double azimuthCalc(H, phi, dec) =>
    atan(sin(H), cos(H) * sin(phi) - tan(dec) * cos(phi));
double altitudeCalc(H, phi, dec) =>
    asin(sin(phi) * sin(dec) + cos(phi) * cos(dec) * cos(H));

double siderealTime(d, lw) => rad * (280.16 + 360.9856235 * d) - lw;

double astroRefraction(h) {
  if (h < 0) // the following formula works for positive altitudes only.
    h = 0; // if h = -0.08901179 a div/0 would occur.

  // formula 16.4 of "Astronomical Algorithms" 2nd edition by Jean Meeus (Willmann-Bell, Richmond) 1998.
  // 1.02 / tan(h + 10.26 / (h + 5.10)) h in degrees, result in arc minutes -> converted to rad:
  return 0.0002967 / Math.tan(h + 0.00312536 / (h + 0.08901179));
}

// general sun calculations

double solarMeanAnomaly(d) => rad * (357.5291 + 0.98560028 * d);

double eclipticLongitude(M) {
  var C = rad *
          (1.9148 * sin(M) +
              0.02 * sin(2 * M) +
              0.0003 * sin(3 * M)), // equation of center
      P = rad * 102.9372; // perihelion of the Earth

  return M + C + P + PI;
}

Map sunCoords(d) {
  var M = solarMeanAnomaly(d), L = eclipticLongitude(M);

  return {'dec': declination(L, 0), 'ra': rightAscension(L, 0)};
}

class SunCalc {
  String koko;
  List times;
  // var getPosition;
  var azimuth;
  var altitude;
  DateTime solarNoon;
  DateTime nadir;
  double distance;
  double parallacticAngle;
  double moonFraction;
  double moonPhase;
  double moonAngle;
  var moonRise;
  var moonSet;
  String moonStatus;

  SunCalc(

      // var azimuth,
      {
    // int timezone,
    var getPosition,
    // double azimuth,
    // double altitude,
    // List times,
  }) {
    this.koko = "koko";

    // sun times configuration (angle, morning name, evening name)
    this.times = [
      [-0.833, 'sunrise', 'sunset'],
      [-0.3, 'sunriseEnd', 'sunsetStart'],
      [-6, 'dawn', 'dusk'],
      [-12, 'nauticalDawn', 'nauticalDusk'],
      [-18, 'nightEnd', 'night'],
      [6, 'goldenHourEnd', 'goldenHour']
    ];
    //end
  }

  // constructor
  // calculates sun position for a given date and latitude/longitude
  SunCalc.getPosition(date, lat, lng) {
    var lw = rad * -lng,
        phi = rad * lat,
        d = toDays(date),
        c = sunCoords(d),
        H = siderealTime(d, lw) - c["ra"];

    azimuth = azimuthCalc(H, phi, c["dec"]);
    altitude = altitudeCalc(H, phi, c["dec"]);
  }

  // adds a custom time to the times config
  SunCalc.addTime(angle, riseName, setName) {
    times.addAll([angle, riseName, setName]);
  }

  SunCalc.getTimes(date, lat, lng, height) {
    height = height ?? 0;

    var lw = rad * -lng,
        phi = rad * lat,
        dh = observerAngle(height),
        d = toDays(date),
        n = julianCycle(d, lw),
        ds = approxTransit(0, lw, n),
        M = solarMeanAnomaly(ds),
        L = eclipticLongitude(M),
        dec = declination(L, 0),
        Jnoon = solarTransitJ(ds, M, L),
        i,
        len,
        time,
        h0,
        Jset,
        Jrise;

    solarNoon = fromJulian(Jnoon);
    nadir = fromJulian(Jnoon - 0.5);

    // TODO
    var result = {
      'solarNoon': fromJulian(Jnoon),
      'nadir': fromJulian(Jnoon - 0.5)
    };

    print(solarNoon);
    // print(solarNoon);
    // print(nadir);
    for (int i = 0, len = SunCalc().times.length; i < len; i += 1) {
      time = SunCalc().times[i];
      print(time);

      h0 = (time[0] + dh) * rad;
      // print(h0);

      Jset = getSetJ(h0, lw, phi, dec, n, M, L);
      Jrise = Jnoon - (Jset - Jnoon);
      // print(Jset);
      // print(Jrise);
      // TODO
      //  result[time[1]] = fromJulian(Jrise);
      //   result[time[2]] = fromJulian(Jset);
      time[1] = fromJulian(Jrise);
      time[2] = fromJulian(Jset);
      // print(time[1]);
      // print(result[time[1]]);
      // print(time[2]);
      print(time);
    }
    // print(time);
    // print(result);
    // return result;
  }

  SunCalc.getMoonPosition(date, lat, lng) {
    var lw = rad * -lng;
    var phi = rad * lat;
    var d = toDays(date);
    var c = moonCoords(d);
    // print('$c $d $lw $phi');
    var H = siderealTime(d, lw) - c["ra"];
    var h = altitudeCalc(H, phi, c["dec"]);
    // formula 14.1 of "Astronomical Algorithms" 2nd edition by Jean Meeus (Willmann-Bell, Richmond) 1998.
    var pa = atan(sin(H), tan(phi) * cos(c["dec"]) - sin(c["dec"]) * cos(H));

    h = h + astroRefraction(h); // altitude correction for refraction

    // return
    azimuth = azimuthCalc(H, phi, c["dec"]);
    altitude = h;
    distance = c["dist"];
    parallacticAngle = pa;
  }

  // calculations for illumination parameters of the moon,
// based on http://idlastro.gsfc.nasa.gov/ftp/pro/astro/mphase.pro formulas and
// Chapter 48 of "Astronomical Algorithms" 2nd edition by Jean Meeus (Willmann-Bell, Richmond) 1998.

  SunCalc.getMoonIllumination(date) {
    var d = toDays(date ?? DateTime.now()),
        s = sunCoords(d),
        m = moonCoords(d),
        sdist = 149598000, // distance from Earth to Sun in km

        phi = acos(sin(s["dec"]) * sin(m["dec"]) +
            cos(s["dec"]) * cos(m["dec"]) * cos(s["ra"] - m["ra"])),
        inc = atan(sdist * sin(phi), m["dist"] - sdist * cos(phi)),
        _angle = atan(
            cos(s["dec"]) * sin(s["ra"] - m["ra"]),
            sin(s["dec"]) * cos(m["dec"]) -
                cos(s["dec"]) * sin(m["dec"]) * cos(s["ra"] - m["ra"]));
    // return
    moonFraction = (1 + cos(inc)) / 2;
    moonPhase = 0.5 + 0.5 * inc * (_angle < 0 ? -1 : 1) / PI;
    moonAngle = _angle;
  }

  // calculations for moon rise/set times are based on http://www.stargazing.net/kepler/moonrise.html article
  SunCalc.getMoonTimes(date, lat, lng, inUTC) {
    DateTime t = date;
    // if (inUTC) t.setUTCHours(0, 0, 0, 0);
    // else t.setHours(0, 0, 0, 0);
    if (inUTC)
      t.toUtc();
    else
      t.toLocal();

    var hc = 0.133 * rad,
        h0 = SunCalc.getMoonPosition(t, lat, lng).altitude - hc,
        h1,
        h2,
        rise,
        setting,
        a,
        b,
        xe,
        ye,
        d,
        roots,
        x1,
        x2,
        dx;

    // go in 2-hour chunks, each time seeing if a 3-point quadratic curve crosses zero (which means rise or set)
    for (var i = 1; i <= 24; i += 2) {
      h1 = SunCalc.getMoonPosition(hoursLater(t, i), lat, lng).altitude - hc;
      h2 =
          SunCalc.getMoonPosition(hoursLater(t, i + 1), lat, lng).altitude - hc;

      a = (h0 + h2) / 2 - h1;
      b = (h2 - h0) / 2;
      xe = -b / (2 * a);
      ye = (a * xe + b) * xe + h1;
      d = b * b - 4 * a * h1;
      roots = 0;

      if (d >= 0) {
        dx = Math.sqrt(d) / (a.abs() * 2);
        x1 = xe - dx;
        x2 = xe + dx;
        if (x1.abs() <= 1) roots++;
        if (x2.abs() <= 1) roots++;
        if (x1 < -1) x1 = x2;
      }

      if (roots == 1) {
        if (h0 < 0)
          rise = i + x1;
        else
          setting = i + x1;
      } else if (roots == 2) {
        rise = i + (ye < 0 ? x2 : x1);
        setting = i + (ye < 0 ? x1 : x2);
      }

      if (rise is double && setting is double) break;

      h0 = h2;
    }

    // print(rise);
    // print(setting);
    // return
    if (rise is double) moonRise = hoursLater(t, rise);
    if (setting is double) moonSet = hoursLater(t, setting);

    // if (rise is! double && setting is! double)
    moonStatus = ye > 0 ? 'alwaysUp' : 'alwaysDown';
  }
  // end

}

// calculations for sun times

const J0 = 0.0009;

julianCycle(d, lw) => (d - J0 - lw / (2 * PI)).round();

approxTransit(Ht, lw, n) => J0 + (Ht + lw) / (2 * PI) + n;
solarTransitJ(ds, M, L) => J2000 + ds + 0.0053 * sin(M) - 0.0069 * sin(2 * L);

hourAngle(h, phi, d) =>
    acos((sin(h) - sin(phi) * sin(d)) / (cos(phi) * cos(d)));
observerAngle(height) => -2.076 * Math.sqrt(height) / 60;

// returns set time for the given sun altitude
getSetJ(h, lw, phi, dec, n, M, L) {
  var w = hourAngle(h, phi, dec), a = approxTransit(w, lw, n);
  return solarTransitJ(a, M, L);
}

// calculates sun times for a given date, latitude/longitude, and, optionally,
// the observer height (in meters) relative to the horizon
// moon calculations, based on http://aa.quae.nl/en/reken/hemelpositie.html formulas
moonCoords(d) {
  // geocentric ecliptic coordinates of the moon

  var L = rad * (218.316 + 13.176396 * d), // ecliptic longitude
      M = rad * (134.963 + 13.064993 * d), // mean anomaly
      F = rad * (93.272 + 13.229350 * d), // mean distance

      l = L + rad * 6.289 * sin(M), // longitude
      b = rad * 5.128 * sin(F), // latitude
      dt = 385001 - 20905 * cos(M); // distance to the moon in km

  return {"ra": rightAscension(l, b), "dec": declination(l, b), "dist": dt};
}

hoursLater(date, h) => new DateTime.fromMillisecondsSinceEpoch(
    (date.millisecondsSinceEpoch + h * dayMs / 24).floor());

// // export as Node module / AMD module / browser variable
// if (typeof exports === 'object' && typeof module !== 'undefined') module.exports = SunCalc;
// else if (typeof define === 'function' && define.amd) define(SunCalc);
// else window.SunCalc = SunCalc;

main() {
  DateTime date = DateTime.now();

  double julianDate = toJulian(date);
  // (j + 0.5 - J1970) * dayMs)
  DateTime gDate = fromJulian(julianDate);
  double daysSince2000 = toDays(date);
  var position = SunCalc.getPosition(date, lat, lng);
  var koko = SunCalc().koko;
  var times = SunCalc().times;

  var getTimes = SunCalc.getTimes(date, lat, lng, height);
  var moonPosition = SunCalc.getMoonPosition(date, lat, lng);

  var moonIllumination = SunCalc.getMoonIllumination(date);

  var moonTimes = SunCalc.getMoonTimes(date, lat, lng, false);
  // RESULTS
  // print('julianDate: $julianDate');
  // print('gDate: $gDate');
  // print('daysSince2000: $daysSince2000');
  // print(
  //     'position: altitude: ${position.altitude} azimuth: ${position.azimuth}');
  // print('koko: $koko');
  // print('times: $times');
  // print('getTimes: $getTimes');
  // print(
  //     'moonPosition: altitude: ${moonPosition.altitude} azimuth: ${moonPosition.azimuth} distance: ${moonPosition.distance} parallacticAngle: ${moonPosition.parallacticAngle}');
  // print(
  // 'moonIllumination: moonFraction: ${moonIllumination.moonFraction} moonPhase: ${moonIllumination.moonPhase} moonAngle: ${moonIllumination.moonAngle}');
  // print(
  // 'moonTimes: moonRise ${moonTimes.moonRise} moonSet ${moonTimes.moonSet} moonStatus ${moonTimes.moonStatus}');
}
