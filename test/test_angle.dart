import 'package:prayer_calc/src/PrayerCalc.dart';

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
PrayerCalc sarajevo = new PrayerCalc(
  timezoneS,
  latS,
  longS,
  altitudeS,
  angleS,
  year: 2020,
  month: 3,
  day: 28,
);
PrayerCalc icci = new PrayerCalc(timezoneI, latI, longI, altitudeI, angleI,
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
PrayerCalc test = new PrayerCalc(
  timezoneI,
  latI,
  longI,
  altitudeI,
  angleI,
  ishaAngle: 15,
  asrMethod: 2,
  summerTimeCalc: false,
  year: 2020,
  month: 3,
  day: 28,
);

PrayerCalc location = sarajevo;

angleTest() {
  print('**************** current *****************');
  print('dawn:\t\t${location.prayers.current.dawn}');
  print('sunrise:\t${location.prayers.current.sunrise}');
  print('midday:\t\t${location.prayers.current.midday}');
  print('afternoon:\t${location.prayers.current.afternoon}');
  print('sunset:\t\t${location.prayers.current.sunset}');
  print('dusk:\t\t${location.prayers.current.dusk}');
  print('*************** next **************');
  print('dawn:\t\t${location.prayers.next.dawn}');
  print('sunrise:\t${location.prayers.next.sunrise}');
  print('midday:\t\t${location.prayers.next.midday}');
  print('afternoon:\t${location.prayers.next.afternoon}');
  print('sunset:\t\t${location.prayers.next.sunset}');
  print('dusk:\t\t${location.prayers.next.dusk}');
  print('************** previous ***************');
  print('dawn:\t\t${location.prayers.previous.dawn}');
  print('sunrise:\t${location.prayers.previous.sunrise}');
  print('midday:\t\t${location.prayers.previous.midday}');
  print('afternoon:\t${location.prayers.previous.afternoon}');
  print('sunset:\t\t${location.prayers.previous.sunset}');
  print('dusk:\t\t${location.prayers.previous.dusk}');
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
  print(location.current); // TODO
  print(location.dayOfYear);
}
