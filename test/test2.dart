import 'package:adhan/adhan.dart';

main() {
  Coordinates coordinates =
      Coordinates(17.3850, 78.4867); //Hyderabad Coordinates [Asia/Kolkata]
  CalculationParameters calculationParameters = CalculationMethod.Karachi();
  // calculationParameters.ishaAngle = 18;
  PrayerTimes prayerTimes =
      PrayerTimes(coordinates, DateTime.now(), calculationParameters);

  // print(calculationParameters.ishaAngle);
  print(prayerTimes.fajr.toLocal());
  print(prayerTimes.dhuhr.toLocal());
  print(prayerTimes.asr.toLocal());
  print(prayerTimes.maghrib.toLocal());
  print(prayerTimes.isha.toLocal());
}
// main() => timetableTest();
