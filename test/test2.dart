// ignore_for_file: avoid_print

import 'package:adhan_dart/adhan_dart.dart';
import 'package:adhan_dart/src/DateUtils.dart';

main() {
  Coordinates coordinates =
      const Coordinates(17.3850, 78.4867); //Hyderabad Coordinates [Asia/Kolkata]
  CalculationParameters calculationParameters =
      CalculationMethodParameters.karachi();
  PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: DateTime.now(),
      calculationParameters: calculationParameters);

  int timezoneAdj = (5.5 * 60).toInt();
  int currentDayOfYear = dayOfYear(DateTime.now());
  int firstJan = dayOfYear(DateTime(2021, 1, 1));

  print(prayerTimes.fajr.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.dhuhr.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.asr.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.maghrib.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.isha.add(Duration(minutes: timezoneAdj)));
  print(currentDayOfYear);
  print(firstJan);
}
