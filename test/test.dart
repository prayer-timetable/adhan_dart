import 'package:prayer_calc/src/calc.dart';

// // ICCI
// List latLng = [53.3046593, -6.2344076]; // ICCI
// int TZ = 0; // Time Zone (Hours)
// double angle = 11.9;

// Sarajevo

double lat = 43.8563;
double long = 18.4131;
double altitude = 450;
double angle = 14.6;
int timezone = 1;

PrayerCalc sarajevo = new PrayerCalc(lat, long, altitude, angle, timezone);

main() {}
