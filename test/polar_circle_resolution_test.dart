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

  // ishaBefore and fajrAfter belong to the neighbouring days, so their solar
  // times must be resolved for those days too: resolving only today's left
  // them on the unresolved sunrise/sunset, which the guarded acos rule puts
  // weeks away (Tromsø, 21 June: 28 days early).
  void expectNeighbouringDaysAdjacent(
      String label, DateTime date, PolarCircleResolution resolution) {
    final times = timesOn(date, resolution);

    expect(times.fajrAfter.difference(times.isha).inHours.abs(),
        lessThanOrEqualTo(24),
        reason: '$label: isha ${times.isha}, fajrAfter ${times.fajrAfter}');
    expect(times.fajr.difference(times.ishaBefore).inHours.abs(),
        lessThanOrEqualTo(24),
        reason: '$label: ishaBefore ${times.ishaBefore}, fajr ${times.fajr}');
  }

  test('neighbouring days stay adjacent in the midnight sun', () {
    expectNeighbouringDaysAdjacent('the midnight sun',
        DateTime.utc(2026, 6, 21), PolarCircleResolution.aqrabBalad);
  });

  test('neighbouring days stay adjacent in the polar night', () {
    expectNeighbouringDaysAdjacent('the polar night',
        DateTime.utc(2026, 12, 21), PolarCircleResolution.aqrabYaum);
  });

  test('neighbouring days stay ordered below the polar circle', () {
    // Where the sunrise and sunset exist, resolution must not run at all and
    // ishaBefore/fajrAfter stay strictly ordered around tonight.
    const dublin = Coordinates(53.3498, -6.2603);
    final date = DateTime.utc(2026, 6, 21);
    for (final resolution in PolarCircleResolution.values) {
      final times = PrayerTimes(
        date: date,
        coordinates: dublin,
        calculationParameters: CalculationMethodParameters.muslimWorldLeague()
          ..polarCircleResolution = resolution
          ..highLatitudeRule = HighLatitudeRule.twilightAngle,
      );
      expect(times.fajrAfter.isAfter(times.isha), isTrue,
          reason: '$resolution: isha ${times.isha}, '
              'fajrAfter ${times.fajrAfter}');
      expect(times.ishaBefore.isBefore(times.fajr), isTrue,
          reason: '$resolution: ishaBefore ${times.ishaBefore}, '
              'fajr ${times.fajr}');
    }
  });
}
