import 'dart:math';
import 'package:prayer_calc/src/components/Prayers.dart';
import 'package:prayer_calc/src/func/helpers.dart';

Prayers prayerCalc({
  int timezone,
  double lat,
  double long,
  double altitude,
  double angle,
  DateTime date,
  int dayOfYear,
  bool isLeap,
  int asrMethod,
  double ishaAngle,
  bool summerTimeCalc: true,
}) {
  // check if leap year
  bool isLeap = date.year % 4 == 0;

  DateTime dateLocal = date;

  // dateUtc = date.toUtc();
  // print((date));

  int TZ = timezone ?? 0;
  double H = altitude ?? 0; // height above sea level in meters
  double B = lat ?? 0; //	Latitude (Degrees)
  double L = long ?? 0; // Longitude (Degrees)
  int Sh = asrMethod ?? 1; //	Sh=1 (Shafii) - Sh=2 (Hanafi)
  double Gd = angle ?? 0; //	Dawn’s Twilight Angle (15°-19°)
  double Gn = ishaAngle ?? angle ?? 0; // Night’s Twilight Angle (15°-19°)
  int R = 15 * TZ; // Reference Longitude (Degrees)

  //	Day of Year
  // date needs to be utc for accurate calculation
  int J = dayOfYear;

  // ***** Solar Declination D (Degrees)
  int daysInYear = isLeap ? 366 : 365;
  double gama = 2 *
      pi *
      (J - 0) /
      daysInYear; // or J-1? // daysInYear is 366 for leap, otherwise 365
  double Drad = 0.006918 -
      0.399912 * cos(gama) +
      0.070257 * sin(gama) -
      0.006758 * cos(2 * gama) +
      0.000907 * sin(2 * gama) -
      0.002697 * cos(3 * gama) +
      0.00148 * sin(3 * gama);
  double D = Drad * 180 / pi;

// ***** Equation of Time EQT
  double T = 229.183 * // 1440/pi - to change from radians to minutes
      (0.000075 +
          0.001868 * cos(gama) -
          0.032077 * sin(gama) -
          0.014615 * cos(2 * gama) -
          0.040849 * sin(2 * gama)); //Equation of Time (Minutes)

// ***** Midday Z
  double Z = 12 + (R - L) / 15 - T / 60;

// ***** Offsets U Vd Vn W
// factors
  double factor = 12 / pi; // 180 / (15 * pi)
  double deg = pi / 180; // convert radians to degrees
  double sinCalc = sin(D * deg) * sin(B * deg);
  double cosCalc = cos(D * deg) * cos(B * deg);
// func
  double mainCalc(offset) => factor * acos((offset - sinCalc) / cosCalc);
  acot(x) => atan(1 / x);

// sunrise offset
  double U1 = sin((-0.83333 - 0.0347 * H / H.abs() * pow(H.abs(), 0.5)) * deg);
  double U = mainCalc(U1);

// dawn offset
  double Vd1 = -sin(Gd * deg);
  double Vd = mainCalc(Vd1);

// dusk offset
  double Vn1 = -sin(Gn * deg);
  double Vn = mainCalc(Vn1);

// afternoon offset
  double W1 = sin(acot(Sh + tan((B - D).abs() * deg)));
  double W = mainCalc(W1);

// ***** prayer times

  // print('$Z $Vd $U $W, $Vn');
  double dawnFraction = Vd.isNaN
      ? Z - U - 1.5
      : Z -
          Vd; // if dawn can not be calculated, make it 1.5 hours before sunrise
  double sunriseFraction = Z - U;
  double middayFraction = Z;
  double afternoonFraction = Z + W;
  double sunsetFraction = Z + U;
  double duskFraction = Vn.isNaN
      ? Z + U + 1.5
      : Z + Vn; // if dusk can not be calculated, make it 1.5 hours after sunset

  Prayers prayers = new Prayers();
  prayers.dawn =
      hourFractionToDateTime(dawnFraction, dateLocal, summerTimeCalc);
  prayers.sunrise =
      hourFractionToDateTime(sunriseFraction, dateLocal, summerTimeCalc);
  prayers.midday =
      hourFractionToDateTime(middayFraction, dateLocal, summerTimeCalc);
  prayers.afternoon =
      hourFractionToDateTime(afternoonFraction, dateLocal, summerTimeCalc);
  prayers.sunset =
      hourFractionToDateTime(sunsetFraction, dateLocal, summerTimeCalc);
  prayers.dusk =
      hourFractionToDateTime(duskFraction, dateLocal, summerTimeCalc);

  return prayers;
}
