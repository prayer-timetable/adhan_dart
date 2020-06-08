// import 'dart:math';
// import 'package:prayer_calc/src/helpers.dart';
import 'package:prayer_calc/src/classes/Coordinates.dart';
import 'package:prayer_calc/src/classes/CalculationMethod.dart';
import 'package:prayer_calc/src/classes/CalculationParameters.dart';
import 'package:prayer_calc/src/classes/Madhab.dart';
import 'package:prayer_calc/src/classes/PrayerTimes.dart';

const lat = 43.8563;
const lng = 18.4131;
const alt = 518;
const angleF = 14.6; //iz =19
const angleI = 14.6; // iz = 17
const timezone = 1;
const height = 1.8;

main() {
  var date = DateTime.now().add(Duration(days: 1));
  var coordinates = new Coordinates(lat, lng);
  CalculationParameters params = CalculationMethod.Other();
  params.madhab = Madhab.Shafi;
  params.methodAdjustments = {'dhuhr': 0};
  params.ishaAngle = angleI;
  params.fajrAngle = angleF;

  var prayerTimes = new PrayerTimes(coordinates, date, params);

  var fajrTime = prayerTimes.fajr.toLocal();
  print(prayerTimes.fajr.timeZoneName);
  print(fajrTime.timeZoneName);

// var fajrTime = moment(prayerTimes.fajr).tz('Europe/Sarajevo').format('h:mm A');
// var sunriseTime = moment(prayerTimes.sunrise).tz('Europe/Sarajevo').format('h:mm A');
// var dhuhrTime = moment(prayerTimes.dhuhr).tz('Europe/Sarajevo').format('h:mm A');
// var asrTime = moment(prayerTimes.asr).tz('Europe/Sarajevo').format('h:mm A');
// var maghribTime = moment(prayerTimes.maghrib).tz('Europe/Sarajevo').format('h:mm A');
// var ishaTime = moment(prayerTimes.isha).tz('Europe/Sarajevo').format('h:mm A');

  print('fajr\t${prayerTimes.fajr}');
  print('sunrise\t${prayerTimes.sunrise}');
  print('dhuhr\t${prayerTimes.dhuhr}');
  print('asr\t${prayerTimes.asr}');
  print('maghrib\t${prayerTimes.maghrib}');
  print('isha\t${prayerTimes.isha}');
  // print(params.madhab);
}
