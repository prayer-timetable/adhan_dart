import 'package:prayers_calc/src/PrayersCalc.dart';

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
PrayersCalc sarajevo =
    new PrayersCalc(timezoneS, latS, longS, altitudeS, angleS);
PrayersCalc icci = new PrayersCalc(timezoneI, latI, longI, altitudeI, angleI,
    ishaAngle: iangleI);

// optional parameters:
// int year, int month, int day, int asrMethod, double ishaAngle, bool summerTimeCalc
//
// year, month, day defaults to current time,
// asrMethod defaults to 1 (Shafii), alternative is 2 (Hanafi)
// angle value sets both dawn and night twilight angle,
// if you use ishaAngle, then angle value is used for dawn and ishaAngle for night
// summerTimeCalc is true by default, set to false if no daylight saving should happen
//
// example (icci location, Hanafi, 1st June 2020, different ishaAngle, no summer time):
PrayersCalc test = new PrayersCalc(
  timezoneI,
  latI,
  longI,
  altitudeI,
  angleI,
  ishaAngle: 15,
  asrMethod: 2,
  summerTimeCalc: false,
  year: 2020,
  month: 6,
  day: 1,
);

PrayersCalc location = icci;

main() {
  print('**************** Today *****************');
  print('dawn:\t\t${location.prayers.today.dawn}');
  print('sunrise:\t${location.prayers.today.sunrise}');
  print('midday:\t\t${location.prayers.today.midday}');
  print('afternoon:\t${location.prayers.today.afternoon}');
  print('sunset:\t\t${location.prayers.today.sunset}');
  print('dusk:\t\t${location.prayers.today.dusk}');
  print('*************** Tomorrow **************');
  print('dawn:\t\t${location.prayers.tomorrow.dawn}');
  print('sunrise:\t${location.prayers.tomorrow.sunrise}');
  print('midday:\t\t${location.prayers.tomorrow.midday}');
  print('afternoon:\t${location.prayers.tomorrow.afternoon}');
  print('sunset:\t\t${location.prayers.tomorrow.sunset}');
  print('dusk:\t\t${location.prayers.tomorrow.dusk}');
  print('************** Yesterday ***************');
  print('dawn:\t\t${location.prayers.yesterday.dawn}');
  print('sunrise:\t${location.prayers.yesterday.sunrise}');
  print('midday:\t\t${location.prayers.yesterday.midday}');
  print('afternoon:\t${location.prayers.yesterday.afternoon}');
  print('sunset:\t\t${location.prayers.yesterday.sunset}');
  print('dusk:\t\t${location.prayers.yesterday.dusk}');
  print('*************** Sunnah *****************');
  print('midnight:\t${location.sunnah.midnight}');
  print('lastThird\t${location.sunnah.lastThird}');
  print('************** Durations ***************');
  print('nowLocal:\t${location.durations.nowLocal}');
  print('current:\t${location.durations.current}');
  print('next:\t\t${location.durations.next}');
  print('previous:\t${location.durations.previous}');
  print('isAfterIsha:\t${location.durations.isAfterIsha}');
  print('currentId:\t${location.durations.currentId}');
  print('countDown:\t${location.durations.countDown}');
  print('countUp:\t${location.durations.countUp}');
  print(location.today);
}
