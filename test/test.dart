// import 'package:prayers_calc/src/Prayers.dart';
// import 'package:prayers_calc/src/Sunnah.dart';
import 'package:prayers_calc/src/Index.dart';

// ICCI
double latI = 53.3046593;
double longI = -6.2344076;
double altitudeI = 85;
double angleI = 12.35;
double iangleI = 11.75;
int timezoneI = 0;

// Sarajevo
double latS = 43.8563;
double longS = 18.4131;
double altitudeS = 518;
double angleS = 14.6;
int timezoneS = 1;

// Prayers sarajevo = new Prayers(latS, longS, altitudeS, angleS, timezoneS);
Index sarajevo = new Index(timezoneS, latS, longS, altitudeS, angleS);
Index icci =
    new Index(timezoneI, latI, longI, altitudeI, angleI, ishaAngle: iangleI);

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
// Prayers test = new Prayers(latI, longI, altitudeI, angleI, timezoneI,
//     asrMethod: 2,
//     year: 2020,
//     month: 5,
//     day: 22,
//     ishaAngle: 15,
//     summerTimeCalc: false);

main() {
  print('****** Sarajevo *******');
  // print(sarajevo.prayers.today.sunset);
  // print(sarajevo.prayers.tomorrow.sunset);
  // print(sarajevo.prayers.yesterday.sunset);
  // print(sarajevo.sunnah.midnight);
  // print(sarajevo.sunnah.lastThird);
  print(sarajevo.durations.now);
  print(sarajevo.durations.current);
  print(sarajevo.durations.next);
  print(sarajevo.durations.previous);
  print(sarajevo.durations.isAfterIsha);
  print(sarajevo.durations.currentId);

  // print(sarajevo.prayers.sunrise);
  // print(sarajevo.prayers.midday);
  // print(sarajevo.prayers.afternoon);
  // print(sarajevo.prayers.sunset);
  // print(sarajevo.prayers.dusk);
  // print('\n******** ICCI *********');
  // print(icci.prayers.dawn);
  // print(icci.prayers.sunrise);
  // print(icci.prayers.midday);
  // print(icci.prayers.afternoon);
  // print(icci.prayers.sunset);
  // print(icci.prayers.dusk);
  // print(icci.midnight);
  // print('\n******** test *********');
  // print(test.dawn);
  // print(test.sunrise);
  // print(test.midday);
  // print(test.afternoon);
  // print(test.sunset);
  // print(test.dusk);
  // print(sarajevo.midnight);
  // print(sarajevo.lastThird);
  // print(sarajevo.prayers.sunset);
}
