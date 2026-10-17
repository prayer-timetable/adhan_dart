import 'package:adhan_dart/adhan_dart.dart';
import 'package:adhan_dart/src/DateUtils.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(tzdata.initializeTimeZones);

  test('tomorrow is the next calendar day after the fall dst change', () {
    final zone = tz.getLocation('Europe/Brussels');
    final date = tz.TZDateTime(zone, 2026, 10, 25);
    final tomorrow = dateByAddingDays(date, 1);

    expect(tomorrow, isA<tz.TZDateTime>());
    expect([tomorrow.year, tomorrow.month, tomorrow.day, tomorrow.hour],
        [2026, 10, 26, 0]);
    expect(tomorrow.timeZoneOffset, const Duration(hours: 1));
  });

  test('yesterday is the previous calendar day after the spring change', () {
    final zone = tz.getLocation('Europe/Brussels');
    final date = tz.TZDateTime(zone, 2026, 3, 30);
    final yesterday = dateByAddingDays(date, -1);

    expect(yesterday, isA<tz.TZDateTime>());
    expect([yesterday.year, yesterday.month, yesterday.day, yesterday.hour],
        [2026, 3, 29, 0]);
    expect(yesterday.timeZoneOffset, const Duration(hours: 1));
  });

  test('utc calendar day addition stays utc', () {
    final result = dateByAddingDays(DateTime.utc(2026, 12, 31, 14, 15), 1);
    expect(result, DateTime.utc(2027, 1, 1, 14, 15));
    expect(result.isUtc, isTrue);
  });

  test('day of year is independent of daylight saving', () {
    final zone = tz.getLocation('Europe/Brussels');
    expect(dayOfYear(tz.TZDateTime(zone, 2026, 10, 14)), 287);
    expect(dayOfYear(tz.TZDateTime(zone, 2026, 1, 1)), 1);
    expect(dayOfYear(tz.TZDateTime(zone, 2024, 12, 31)), 366);
  });

  test('fajr and isha remain ordered on the autumn clock change', () {
    final zone = tz.getLocation('Europe/Brussels');
    final times = PrayerTimes(
      date: tz.TZDateTime(zone, 2026, 10, 25),
      coordinates: const Coordinates(50.8503, 4.3517),
      calculationParameters: CalculationMethodParameters.muslimWorldLeague(),
    );

    expect(times.fajr.isBefore(times.sunrise), isTrue);
    expect(times.maghrib.isBefore(times.isha), isTrue);
    expect(times.fajrAfter.isAfter(times.maghrib), isTrue);
  });
}
