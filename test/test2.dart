import 'package:adhan/adhan.dart';

main() {
  Coordinates coordinates =
      Coordinates(17.3850, 78.4867); //Hyderabad Coordinates [Asia/Kolkata]
  CalculationParameters calculationParameters = CalculationMethod.Karachi();
  PrayerTimes prayerTimes =
      PrayerTimes(coordinates, DateTime.now(), calculationParameters);

  int timezoneAdj = (5.5 * 60).toInt();

  print(prayerTimes.fajr.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.dhuhr.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.asr.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.maghrib.add(Duration(minutes: timezoneAdj)));
  print(prayerTimes.isha.add(Duration(minutes: timezoneAdj)));
}
