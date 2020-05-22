import 'package:prayer_calc/src/PrayerCalc.dart';

// ICCI
double latI = 53.3046593;
double longI = -6.2344076;
double altitudeI = 50;
double angleI = 11.9;
// double angleI = 15;
int timezoneI = 0;

// Sarajevo
double latS = 43.8563;
double longS = 18.4131;
double altitudeS = 450;
double angleS = 14.6;
int timezoneS = 1;

PrayerCalc sarajevo = new PrayerCalc(latS, longS, altitudeS, angleS, timezoneS);
PrayerCalc icci = new PrayerCalc(latI, longI, altitudeI, angleI, timezoneI);

// optional parameters: int year, int month, int day, int asrMethod
// year, month, day defaults to current time,
// asrMethod defaults to 1 (Shafii), alternative is 2 (Hanafi)
// angle value sets both dawn and night twilight angle,
// if you use ishaAngle, then angle value is used for dawn and ishaAngle for night
// example (icci location, Hanafi, 1st January 2020, different ishaAngle):
PrayerCalc test = new PrayerCalc(latI, longI, altitudeI, angleI, timezoneI,
    asrMethod: 2, year: 2020, month: 1, day: 1, ishaAngle: 15);

main() {
  print('****** Sarajevo *******');
  print(sarajevo.dawn);
  print(sarajevo.sunrise);
  print(sarajevo.midday);
  print(sarajevo.afternoon);
  print(sarajevo.sunset);
  print(sarajevo.dusk);
  print('\n******** ICCI *********');
  print(icci.dawn);
  print(icci.sunrise);
  print(icci.midday);
  print(icci.afternoon);
  print(icci.sunset);
  print(icci.dusk);
  // print(icci.midnight);
  print('\n******** test *********');
  print(test.dawn);
  print(test.sunrise);
  print(test.midday);
  print(test.afternoon);
  print(test.sunset);
  print(test.dusk);
}
