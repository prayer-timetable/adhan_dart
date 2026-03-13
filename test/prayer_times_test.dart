import 'package:adhan_dart/adhan_dart.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Helper to extract HH:mm from a TZDateTime for comparison.
String timeString(DateTime utcTime, tz.Location location) {
  final local = tz.TZDateTime.from(utcTime, location);
  final h = local.hour.toString().padLeft(2, '0');
  final m = local.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

/// Custom matcher that allows a variance of +/- [minutes] when comparing
/// prayer times as "HH:mm" strings.
Matcher isWithinMinutes(String expected, int minutes) {
  return predicate<String>((actual) {
    final aParts = actual.split(':');
    final eParts = expected.split(':');
    final aMinutes = int.parse(aParts[0]) * 60 + int.parse(aParts[1]);
    final eMinutes = int.parse(eParts[0]) * 60 + int.parse(eParts[1]);
    return (aMinutes - eMinutes).abs() <= minutes;
  }, 'is within $minutes minute(s) of $expected');
}

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
  });

  // ---------------------------------------------------------------
  // Prayer time test data sourced from the adhan-js reference tests
  // https://github.com/batoulapps/adhan-js/blob/master/test/adhan.test.ts
  // ---------------------------------------------------------------

  group('NorthAmerica method — Raleigh, NC (Hanafi)', () {
    // Source: adhan-js test suite
    // Coordinates: 35.775, -78.6336
    // Date: 2015-07-12
    // Method: NorthAmerica, Madhab: Hanafi

    late PrayerTimes prayerTimes;
    late tz.Location location;

    setUp(() {
      location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2015, 7, 12);
      final coordinates = const Coordinates(35.775, -78.6336);
      final params = CalculationMethodParameters.northAmerica()
        ..madhab = Madhab.hanafi;
      prayerTimes = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
    });

    test('Fajr is 04:42', () {
      expect(timeString(prayerTimes.fajr, location), equals('04:42'));
    });

    test('Sunrise is 06:08', () {
      expect(timeString(prayerTimes.sunrise, location), equals('06:08'));
    });

    test('Dhuhr is 13:21', () {
      expect(timeString(prayerTimes.dhuhr, location), equals('13:21'));
    });

    test('Asr is 18:22', () {
      expect(timeString(prayerTimes.asr, location), equals('18:22'));
    });

    test('Maghrib is 20:32', () {
      expect(timeString(prayerTimes.maghrib, location), equals('20:32'));
    });

    test('Isha is 21:57', () {
      expect(timeString(prayerTimes.isha, location), equals('21:57'));
    });
  });

  group('MuslimWorldLeague method — Raleigh, NC (Shafi)', () {
    // Source: adhan-js test suite
    // Coordinates: 35.775, -78.6336
    // Date: 2015-12-01
    // Method: MuslimWorldLeague, Madhab: Shafi (default)

    late PrayerTimes prayerTimes;
    late tz.Location location;

    setUp(() {
      location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2015, 12, 1);
      final coordinates = const Coordinates(35.775, -78.6336);
      final params = CalculationMethodParameters.muslimWorldLeague();
      prayerTimes = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
    });

    test('Fajr is 05:35', () {
      expect(timeString(prayerTimes.fajr, location), equals('05:35'));
    });

    test('Sunrise is 07:06', () {
      expect(timeString(prayerTimes.sunrise, location), equals('07:06'));
    });

    test('Dhuhr is 12:05', () {
      expect(timeString(prayerTimes.dhuhr, location), equals('12:05'));
    });

    test('Asr is 14:42', () {
      expect(timeString(prayerTimes.asr, location), equals('14:42'));
    });

    test('Maghrib is 17:01', () {
      expect(timeString(prayerTimes.maghrib, location), equals('17:01'));
    });

    test('Isha is 18:26', () {
      expect(timeString(prayerTimes.isha, location), equals('18:26'));
    });
  });

  group('MoonsightingCommittee method — Raleigh, NC', () {
    // Source: http://www.moonsighting.com/pray.php
    // Coordinates: 35.775, -78.6336
    // Date: 2016-01-31

    late PrayerTimes prayerTimes;
    late tz.Location location;

    setUp(() {
      location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2016, 1, 31);
      final coordinates = const Coordinates(35.775, -78.6336);
      final params = CalculationMethodParameters.moonsightingCommittee();
      prayerTimes = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
    });

    test('Fajr is 05:48', () {
      expect(timeString(prayerTimes.fajr, location), equals('05:48'));
    });

    test('Sunrise is 07:16', () {
      expect(timeString(prayerTimes.sunrise, location), equals('07:16'));
    });

    test('Dhuhr is 12:33', () {
      expect(timeString(prayerTimes.dhuhr, location), equals('12:33'));
    });

    test('Asr is 15:20', () {
      expect(timeString(prayerTimes.asr, location), equals('15:20'));
    });

    test('Maghrib is 17:43', () {
      expect(timeString(prayerTimes.maghrib, location), equals('17:43'));
    });

    test('Isha is 19:05', () {
      expect(timeString(prayerTimes.isha, location), equals('19:05'));
    });
  });

  group('MoonsightingCommittee method — Oslo, Norway (high latitude)', () {
    // Source: http://www.moonsighting.com/pray.php
    // Coordinates: 59.9094, 10.7349
    // Date: 2016-01-01
    // Madhab: Hanafi

    late PrayerTimes prayerTimes;
    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Europe/Oslo');
      final date = tz.TZDateTime(location, 2016, 1, 1);
      final coordinates = const Coordinates(59.9094, 10.7349);
      final params = CalculationMethodParameters.moonsightingCommittee()
        ..madhab = Madhab.hanafi;
      prayerTimes = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
    });

    test('Fajr is 07:34', () {
      expect(timeString(prayerTimes.fajr, location), equals('07:34'));
    });

    test('Sunrise is 09:19', () {
      expect(timeString(prayerTimes.sunrise, location), equals('09:19'));
    });

    test('Dhuhr is 12:25', () {
      expect(timeString(prayerTimes.dhuhr, location), equals('12:25'));
    });

    test('Asr is 13:36', () {
      expect(timeString(prayerTimes.asr, location), equals('13:36'));
    });

    test('Maghrib is 15:25', () {
      expect(timeString(prayerTimes.maghrib, location), equals('15:25'));
    });

    test('Isha is 17:02', () {
      expect(timeString(prayerTimes.isha, location), equals('17:02'));
    });
  });

  group('Turkiye method — Istanbul', () {
    // Source: https://namazvakitleri.diyanet.gov.tr/en-US/9541/prayer-time-for-istanbul
    // Coordinates: 41.005616, 28.97638
    // Date: 2020-04-16
    // Note: adhan-js allows 1-minute variance for Asr and Isha

    late PrayerTimes prayerTimes;
    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Europe/Istanbul');
      final date = tz.TZDateTime(location, 2020, 4, 16);
      final coordinates = const Coordinates(41.005616, 28.97638);
      final params = CalculationMethodParameters.turkiye();
      prayerTimes = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
    });

    test('Fajr is 04:44', () {
      expect(timeString(prayerTimes.fajr, location), equals('04:44'));
    });

    test('Sunrise is 06:16', () {
      expect(timeString(prayerTimes.sunrise, location), equals('06:16'));
    });

    test('Dhuhr is 13:09', () {
      expect(timeString(prayerTimes.dhuhr, location), equals('13:09'));
    });

    test('Asr is within 1 min of 16:53', () {
      expect(
          timeString(prayerTimes.asr, location), isWithinMinutes('16:53', 1));
    });

    test('Maghrib is 19:52', () {
      expect(timeString(prayerTimes.maghrib, location), equals('19:52'));
    });

    test('Isha is within 1 min of 21:19', () {
      expect(
          timeString(prayerTimes.isha, location), isWithinMinutes('21:19', 1));
    });
  });

  group('Egyptian method — Cairo', () {
    // Source: adhan-js test suite
    // Coordinates: 30.028703, 31.249528
    // Date: 2020-01-01

    late PrayerTimes prayerTimes;
    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Africa/Cairo');
      final date = tz.TZDateTime(location, 2020, 1, 1);
      final coordinates = const Coordinates(30.028703, 31.249528);
      final params = CalculationMethodParameters.egyptian();
      prayerTimes = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
    });

    test('Fajr is 05:18', () {
      expect(timeString(prayerTimes.fajr, location), equals('05:18'));
    });

    test('Sunrise is 06:51', () {
      expect(timeString(prayerTimes.sunrise, location), equals('06:51'));
    });

    test('Dhuhr is 11:59', () {
      expect(timeString(prayerTimes.dhuhr, location), equals('11:59'));
    });

    test('Asr is 14:47', () {
      expect(timeString(prayerTimes.asr, location), equals('14:47'));
    });

    test('Maghrib is 17:06', () {
      expect(timeString(prayerTimes.maghrib, location), equals('17:06'));
    });

    test('Isha is 18:29', () {
      expect(timeString(prayerTimes.isha, location), equals('18:29'));
    });
  });

  group('Singapore method — Kuala Lumpur', () {
    // Source: adhan-js test suite
    // Coordinates: 3.7333333333, 101.3833333333
    // Date: 2021-06-14

    late PrayerTimes prayerTimes;
    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Asia/Kuala_Lumpur');
      final date = tz.TZDateTime(location, 2021, 6, 14);
      final coordinates = const Coordinates(3.7333333333, 101.3833333333);
      final params = CalculationMethodParameters.singapore();
      prayerTimes = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
    });

    test('Fajr is within 1 min of 05:41', () {
      expect(
          timeString(prayerTimes.fajr, location), isWithinMinutes('05:41', 1));
    });

    test('Sunrise is 07:05', () {
      expect(timeString(prayerTimes.sunrise, location), equals('07:05'));
    });

    test('Dhuhr is 13:16', () {
      expect(timeString(prayerTimes.dhuhr, location), equals('13:16'));
    });

    test('Asr is 16:42', () {
      expect(timeString(prayerTimes.asr, location), equals('16:42'));
    });

    test('Maghrib is 19:25', () {
      expect(timeString(prayerTimes.maghrib, location), equals('19:25'));
    });

    test('Isha is 20:41', () {
      expect(timeString(prayerTimes.isha, location), equals('20:41'));
    });
  });

  group('UmmAlQura method — Makkah', () {
    // Source: http://www.ummulqura.org.sa/Index.aspx
    // Coordinates: 21.427009, 39.828685
    // Variance: 0 (exact match expected)

    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Asia/Riyadh');
    });

    test('2016-01-05', () {
      final date = tz.TZDateTime(location, 2016, 1, 5);
      final coordinates = const Coordinates(21.427009, 39.828685);
      final params = CalculationMethodParameters.ummAlQura();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('05:38'));
      expect(timeString(pt.sunrise, location), equals('07:00'));
      expect(timeString(pt.dhuhr, location), equals('12:26'));
      expect(timeString(pt.asr, location), equals('15:31'));
      expect(timeString(pt.maghrib, location), equals('17:52'));
      expect(timeString(pt.isha, location), equals('19:22'));
    });

    test('2016-07-08', () {
      final date = tz.TZDateTime(location, 2016, 7, 8);
      final coordinates = const Coordinates(21.427009, 39.828685);
      final params = CalculationMethodParameters.ummAlQura();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:18'));
      expect(timeString(pt.sunrise, location), equals('05:45'));
      expect(timeString(pt.dhuhr, location), equals('12:26'));
      expect(timeString(pt.asr, location), equals('15:43'));
      expect(timeString(pt.maghrib, location), equals('19:07'));
      expect(timeString(pt.isha, location), equals('20:37'));
    });

    test('2016-11-05', () {
      final date = tz.TZDateTime(location, 2016, 11, 5);
      final coordinates = const Coordinates(21.427009, 39.828685);
      final params = CalculationMethodParameters.ummAlQura();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('05:08'));
      expect(timeString(pt.sunrise, location), equals('06:26'));
      expect(timeString(pt.dhuhr, location), equals('12:04'));
      expect(timeString(pt.asr, location), equals('15:18'));
      expect(timeString(pt.maghrib, location), equals('17:42'));
      expect(timeString(pt.isha, location), equals('19:12'));
    });
  });

  group('Qatar method — Doha', () {
    // Source: http://www.islam.gov.qa/
    // Coordinates: 25.283897, 51.528770
    // Variance: 0 (exact match expected)

    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Asia/Qatar');
    });

    test('2016-01-01', () {
      final date = tz.TZDateTime(location, 2016, 1, 1);
      final coordinates = const Coordinates(25.283897, 51.528770);
      final params = CalculationMethodParameters.qatar();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:58'));
      expect(timeString(pt.sunrise, location), equals('06:19'));
      expect(timeString(pt.dhuhr, location), equals('11:37'));
      expect(timeString(pt.asr, location), equals('14:35'));
      expect(timeString(pt.maghrib, location), equals('16:55'));
      expect(timeString(pt.isha, location), equals('18:25'));
    });

    test('2016-06-01', () {
      final date = tz.TZDateTime(location, 2016, 6, 1);
      final coordinates = const Coordinates(25.283897, 51.528770);
      final params = CalculationMethodParameters.qatar();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('03:15'));
      expect(timeString(pt.sunrise, location), equals('04:43'));
      expect(timeString(pt.dhuhr, location), equals('11:32'));
      expect(timeString(pt.asr, location), equals('14:56'));
      expect(timeString(pt.maghrib, location), equals('18:20'));
      expect(timeString(pt.isha, location), equals('19:50'));
    });

    test('2016-10-01', () {
      final date = tz.TZDateTime(location, 2016, 10, 1);
      final coordinates = const Coordinates(25.283897, 51.528770);
      final params = CalculationMethodParameters.qatar();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('04:10'));
      expect(timeString(pt.sunrise, location), equals('05:26'));
      expect(timeString(pt.dhuhr, location), equals('11:23'));
      expect(timeString(pt.asr, location), equals('14:47'));
      expect(timeString(pt.maghrib, location), equals('17:20'));
      expect(timeString(pt.isha, location), equals('18:50'));
    });
  });

  group('Dubai method — Dubai, UAE', () {
    // Source: https://www.awqaf.gov.ae/en/Pages/PrayerTimes.aspx
    // Coordinates: 25.263056, 55.297222
    // Variance: 1 minute

    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Asia/Dubai');
    });

    test('2016-01-01', () {
      final date = tz.TZDateTime(location, 2016, 1, 1);
      final coordinates = const Coordinates(25.263056, 55.297222);
      final params = CalculationMethodParameters.dubai();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('05:42', 1));
      expect(timeString(pt.sunrise, location), isWithinMinutes('07:01', 1));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('12:25', 1));
      expect(timeString(pt.asr, location), isWithinMinutes('15:24', 1));
      expect(timeString(pt.maghrib, location), isWithinMinutes('17:44', 1));
      expect(timeString(pt.isha, location), isWithinMinutes('19:03', 1));
    });

    test('2016-07-01', () {
      final date = tz.TZDateTime(location, 2016, 7, 1);
      final coordinates = const Coordinates(25.263056, 55.297222);
      final params = CalculationMethodParameters.dubai();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('04:02', 1));
      expect(timeString(pt.sunrise, location), isWithinMinutes('05:29', 1));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('12:25', 1));
      expect(timeString(pt.asr, location), isWithinMinutes('15:48', 1));
      expect(timeString(pt.maghrib, location), isWithinMinutes('19:16', 1));
      expect(timeString(pt.isha, location), isWithinMinutes('20:43', 1));
    });
  });

  group('Kuwait method — Kuwait City', () {
    // Source: https://itunes.apple.com/us/app/kuwait-prayer-times/id723108544
    // Coordinates: 29.370865, 47.979139
    // Variance: 2 minutes

    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Asia/Kuwait');
    });

    test('2016-01-01', () {
      final date = tz.TZDateTime(location, 2016, 1, 1);
      final coordinates = const Coordinates(29.370865, 47.979139);
      final params = CalculationMethodParameters.kuwait();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('05:18', 2));
      expect(timeString(pt.sunrise, location), isWithinMinutes('06:42', 2));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('11:51', 2));
      expect(timeString(pt.asr, location), isWithinMinutes('14:42', 2));
      expect(timeString(pt.maghrib, location), isWithinMinutes('17:01', 2));
      expect(timeString(pt.isha, location), isWithinMinutes('18:23', 2));
    });

    test('2016-07-01', () {
      final date = tz.TZDateTime(location, 2016, 7, 1);
      final coordinates = const Coordinates(29.370865, 47.979139);
      final params = CalculationMethodParameters.kuwait();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('03:16', 2));
      expect(timeString(pt.sunrise, location), isWithinMinutes('04:52', 2));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('11:52', 2));
      expect(timeString(pt.asr, location), isWithinMinutes('15:26', 2));
      expect(timeString(pt.maghrib, location), isWithinMinutes('18:52', 2));
      expect(timeString(pt.isha, location), isWithinMinutes('20:23', 2));
    });
  });

  group('MoonsightingCommittee — London (Hanafi)', () {
    // Source: http://www.moonsighting.com/pray.php
    // Coordinates: 51.507194, -0.116711
    // Variance: 0 (exact match expected)

    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Europe/London');
    });

    test('2016-01-01', () {
      final date = tz.TZDateTime(location, 2016, 1, 1);
      final coordinates = const Coordinates(51.507194, -0.116711);
      final params = CalculationMethodParameters.moonsightingCommittee()
        ..madhab = Madhab.hanafi;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('06:25'));
      expect(timeString(pt.sunrise, location), equals('08:06'));
      expect(timeString(pt.dhuhr, location), equals('12:09'));
      expect(timeString(pt.asr, location), equals('14:15'));
      expect(timeString(pt.maghrib, location), equals('16:05'));
      expect(timeString(pt.isha, location), equals('17:38'));
    });

    test('2016-06-01', () {
      final date = tz.TZDateTime(location, 2016, 6, 1);
      final coordinates = const Coordinates(51.507194, -0.116711);
      final params = CalculationMethodParameters.moonsightingCommittee()
        ..madhab = Madhab.hanafi;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('02:55'));
      expect(timeString(pt.sunrise, location), equals('04:49'));
      expect(timeString(pt.dhuhr, location), equals('13:03'));
      expect(timeString(pt.asr, location), equals('18:31'));
      expect(timeString(pt.maghrib, location), equals('21:12'));
      expect(timeString(pt.isha, location), equals('22:23'));
    });

    test('2016-12-01', () {
      final date = tz.TZDateTime(location, 2016, 12, 1);
      final coordinates = const Coordinates(51.507194, -0.116711);
      final params = CalculationMethodParameters.moonsightingCommittee()
        ..madhab = Madhab.hanafi;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('06:04'));
      expect(timeString(pt.sunrise, location), equals('07:44'));
      expect(timeString(pt.dhuhr, location), equals('11:55'));
      expect(timeString(pt.asr, location), equals('14:07'));
      expect(timeString(pt.maghrib, location), equals('15:58'));
      expect(timeString(pt.isha, location), equals('17:29'));
    });
  });

  group('Tehran method — Tehran', () {
    // Source: http://praytimes.org/
    // Coordinates: 35.715298, 51.404343
    // Variance: 1 minute

    late tz.Location location;

    setUp(() {
      location = tz.getLocation('Asia/Tehran');
    });

    test('2018-01-01', () {
      final date = tz.TZDateTime(location, 2018, 1, 1);
      final coordinates = const Coordinates(35.715298, 51.404343);
      final params = CalculationMethodParameters.tehran();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('05:44', 1));
      expect(timeString(pt.sunrise, location), isWithinMinutes('07:14', 1));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('12:08', 1));
      expect(timeString(pt.asr, location), isWithinMinutes('14:44', 1));
      expect(timeString(pt.maghrib, location), isWithinMinutes('17:22', 1));
      expect(timeString(pt.isha, location), isWithinMinutes('18:12', 1));
    });

    test('2018-07-01', () {
      final date = tz.TZDateTime(location, 2018, 7, 1);
      final coordinates = const Coordinates(35.715298, 51.404343);
      final params = CalculationMethodParameters.tehran();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('04:06', 1));
      expect(timeString(pt.sunrise, location), isWithinMinutes('05:52', 1));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('13:08', 1));
      expect(timeString(pt.asr, location), isWithinMinutes('16:57', 1));
      expect(timeString(pt.maghrib, location), isWithinMinutes('20:45', 1));
      expect(timeString(pt.isha, location), isWithinMinutes('21:45', 1));
    });
  });

  group('Turkiye method — Ankara (bimonthly)', () {
    // Source: https://www.yenisafak.com/en/ankara-prayer-times-01.01.2019
    // Coordinates: 39.939382, 32.819713
    // Variance: 2 minutes

    late tz.Location location;
    final coordinates = const Coordinates(39.939382, 32.819713);

    setUp(() {
      location = tz.getLocation('Europe/Istanbul');
    });

    test('2019-01-01', () {
      final date = tz.TZDateTime(location, 2019, 1, 1);
      final params = CalculationMethodParameters.turkiye();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('06:33', 2));
      expect(timeString(pt.sunrise, location), isWithinMinutes('08:03', 2));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('12:57', 2));
      expect(timeString(pt.asr, location), isWithinMinutes('15:20', 2));
      expect(timeString(pt.maghrib, location), isWithinMinutes('17:40', 2));
      expect(timeString(pt.isha, location), isWithinMinutes('19:05', 2));
    });

    test('2019-06-01', () {
      final date = tz.TZDateTime(location, 2019, 6, 1);
      final params = CalculationMethodParameters.turkiye();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('03:24', 2));
      expect(timeString(pt.sunrise, location), isWithinMinutes('05:15', 2));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('12:51', 2));
      expect(timeString(pt.asr, location), isWithinMinutes('16:48', 2));
      expect(timeString(pt.maghrib, location), isWithinMinutes('20:17', 2));
      expect(timeString(pt.isha, location), isWithinMinutes('22:00', 2));
    });

    test('2019-12-01', () {
      final date = tz.TZDateTime(location, 2019, 12, 1);
      final params = CalculationMethodParameters.turkiye();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), isWithinMinutes('06:14', 2));
      expect(timeString(pt.sunrise, location), isWithinMinutes('07:43', 2));
      expect(timeString(pt.dhuhr, location), isWithinMinutes('12:42', 2));
      expect(timeString(pt.asr, location), isWithinMinutes('15:10', 2));
      expect(timeString(pt.maghrib, location), isWithinMinutes('17:31', 2));
      expect(timeString(pt.isha, location), isWithinMinutes('18:55', 2));
    });
  });

  group('HighLatitudeRule — Edinburgh', () {
    // Source: adhan-js test suite
    // Coordinates: 55.983226, -3.216649
    // Date: 2020-06-15
    // Method: MuslimWorldLeague

    late tz.Location location;
    final coordinates = const Coordinates(55.983226, -3.216649);

    setUp(() {
      location = tz.getLocation('Europe/London');
    });

    test('SeventhOfTheNight rule', () {
      final date = tz.TZDateTime(location, 2020, 6, 15);
      final params = CalculationMethodParameters.muslimWorldLeague()
        ..highLatitudeRule = HighLatitudeRule.seventhOfTheNight;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('03:31'));
      expect(timeString(pt.sunrise, location), equals('04:26'));
      expect(timeString(pt.dhuhr, location), equals('13:14'));
      expect(timeString(pt.asr, location), equals('17:46'));
      expect(timeString(pt.maghrib, location), equals('22:01'));
      expect(timeString(pt.isha, location), equals('22:56'));
    });

    test('TwilightAngle rule', () {
      final date = tz.TZDateTime(location, 2020, 6, 15);
      final params = CalculationMethodParameters.muslimWorldLeague()
        ..highLatitudeRule = HighLatitudeRule.twilightAngle;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('02:31'));
      expect(timeString(pt.sunrise, location), equals('04:26'));
      expect(timeString(pt.dhuhr, location), equals('13:14'));
      expect(timeString(pt.asr, location), equals('17:46'));
      expect(timeString(pt.maghrib, location), equals('22:01'));
      expect(timeString(pt.isha, location), equals('23:50'));
    });
  });

  group('Madhab comparison — Raleigh', () {
    // Source: adhan-js test suite
    // Coordinates: 35.775, -78.6336
    // Date: 2015-12-01
    // Method: MuslimWorldLeague

    late tz.Location location;

    setUp(() {
      location = tz.getLocation('America/New_York');
    });

    test('Shafi gives earlier Asr than Hanafi', () {
      final date = tz.TZDateTime(location, 2015, 12, 1);
      final coordinates = const Coordinates(35.775, -78.6336);

      final shafiParams = CalculationMethodParameters.muslimWorldLeague()
        ..madhab = Madhab.shafi;
      final hanafiParams = CalculationMethodParameters.muslimWorldLeague()
        ..madhab = Madhab.hanafi;

      final shafiTimes = PrayerTimes(
          coordinates: coordinates,
          date: date,
          calculationParameters: shafiParams);
      final hanafiTimes = PrayerTimes(
          coordinates: coordinates,
          date: date,
          calculationParameters: hanafiParams);

      expect(timeString(shafiTimes.asr, location), equals('14:42'));
      expect(timeString(hanafiTimes.asr, location), equals('15:22'));
      expect(shafiTimes.asr.isBefore(hanafiTimes.asr), isTrue);
    });
  });

  group('Prayer time adjustments', () {
    test('+10 minute offset on all prayers', () {
      // Source: adhan-js test suite
      final location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2015, 12, 1);
      final coordinates = const Coordinates(35.775, -78.6336);
      final params = CalculationMethodParameters.muslimWorldLeague()
        ..adjustments = {
          Prayer.fajr: 10,
          Prayer.sunrise: 10,
          Prayer.dhuhr: 10,
          Prayer.asr: 10,
          Prayer.maghrib: 10,
          Prayer.isha: 10,
        };

      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(timeString(pt.fajr, location), equals('05:45'));
      expect(timeString(pt.sunrise, location), equals('07:16'));
      expect(timeString(pt.dhuhr, location), equals('12:15'));
      expect(timeString(pt.asr, location), equals('14:52'));
      expect(timeString(pt.maghrib, location), equals('17:11'));
      expect(timeString(pt.isha, location), equals('18:36'));
    });
  });

  group('Sunnah Times', () {
    // Source: adhan-js test suite (test/sunnah.test.ts)

    test('Raleigh — NorthAmerica — 2015-07-12', () {
      final location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2015, 7, 12);
      final coordinates = const Coordinates(35.775, -78.6336);
      final params = CalculationMethodParameters.northAmerica()
        ..madhab = Madhab.hanafi;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
      final st = SunnahTimes(pt);

      final middleOfNight = tz.TZDateTime.from(st.middleOfTheNight, location);
      final lastThird = tz.TZDateTime.from(st.lastThirdOfTheNight, location);

      // Middle of the Night: ~12:37 AM on 7/13
      expect(middleOfNight.month, equals(7));
      expect(middleOfNight.day, equals(13));
      expect(middleOfNight.hour, equals(0));
      expect(middleOfNight.minute, closeTo(37, 1));

      // Last Third: 1:59 AM on 7/13
      expect(lastThird.month, equals(7));
      expect(lastThird.day, equals(13));
      expect(lastThird.hour, equals(1));
      expect(lastThird.minute, equals(59));
    });

    test('London — MoonsightingCommittee — 2016-12-31', () {
      final location = tz.getLocation('Europe/London');
      final date = tz.TZDateTime(location, 2016, 12, 31);
      final coordinates = const Coordinates(51.5074, -0.1278);
      final params = CalculationMethodParameters.moonsightingCommittee();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);
      final st = SunnahTimes(pt);

      final middleOfNight = tz.TZDateTime.from(st.middleOfTheNight, location);
      final lastThird = tz.TZDateTime.from(st.lastThirdOfTheNight, location);

      // Middle of the Night: ~11:14 PM on 12/31
      expect(middleOfNight.day, equals(31));
      expect(middleOfNight.hour, equals(23));
      expect(middleOfNight.minute, closeTo(14, 1));

      // Last Third: 1:38 AM on 1/1
      expect(lastThird.month, equals(1));
      expect(lastThird.day, equals(1));
      expect(lastThird.hour, equals(1));
      expect(lastThird.minute, equals(38));
    });
  });

  group('Qibla direction', () {
    test('North America', () {
      final coordinates = const Coordinates(35.78056, -78.6389);
      final qibla = Qibla.qibla(coordinates);
      expect(qibla, closeTo(55.82, 0.1));
    });

    test('South America', () {
      final coordinates = const Coordinates(-39.231, 12.412);
      final qibla = Qibla.qibla(coordinates);
      expect(qibla, closeTo(28.02, 0.1));
    });

    test('UK', () {
      final coordinates = const Coordinates(51.5074, -0.1278);
      final qibla = Qibla.qibla(coordinates);
      expect(qibla, closeTo(118.99, 0.1));
    });
  });

  group('currentPrayer and nextPrayer', () {
    test('returns correct current and next prayer', () {
      final location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2015, 9, 1);
      final coordinates = const Coordinates(33.720817, 73.090032);
      final params = CalculationMethodParameters.karachi()
        ..madhab = Madhab.hanafi
        ..highLatitudeRule = HighLatitudeRule.twilightAngle;
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      // Before fajr should return ishaBefore as current
      final beforeFajr = pt.fajr.subtract(const Duration(hours: 1));
      expect(pt.currentPrayer(date: beforeFajr), equals(Prayer.ishaBefore));
      expect(pt.nextPrayer(date: beforeFajr), equals(Prayer.fajr));

      // After isha should return fajrAfter as next
      final afterIsha = pt.isha.add(const Duration(hours: 1));
      expect(pt.currentPrayer(date: afterIsha), equals(Prayer.isha));
      expect(pt.nextPrayer(date: afterIsha), equals(Prayer.fajrAfter));

      // Between dhuhr and asr should return dhuhr current, asr next
      final betweenDhuhrAndAsr = pt.dhuhr.add(const Duration(minutes: 30));
      expect(pt.currentPrayer(date: betweenDhuhrAndAsr), equals(Prayer.dhuhr));
      expect(pt.nextPrayer(date: betweenDhuhrAndAsr), equals(Prayer.asr));
    });
  });

  group('timeForPrayer', () {
    test('returns correct DateTime for each prayer', () {
      final location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2015, 7, 12);
      final coordinates = const Coordinates(35.775, -78.6336);
      final params = CalculationMethodParameters.northAmerica();
      final pt = PrayerTimes(
          coordinates: coordinates, date: date, calculationParameters: params);

      expect(pt.timeForPrayer(Prayer.fajr), equals(pt.fajr));
      expect(pt.timeForPrayer(Prayer.sunrise), equals(pt.sunrise));
      expect(pt.timeForPrayer(Prayer.dhuhr), equals(pt.dhuhr));
      expect(pt.timeForPrayer(Prayer.asr), equals(pt.asr));
      expect(pt.timeForPrayer(Prayer.maghrib), equals(pt.maghrib));
      expect(pt.timeForPrayer(Prayer.isha), equals(pt.isha));
      expect(pt.timeForPrayer(Prayer.ishaBefore), equals(pt.ishaBefore));
      expect(pt.timeForPrayer(Prayer.fajrAfter), equals(pt.fajrAfter));
    });
  });

  group('Precision mode', () {
    test('precision: true returns seconds, precision: false rounds to minutes',
        () {
      final location = tz.getLocation('America/New_York');
      final date = tz.TZDateTime(location, 2015, 7, 12);
      final coordinates = const Coordinates(35.775, -78.6336);
      final params = CalculationMethodParameters.northAmerica();

      final rounded = PrayerTimes(
          coordinates: coordinates,
          date: date,
          calculationParameters: params,
          precision: false);
      final precise = PrayerTimes(
          coordinates: coordinates,
          date: date,
          calculationParameters: params,
          precision: true);

      // Rounded times should have seconds == 0
      expect(rounded.fajr.second, equals(0));
      expect(rounded.sunrise.second, equals(0));
      expect(rounded.dhuhr.second, equals(0));

      // Precise and rounded should be within 1 minute of each other
      expect(
          precise.fajr.difference(rounded.fajr).inMinutes.abs() <= 1, isTrue);
    });
  });
}
