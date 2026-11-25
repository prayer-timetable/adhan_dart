import 'package:adhan_dart/adhan_dart.dart';
import 'package:test/test.dart';

/// ishaBefore is yesterday's Isha and fajrAfter tomorrow's Fajr. Where
/// twilight never ends the high-latitude bound replaces them, and that bound
/// must be measured from yesterday's sunset and tomorrow's sunrise: it used
/// today's, so fajrAfter landed on today and ishaBefore after today's
/// Maghrib.
void main() {
  const oslo = Coordinates(59.9139, 10.7522);
  final date = DateTime.utc(2026, 6, 21);

  for (final method in [
    CalculationMethodParameters.muslimWorldLeague,
    CalculationMethodParameters.moonsightingCommittee,
  ]) {
    group('Oslo at midsummer, ${method().method}', () {
      PrayerTimes on(DateTime day) => PrayerTimes(
            date: day,
            coordinates: oslo,
            calculationParameters: method()
              ..highLatitudeRule = HighLatitudeRule.twilightAngle,
          );
      final today = on(date);

      test('fajrAfter is tomorrow morning, after tonight\'s Isha', () {
        expect(today.fajrAfter.isAfter(today.isha), isTrue,
            reason: 'fajrAfter ${today.fajrAfter}, isha ${today.isha}');
        final tomorrowSunrise = on(date.add(const Duration(days: 1))).sunrise;
        expect(today.fajrAfter.isBefore(tomorrowSunrise), isTrue);
      });

      test('ishaBefore is last night, before this morning\'s Fajr', () {
        expect(today.ishaBefore.isBefore(today.fajr), isTrue,
            reason: 'ishaBefore ${today.ishaBefore}, fajr ${today.fajr}');
        final yesterdayMaghrib =
            on(date.subtract(const Duration(days: 1))).maghrib;
        expect(today.ishaBefore.isAfter(yesterdayMaghrib), isTrue);
      });
    });
  }
}
