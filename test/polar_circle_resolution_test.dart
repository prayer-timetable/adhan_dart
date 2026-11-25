import 'package:adhan_dart/adhan_dart.dart';
import 'package:adhan_dart/src/SolarTime.dart';
import 'package:test/test.dart';

/// Polar circle resolution must run on polar days and nights. The hour
/// angle is guarded against an out-of-range acos, so it is never NaN; the
/// check that triggered resolution used to look for NaN and never fired.
void main() {
  const tromso = Coordinates(69.6492, 18.9553);

  PrayerTimes timesOn(DateTime date, PolarCircleResolution resolution) {
    final params = CalculationMethodParameters.muslimWorldLeague()
      ..polarCircleResolution = resolution;
    return PrayerTimes(
      date: date,
      coordinates: tromso,
      calculationParameters: params,
    );
  }

  /// Fajr, sunrise, Dhuhr, Maghrib and Isha in order, each within a day of
  /// the date's solar noon. (Asr on a resolved day of an hour or two is a
  /// separate matter: the shadow angle is barely reached.)
  void expectSaneDay(PrayerTimes t, DateTime date) {
    final noon = DateTime.utc(date.year, date.month, date.day, 12)
        .subtract(Duration(minutes: (tromso.longitude * 4).round()));
    final times = [t.fajr, t.sunrise, t.dhuhr, t.maghrib, t.isha];
    for (var i = 1; i < times.length; i++) {
      expect(times[i].isAfter(times[i - 1]), isTrue,
          reason: 'out of order: $times');
    }
    for (final time in times) {
      expect(time.difference(noon).inHours.abs(), lessThan(24),
          reason: '$time is not on ${date.toIso8601String()}');
    }
  }

  test('SolarTime says when the sun does not rise or set', () {
    expect(SolarTime(DateTime.utc(2026, 6, 21), tromso).hasSunriseAndSunset,
        isFalse);
    expect(SolarTime(DateTime.utc(2026, 12, 21), tromso).hasSunriseAndSunset,
        isFalse);
    expect(SolarTime(DateTime.utc(2026, 3, 21), tromso).hasSunriseAndSunset,
        isTrue);
  });

  test('aqrabBalad gives a sane day in the midnight sun', () {
    final date = DateTime.utc(2026, 6, 21);
    expectSaneDay(timesOn(date, PolarCircleResolution.aqrabBalad), date);
  });

  test('aqrabYaum gives a sane day in the polar night', () {
    final date = DateTime.utc(2026, 12, 21);
    expectSaneDay(timesOn(date, PolarCircleResolution.aqrabYaum), date);
  });

  test('resolution changes the times only where the sun does not rise or set',
      () {
    final equinox = DateTime.utc(2026, 3, 21);
    expect(
      timesOn(equinox, PolarCircleResolution.aqrabBalad).sunrise,
      timesOn(equinox, PolarCircleResolution.unresolved).sunrise,
    );
    final solstice = DateTime.utc(2026, 6, 21);
    expect(
      timesOn(solstice, PolarCircleResolution.aqrabBalad).sunrise,
      isNot(timesOn(solstice, PolarCircleResolution.unresolved).sunrise),
    );
  });
}
