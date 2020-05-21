import 'dart:math';

class PrayerCalc {
  // final lat;
  // final fajr;

  PrayerCalc(
    double lat,
    double long,
    double altitude,
    double angle,
    int timezone, {
    int year,
    int month,
    int day,
    int asrMethod,
  }) {
    DateTime timestamp = DateTime.now().toUtc();
    DateTime beginingOfYear = DateTime(timestamp.year, 1, 1).toUtc();

    DateTime date = DateTime(
        year ?? timestamp.year, month ?? timestamp.month, day ?? timestamp.day);

    double H = altitude; // height above sea level in meters
    double B = lat; //	Latitude (Degrees)
    double L = long; // Longitude (Degrees)
    int Sh = asrMethod ?? 1; //	Sh=1 (Shafii) - Sh=2 (Hanafi)

    int TZ = timezone;

// int J = 142; //	Day of Year
    int hoursSinceBeginingOfYear = date.difference(beginingOfYear).inHours;
    double J = hoursSinceBeginingOfYear / 24;

    int G = 18; // ??? not used // Degrees

    double Gd = angle; //	Dawn’s Twilight Angle (15°-19°)
    double Gn = angle; // Night’s Twilight Angle (15°-19°)
    int R = 15 * TZ; // Reference Longitude (Degrees)

// ***** Solar Declination D (Degrees)
    double gama = 2 * pi * (J - 0) / 365; // or J-1? //TODO: 366 for leap
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
    double U1 =
        sin((-0.83333 - 0.0347 * H / H.abs() * pow(H.abs(), 0.5)) * deg);
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
    DateTime getTime(hourFraction) {
      int hour = hourFraction.floor();
      int minute = ((hourFraction - hour) * 60).round();
      return DateTime(date.year, date.month, date.day, hour, minute);
    }

    double noonFraction = Z;
    DateTime noon = getTime(noonFraction);

    double sunriseFraction = Z - U;
    DateTime sunrise = getTime(sunriseFraction);

    double dawnFraction = Z - Vd;
    DateTime dawn = getTime(dawnFraction);

    double duskFraction = Z + Vn;
    DateTime dusk = getTime(duskFraction);

    double sunsetFraction = Z + U;
    DateTime sunset = getTime(sunsetFraction);

    double afternoonFraction = Z + W;
    DateTime afternoon = getTime(afternoonFraction);

    // this.fajr = dawn;

    // return PrayerCalc(lat, long,)
    // return dawn;
  }
}

//
// main() {
//   // print('J\t$J');
//   // // print('D\t$T');
//   // print('D\t$D');
//   // print('DD\t$DD');
//   // print('DDD\t$DDD');
//   // print('DDDD\t$DDDD');
//   // print('T\t$T');
//   // print(now.isUtc);
//   // print(now);
//   // print(beginingOfYear);
//   // print('beta $beta gama $gama');
//   // print('U1\t$U1');
//   // print('U2\t$U2');
//   // print('U3\t$U3');
//   // print('U4\t$U4');
//   // print('U\t$U');
//   // print('H\t${H / H.abs()}');
//   // print(pow(H.abs(), 0.5));
//   // print('Vd1\t$Vd1');
//   // print('Vd2\t$Vd2');
//   // print('Vd3\t$Vd3');
//   // print('Vd4\t$Vd4');
//   // print('Vd\t$Vd');
//   // print((-Vd2 - Vd3) / Vd4);

//   print('W1\t$W1');
//   print('W\t$W');

//   print('dawn\t$dawn');
//   print('sunrise\t$sunrise');
//   print('noon\t$noon');
//   print('af\'noon\t$afternoon');
//   print('sunset\t$sunset');
//   print('dusk\t$dusk');
// }
