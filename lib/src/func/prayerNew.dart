import 'dart:math';
import 'package:prayer_calc/src/components/Prayers.dart';
import 'package:prayer_calc/src/func/helpers.dart';
import 'package:prayer_calc/src/func/classes/Coordinates.dart';
import 'package:prayer_calc/src/func/classes/CalculationMethod.dart';

const  lat = 43.8563;
const  lng = 18.4131;
const  alt = 518;
const  angleF = 14.6; //iz =19
const  angleI = 14.6; // iz = 17
const  timezone = 1;
const  height = 1.8;

var date = DateTime.now();
var coordinates = new Coordinates(lat, lng);
var params = CalculationMethod.MuslimWorldLeague();
params.madhab = adhan.Madhab.Hanafi;
var prayerTimes = new adhan.PrayerTimes(coordinates, date, params);

var fajrTime = moment(prayerTimes.fajr).tz('Europe/Sarajevo').format('h:mm A');
var sunriseTime = moment(prayerTimes.sunrise).tz('Europe/Sarajevo').format('h:mm A');
var dhuhrTime = moment(prayerTimes.dhuhr).tz('Europe/Sarajevo').format('h:mm A');
var asrTime = moment(prayerTimes.asr).tz('Europe/Sarajevo').format('h:mm A');
var maghribTime = moment(prayerTimes.maghrib).tz('Europe/Sarajevo').format('h:mm A');
var ishaTime = moment(prayerTimes.isha).tz('Europe/Sarajevo').format('h:mm A');

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
  bool showSeconds: false,
}) {



  // return prayers;
}
