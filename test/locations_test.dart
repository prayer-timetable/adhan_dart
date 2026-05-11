import 'package:adhan_dart/adhan_dart.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Helper to extract HH:mm from a UTC DateTime in a given timezone.
String timeString(DateTime utcTime, tz.Location location) {
  final local = tz.TZDateTime.from(utcTime, location);
  final h = local.hour.toString().padLeft(2, '0');
  final m = local.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
  });

  // ---------------------------------------------------------------
  // Additional location-specific prayer time regression tests.
  //
  // Expected values were computed using adhan_dart itself to serve
  // as regression anchors — any future change that alters the
  // calculation output will be caught here.
  // ---------------------------------------------------------------

  group('Karachi method — Karachi, Pakistan', () {
    // Coordinates: 24.8607, 67.0011
    // Method: Karachi (Fajr 18°, Isha 18°)
    // Source: regression values from adhan_dart v1.2.0

    late tz.Location location;
    final coordinates = const Coordinates(24.8607, 67.0011);

    setUp(() {
      location = tz.getLocation('Asia/Karachi');
    });

    test('winter — 2024-01-15', () {
      final date = tz.TZDateTime(location, 2024, 1, 15);
      final params = CalculationMethodParameters.karachi();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('05:58'));
      expect(timeString(pt.sunrise, location), equals('07:19'));
      expect(timeString(pt.dhuhr, location), equals('12:42'));
      expect(timeString(pt.asr, location), equals('15:44'));
      expect(timeString(pt.maghrib, location), equals('18:04'));
      expect(timeString(pt.isha, location), equals('19:24'));
    });

    test('summer — 2024-07-15', () {
      final date = tz.TZDateTime(location, 2024, 7, 15);
      final params = CalculationMethodParameters.karachi();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:25'));
      expect(timeString(pt.sunrise, location), equals('05:52'));
      expect(timeString(pt.dhuhr, location), equals('12:39'));
      expect(timeString(pt.asr, location), equals('16:02'));
      expect(timeString(pt.maghrib, location), equals('19:24'));
      expect(timeString(pt.isha, location), equals('20:51'));
    });
  });

  group('Karachi method — Islamabad, Pakistan (Hanafi)', () {
    // Coordinates: 33.6844, 73.0479
    // Method: Karachi, Madhab: Hanafi
    // Source: regression values from adhan_dart v1.2.0

    late tz.Location location;
    final coordinates = const Coordinates(33.6844, 73.0479);

    setUp(() {
      location = tz.getLocation('Asia/Karachi');
    });

    test('winter — 2024-01-15', () {
      final date = tz.TZDateTime(location, 2024, 1, 15);
      final params = CalculationMethodParameters.karachi()
        ..madhab = Madhab.hanafi;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('05:45'));
      expect(timeString(pt.sunrise, location), equals('07:13'));
      expect(timeString(pt.dhuhr, location), equals('12:18'));
      expect(timeString(pt.asr, location), equals('15:44'));
      expect(timeString(pt.maghrib, location), equals('17:22'));
      expect(timeString(pt.isha, location), equals('18:49'));
    });

    test('summer — 2024-07-15', () {
      final date = tz.TZDateTime(location, 2024, 7, 15);
      final params = CalculationMethodParameters.karachi()
        ..madhab = Madhab.hanafi;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('03:28'));
      expect(timeString(pt.sunrise, location), equals('05:09'));
      expect(timeString(pt.dhuhr, location), equals('12:15'));
      expect(timeString(pt.asr, location), equals('17:11'));
      expect(timeString(pt.maghrib, location), equals('19:19'));
      expect(timeString(pt.isha, location), equals('20:59'));
    });
  });

  group('Morocco method — Casablanca', () {
    // Coordinates: 33.5731, -7.5898
    // Method: Morocco (Fajr 19°, Isha 17°)
    // Source: regression values from adhan_dart v1.2.0

    late tz.Location location;
    final coordinates = const Coordinates(33.5731, -7.5898);

    setUp(() {
      location = tz.getLocation('Africa/Casablanca');
    });

    test('winter — 2024-01-15', () {
      final date = tz.TZDateTime(location, 2024, 1, 15);
      final params = CalculationMethodParameters.morocco();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('07:02'));
      expect(timeString(pt.sunrise, location), equals('08:32'));
      expect(timeString(pt.dhuhr, location), equals('13:45'));
      expect(timeString(pt.asr, location), equals('16:26'));
      expect(timeString(pt.maghrib, location), equals('18:50'));
      expect(timeString(pt.isha, location), equals('20:07'));
    });

    test('summer — 2024-07-15', () {
      final date = tz.TZDateTime(location, 2024, 7, 15);
      final params = CalculationMethodParameters.morocco();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:45'));
      expect(timeString(pt.sunrise, location), equals('06:29'));
      expect(timeString(pt.dhuhr, location), equals('13:41'));
      expect(timeString(pt.asr, location), equals('17:20'));
      expect(timeString(pt.maghrib, location), equals('20:46'));
      expect(timeString(pt.isha, location), equals('22:14'));
    });
  });

  group('NorthAmerica method — New York', () {
    // Coordinates: 40.7128, -74.0060
    // Method: NorthAmerica/ISNA (Fajr 15°, Isha 15°)
    // Source: regression values from adhan_dart v1.2.0

    late tz.Location location;
    final coordinates = const Coordinates(40.7128, -74.0060);

    setUp(() {
      location = tz.getLocation('America/New_York');
    });

    test('winter — 2024-01-15', () {
      final date = tz.TZDateTime(location, 2024, 1, 15);
      final params = CalculationMethodParameters.northAmerica();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('05:58'));
      expect(timeString(pt.sunrise, location), equals('07:18'));
      expect(timeString(pt.dhuhr, location), equals('12:06'));
      expect(timeString(pt.asr, location), equals('14:34'));
      expect(timeString(pt.maghrib, location), equals('16:53'));
      expect(timeString(pt.isha, location), equals('18:13'));
    });

    test('summer — 2024-07-15', () {
      final date = tz.TZDateTime(location, 2024, 7, 15);
      final params = CalculationMethodParameters.northAmerica();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:03'));
      expect(timeString(pt.sunrise, location), equals('05:38'));
      expect(timeString(pt.dhuhr, location), equals('13:03'));
      expect(timeString(pt.asr, location), equals('17:00'));
      expect(timeString(pt.maghrib, location), equals('20:26'));
      expect(timeString(pt.isha, location), equals('22:00'));
    });
  });

  group('Singapore method — Jakarta, Indonesia', () {
    // Coordinates: -6.2088, 106.8456
    // Method: Singapore (Fajr 20°, Isha 18°)
    // Near-equatorial location — minimal seasonal variation expected
    // Source: regression values from adhan_dart v1.2.0

    late tz.Location location;
    final coordinates = const Coordinates(-6.2088, 106.8456);

    setUp(() {
      location = tz.getLocation('Asia/Jakarta');
    });

    test('January — 2024-01-15', () {
      final date = tz.TZDateTime(location, 2024, 1, 15);
      final params = CalculationMethodParameters.singapore();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:25')); // Rounding.up on Singapore method
      expect(timeString(pt.sunrise, location), equals('05:49'));
      expect(timeString(pt.dhuhr, location), equals('12:03'));
      expect(timeString(pt.asr, location), equals('15:27'));
      expect(timeString(pt.maghrib, location), equals('18:16'));
      expect(timeString(pt.isha, location), equals('19:31'));
    });

    test('July — 2024-07-15', () {
      final date = tz.TZDateTime(location, 2024, 7, 15);
      final params = CalculationMethodParameters.singapore();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:43')); // Rounding.up on Singapore method
      expect(timeString(pt.sunrise, location), equals('06:05'));
      expect(timeString(pt.dhuhr, location), equals('12:00'));
      expect(timeString(pt.asr, location), equals('15:21'));
      expect(timeString(pt.maghrib, location), equals('17:53'));
      expect(timeString(pt.isha, location), equals('19:07'));
    });
  });

  group('MuslimWorldLeague method — Riyadh, Saudi Arabia', () {
    // Coordinates: 24.7136, 46.6753
    // Method: MuslimWorldLeague (Fajr 18°, Isha 17°)
    // Source: regression values from adhan_dart v1.2.0

    late tz.Location location;
    final coordinates = const Coordinates(24.7136, 46.6753);

    setUp(() {
      location = tz.getLocation('Asia/Riyadh');
    });

    test('winter — 2024-01-15', () {
      final date = tz.TZDateTime(location, 2024, 1, 15);
      final params = CalculationMethodParameters.muslimWorldLeague();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('05:19'));
      expect(timeString(pt.sunrise, location), equals('06:40'));
      expect(timeString(pt.dhuhr, location), equals('12:03'));
      expect(timeString(pt.asr, location), equals('15:05'));
      expect(timeString(pt.maghrib, location), equals('17:26'));
      expect(timeString(pt.isha, location), equals('18:41'));
    });

    test('summer — 2024-07-15', () {
      final date = tz.TZDateTime(location, 2024, 7, 15);
      final params = CalculationMethodParameters.muslimWorldLeague();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('03:47'));
      expect(timeString(pt.sunrise, location), equals('05:14'));
      expect(timeString(pt.dhuhr, location), equals('12:00'));
      expect(timeString(pt.asr, location), equals('15:22'));
      expect(timeString(pt.maghrib, location), equals('18:45'));
      expect(timeString(pt.isha, location), equals('20:06'));
    });
  });

  group('Seasonal variation sanity checks', () {
    /// Returns minutes since midnight for a UTC prayer time in the given timezone.
    int minutesOfDay(DateTime utcTime, tz.Location location) {
      final local = tz.TZDateTime.from(utcTime, location);
      return local.hour * 60 + local.minute;
    }

    test('near-equatorial Jakarta has minimal seasonal Fajr variation', () {
      final location = tz.getLocation('Asia/Jakarta');
      final coordinates = const Coordinates(-6.2088, 106.8456);
      final params = CalculationMethodParameters.singapore();

      final winter = PrayerTimes(
          coordinates: coordinates,
          date: tz.TZDateTime(location, 2024, 1, 15),
          calculationParameters: params);
      final summer = PrayerTimes(
          coordinates: coordinates,
          date: tz.TZDateTime(location, 2024, 7, 15),
          calculationParameters: params);

      // Jakarta is near the equator — Fajr shouldn't vary by more than ~30 min
      final diff = (minutesOfDay(summer.fajr, location) -
              minutesOfDay(winter.fajr, location))
          .abs();
      expect(diff, lessThan(30));
    });

    test('high-latitude New York has large seasonal Maghrib variation', () {
      final location = tz.getLocation('America/New_York');
      final coordinates = const Coordinates(40.7128, -74.0060);
      final params = CalculationMethodParameters.northAmerica();

      final winter = PrayerTimes(
          coordinates: coordinates,
          date: tz.TZDateTime(location, 2024, 1, 15),
          calculationParameters: params);
      final summer = PrayerTimes(
          coordinates: coordinates,
          date: tz.TZDateTime(location, 2024, 7, 15),
          calculationParameters: params);

      // NYC at 40° latitude — Maghrib should vary by more than 3 hours
      final diff = (minutesOfDay(summer.maghrib, location) -
              minutesOfDay(winter.maghrib, location))
          .abs();
      expect(diff, greaterThan(180));
    });
  });
}
