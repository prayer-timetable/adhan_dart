import 'package:prayers_calc/src/Prayers.dart';

// ICCI
double latI = 53.3046593;
double longI = -6.2344076;
double altitudeI = 85;
double angleI = 12.3;
double iangleI = 20.7;
int timezoneI = 0;

// Sarajevo
double latS = 43.8563;
double longS = 18.4131;
double altitudeS = 518;
double angleS = 14.6;
int timezoneS = 1;

Prayers sarajevo = new Prayers(latS, longS, altitudeS, angleS, timezoneS);
Prayers icci =
    new Prayers(latI, longI, altitudeI, angleI, timezoneI, ishaAngle: iangleI);

// optional parameters:
// int year, int month, int day, int asrMethod, double ishaAngle, bool summerTimeCalc
//
// year, month, day defaults to current time,
// asrMethod defaults to 1 (Shafii), alternative is 2 (Hanafi)
// angle value sets both dawn and night twilight angle,
// if you use ishaAngle, then angle value is used for dawn and ishaAngle for night
// summerTimeCalc is true by default, set to false if no daylight saving should happen
//
// example (icci location, Hanafi, 1st January 2020, different ishaAngle):
Prayers test = new Prayers(latI, longI, altitudeI, angleI, timezoneI,
    asrMethod: 2,
    year: 2020,
    month: 5,
    day: 22,
    ishaAngle: 15,
    summerTimeCalc: false);

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
