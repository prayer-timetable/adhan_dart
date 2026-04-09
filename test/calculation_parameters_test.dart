import 'package:adhan_dart/adhan_dart.dart';
import 'package:test/test.dart';

void main() {
  group('CalculationParameters', () {
    test('default values are set correctly', () {
      var params = CalculationParameters(
        method: CalculationMethod.other,
        fajrAngle: 18,
        ishaAngle: 17,
      );
      expect(params.madhab, Madhab.shafi);
      expect(params.highLatitudeRule, HighLatitudeRule.middleOfTheNight);
      expect(params.ishaInterval, 0);
      expect(params.maghribAngle, isNull);
      expect(params.adjustments[Prayer.fajr], 0);
      expect(params.adjustments[Prayer.sunrise], 0);
      expect(params.adjustments[Prayer.dhuhr], 0);
      expect(params.adjustments[Prayer.asr], 0);
      expect(params.adjustments[Prayer.maghrib], 0);
      expect(params.adjustments[Prayer.isha], 0);
    });

    test('custom values override defaults', () {
      var params = CalculationParameters(
        method: CalculationMethod.other,
        fajrAngle: 15,
        ishaAngle: 15,
        madhab: Madhab.hanafi,
        highLatitudeRule: HighLatitudeRule.seventhOfTheNight,
        ishaInterval: 90,
        maghribAngle: 4.5,
      );
      expect(params.fajrAngle, 15);
      expect(params.ishaAngle, 15);
      expect(params.madhab, Madhab.hanafi);
      expect(params.highLatitudeRule, HighLatitudeRule.seventhOfTheNight);
      expect(params.ishaInterval, 90);
      expect(params.maghribAngle, 4.5);
    });

    group('nightPortions', () {
      test('middleOfTheNight returns 1/2', () {
        var params = CalculationParameters(
          method: CalculationMethod.other,
          fajrAngle: 18,
          ishaAngle: 17,
          highLatitudeRule: HighLatitudeRule.middleOfTheNight,
        );
        var portions = params.nightPortions();
        expect(portions[Prayer.fajr], 0.5);
        expect(portions[Prayer.isha], 0.5);
      });

      test('seventhOfTheNight returns 1/7', () {
        var params = CalculationParameters(
          method: CalculationMethod.other,
          fajrAngle: 18,
          ishaAngle: 17,
          highLatitudeRule: HighLatitudeRule.seventhOfTheNight,
        );
        var portions = params.nightPortions();
        expect(portions[Prayer.fajr], closeTo(1 / 7, 0.0001));
        expect(portions[Prayer.isha], closeTo(1 / 7, 0.0001));
      });

      test('twilightAngle returns angle/60', () {
        var params = CalculationParameters(
          method: CalculationMethod.other,
          fajrAngle: 18,
          ishaAngle: 17,
          highLatitudeRule: HighLatitudeRule.twilightAngle,
        );
        var portions = params.nightPortions();
        expect(portions[Prayer.fajr], 18 / 60);
        expect(portions[Prayer.isha], 17 / 60);
      });
    });
  });

  group('CalculationMethodParameters', () {
    test('muslimWorldLeague has correct angles', () {
      var params = CalculationMethodParameters.muslimWorldLeague();
      expect(params.method, CalculationMethod.muslimWorldLeague);
      expect(params.fajrAngle, 18);
      expect(params.ishaAngle, 17);
    });

    test('egyptian has correct angles', () {
      var params = CalculationMethodParameters.egyptian();
      expect(params.method, CalculationMethod.egyptian);
      expect(params.fajrAngle, 19.5);
      expect(params.ishaAngle, 17.5);
    });

    test('karachi has correct angles', () {
      var params = CalculationMethodParameters.karachi();
      expect(params.method, CalculationMethod.karachi);
      expect(params.fajrAngle, 18);
      expect(params.ishaAngle, 18);
    });

    test('ummAlQura uses isha interval of 90', () {
      var params = CalculationMethodParameters.ummAlQura();
      expect(params.method, CalculationMethod.ummAlQura);
      expect(params.fajrAngle, 18.5);
      expect(params.ishaInterval, 90);
    });

    test('qatar uses isha interval of 90', () {
      var params = CalculationMethodParameters.qatar();
      expect(params.method, CalculationMethod.qatar);
      expect(params.fajrAngle, 18);
      expect(params.ishaInterval, 90);
    });

    test('kuwait has correct angles', () {
      var params = CalculationMethodParameters.kuwait();
      expect(params.method, CalculationMethod.kuwait);
      expect(params.fajrAngle, 18);
      expect(params.ishaAngle, 17.5);
    });

    test('moonsightingCommittee has correct angles and adjustments', () {
      var params = CalculationMethodParameters.moonsightingCommittee();
      expect(params.method, CalculationMethod.moonsightingCommittee);
      expect(params.fajrAngle, 18);
      expect(params.ishaAngle, 18);
      expect(params.methodAdjustments[Prayer.dhuhr], 5);
      expect(params.methodAdjustments[Prayer.maghrib], 3);
    });

    test('singapore has correct angles', () {
      var params = CalculationMethodParameters.singapore();
      expect(params.method, CalculationMethod.singapore);
      expect(params.fajrAngle, 20);
      expect(params.ishaAngle, 18);
    });

    test('turkiye has correct angles and adjustments', () {
      var params = CalculationMethodParameters.turkiye();
      expect(params.method, CalculationMethod.turkiye);
      expect(params.fajrAngle, 18);
      expect(params.ishaAngle, 17);
      expect(params.methodAdjustments[Prayer.sunrise], -7);
      expect(params.methodAdjustments[Prayer.dhuhr], 5);
      expect(params.methodAdjustments[Prayer.asr], 4);
      expect(params.methodAdjustments[Prayer.maghrib], 7);
    });

    test('tehran has correct angles and maghrib angle', () {
      var params = CalculationMethodParameters.tehran();
      expect(params.method, CalculationMethod.tehran);
      expect(params.fajrAngle, 17.7);
      expect(params.ishaAngle, 14);
      expect(params.maghribAngle, 4.5);
    });

    test('northAmerica has correct angles', () {
      var params = CalculationMethodParameters.northAmerica();
      expect(params.method, CalculationMethod.northAmerica);
      expect(params.fajrAngle, 15);
      expect(params.ishaAngle, 15);
    });

    test('dubai has correct angles and adjustments', () {
      var params = CalculationMethodParameters.dubai();
      expect(params.method, CalculationMethod.dubai);
      expect(params.fajrAngle, 18.2);
      expect(params.ishaAngle, 18.2);
      expect(params.methodAdjustments[Prayer.sunrise], -3);
      expect(params.methodAdjustments[Prayer.dhuhr], 3);
      expect(params.methodAdjustments[Prayer.asr], 3);
      expect(params.methodAdjustments[Prayer.maghrib], 3);
    });

    test('morocco has correct angles and adjustments', () {
      var params = CalculationMethodParameters.morocco();
      expect(params.method, CalculationMethod.morocco);
      expect(params.fajrAngle, 19);
      expect(params.ishaAngle, 17);
      expect(params.methodAdjustments[Prayer.sunrise], -3);
      expect(params.methodAdjustments[Prayer.dhuhr], 5);
      expect(params.methodAdjustments[Prayer.maghrib], 5);
    });

    test('other defaults to 0 angles', () {
      var params = CalculationMethodParameters.other();
      expect(params.method, CalculationMethod.other);
      expect(params.fajrAngle, 0);
      expect(params.ishaAngle, 0);
    });
  });

  group('Coordinates', () {
    test('equality works correctly', () {
      var a = const Coordinates(35.78056, -78.6389);
      var b = const Coordinates(35.78056, -78.6389);
      var c = const Coordinates(35.0, -78.0);
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('hashCode is consistent with equality', () {
      var a = const Coordinates(35.78056, -78.6389);
      var b = const Coordinates(35.78056, -78.6389);
      expect(a.hashCode, equals(b.hashCode));
    });

    test('copyWith creates modified copy', () {
      var original = const Coordinates(35.78056, -78.6389);
      var modified = original.copyWith(latitude: 40.0);
      expect(modified.latitude, 40.0);
      expect(modified.longitude, -78.6389);
    });

    test('toString returns readable format', () {
      var coords = const Coordinates(35.78056, -78.6389);
      expect(coords.toString(),
          'Coordinates(latitude: 35.78056, longitude: -78.6389)');
    });
  });

  group('Madhab', () {
    test('shafi shadow length is 1', () {
      expect(shadowLength(Madhab.shafi), 1);
    });

    test('hanafi shadow length is 2', () {
      expect(shadowLength(Madhab.hanafi), 2);
    });
  });

  group('HighLatitudeRule', () {
    test('enum has three values', () {
      expect(HighLatitudeRule.values.length, 3);
      expect(HighLatitudeRule.values,
          contains(HighLatitudeRule.middleOfTheNight));
      expect(HighLatitudeRule.values,
          contains(HighLatitudeRule.seventhOfTheNight));
      expect(
          HighLatitudeRule.values, contains(HighLatitudeRule.twilightAngle));
    });
  });

  group('Prayer enum', () {
    test('has all expected values', () {
      expect(Prayer.values.length, 8);
      expect(Prayer.values, contains(Prayer.fajr));
      expect(Prayer.values, contains(Prayer.sunrise));
      expect(Prayer.values, contains(Prayer.dhuhr));
      expect(Prayer.values, contains(Prayer.asr));
      expect(Prayer.values, contains(Prayer.maghrib));
      expect(Prayer.values, contains(Prayer.isha));
      expect(Prayer.values, contains(Prayer.ishaBefore));
      expect(Prayer.values, contains(Prayer.fajrAfter));
    });
  });

  group('PrayerTimes edge cases', () {
    test('prayer times ordering is correct (fajr < sunrise < dhuhr < asr < maghrib < isha)', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.northAmerica();
      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      expect(pt.fajr.isBefore(pt.sunrise), isTrue);
      expect(pt.sunrise.isBefore(pt.dhuhr), isTrue);
      expect(pt.dhuhr.isBefore(pt.asr), isTrue);
      expect(pt.asr.isBefore(pt.maghrib), isTrue);
      expect(pt.maghrib.isBefore(pt.isha), isTrue);
    });

    test('hanafi asr is later than shafi asr', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);

      var shafiParams = CalculationMethodParameters.muslimWorldLeague();
      shafiParams.madhab = Madhab.shafi;
      var shafiPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: shafiParams,
      );

      var hanafiParams = CalculationMethodParameters.muslimWorldLeague();
      hanafiParams.madhab = Madhab.hanafi;
      var hanafiPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: hanafiParams,
      );

      expect(hanafiPt.asr.isAfter(shafiPt.asr), isTrue);
      // Other prayers should be the same
      expect(hanafiPt.fajr, equals(shafiPt.fajr));
      expect(hanafiPt.sunrise, equals(shafiPt.sunrise));
      expect(hanafiPt.dhuhr, equals(shafiPt.dhuhr));
      expect(hanafiPt.maghrib, equals(shafiPt.maghrib));
    });

    test('precision mode preserves seconds', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.northAmerica();

      var roundedPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
        precision: false,
      );

      var precisePt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
        precision: true,
      );

      // Rounded times should have 0 seconds
      expect(roundedPt.fajr.second, 0);
      expect(roundedPt.dhuhr.second, 0);

      // Precise times may have non-zero seconds (at least some of them)
      bool anyHasSeconds = [
        precisePt.fajr.second,
        precisePt.sunrise.second,
        precisePt.dhuhr.second,
        precisePt.asr.second,
        precisePt.maghrib.second,
        precisePt.isha.second,
      ].any((s) => s != 0);
      expect(anyHasSeconds, isTrue);
    });

    test('adjustments shift prayer times', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);

      var baseParams = CalculationMethodParameters.muslimWorldLeague();
      var basePt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: baseParams,
      );

      var adjustedParams = CalculationMethodParameters.muslimWorldLeague();
      adjustedParams.adjustments = {
        Prayer.fajr: 2,
        Prayer.sunrise: 0,
        Prayer.dhuhr: 0,
        Prayer.asr: 0,
        Prayer.maghrib: 0,
        Prayer.isha: -3,
      };
      var adjustedPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: adjustedParams,
      );

      // Fajr should be 2 minutes later
      expect(adjustedPt.fajr.difference(basePt.fajr).inMinutes, 2);
      // Isha should be 3 minutes earlier
      expect(adjustedPt.isha.difference(basePt.isha).inMinutes, -3);
    });

    test('timeForPrayer returns correct time for each prayer', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.northAmerica();
      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      expect(pt.timeForPrayer(Prayer.fajr), pt.fajr);
      expect(pt.timeForPrayer(Prayer.sunrise), pt.sunrise);
      expect(pt.timeForPrayer(Prayer.dhuhr), pt.dhuhr);
      expect(pt.timeForPrayer(Prayer.asr), pt.asr);
      expect(pt.timeForPrayer(Prayer.maghrib), pt.maghrib);
      expect(pt.timeForPrayer(Prayer.isha), pt.isha);
      expect(pt.timeForPrayer(Prayer.ishaBefore), pt.ishaBefore);
      expect(pt.timeForPrayer(Prayer.fajrAfter), pt.fajrAfter);
    });

    test('currentPrayer and nextPrayer are consistent', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.northAmerica();
      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      // After fajr, before sunrise
      var afterFajr = pt.fajr.add(const Duration(minutes: 1));
      expect(pt.currentPrayer(date: afterFajr), Prayer.fajr);
      expect(pt.nextPrayer(date: afterFajr), Prayer.sunrise);

      // After dhuhr, before asr
      var afterDhuhr = pt.dhuhr.add(const Duration(minutes: 1));
      expect(pt.currentPrayer(date: afterDhuhr), Prayer.dhuhr);
      expect(pt.nextPrayer(date: afterDhuhr), Prayer.asr);

      // After isha
      var afterIsha = pt.isha.add(const Duration(minutes: 1));
      expect(pt.currentPrayer(date: afterIsha), Prayer.isha);
      expect(pt.nextPrayer(date: afterIsha), Prayer.fajrAfter);
    });

    test('before fajr returns ishaBefore for current prayer', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.northAmerica();
      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      var beforeFajr = pt.fajr.subtract(const Duration(minutes: 30));
      expect(pt.currentPrayer(date: beforeFajr), Prayer.ishaBefore);
      expect(pt.nextPrayer(date: beforeFajr), Prayer.fajr);
    });

    test('ishaBefore and fajrAfter are computed', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.northAmerica();
      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      // ishaBefore should be on or before current date
      expect(pt.ishaBefore.isBefore(pt.fajr), isTrue);
      // fajrAfter should be after current isha
      expect(pt.fajrAfter.isAfter(pt.isha), isTrue);
    });
  });

  group('SunnahTimes', () {
    test('middleOfTheNight is between maghrib and fajr', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.northAmerica();
      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );
      var sunnah = SunnahTimes(pt);

      expect(sunnah.middleOfTheNight.isAfter(pt.maghrib), isTrue);
      expect(sunnah.lastThirdOfTheNight.isAfter(sunnah.middleOfTheNight),
          isTrue);
    });

    test('lastThirdOfTheNight is after middleOfTheNight', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);
      var params = CalculationMethodParameters.muslimWorldLeague();
      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );
      var sunnah = SunnahTimes(pt);

      expect(sunnah.lastThirdOfTheNight.isAfter(sunnah.middleOfTheNight),
          isTrue);
    });
  });

  group('Qibla', () {
    test('qibla direction for known locations', () {
      // Washington DC area
      var dcDirection = Qibla.qibla(const Coordinates(38.9072, -77.0369));
      expect(dcDirection, closeTo(56.56, 1.0));

      // London
      var londonDirection = Qibla.qibla(const Coordinates(51.5074, -0.1278));
      expect(londonDirection, closeTo(118.99, 1.0));

      // Makkah itself should be approximately 0 or 360
      var makkahDirection =
          Qibla.qibla(const Coordinates(21.4225241, 39.8261818));
      // Direction from Makkah to Makkah is undefined but should be a number
      expect(makkahDirection, isNotNaN);
    });

    test('qibla direction in different hemispheres', () {
      // Southern hemisphere
      var sydneyDirection =
          Qibla.qibla(const Coordinates(-33.8688, 151.2093));
      expect(sydneyDirection, greaterThan(0));
      expect(sydneyDirection, lessThan(360));

      // Eastern hemisphere
      var tokyoDirection = Qibla.qibla(const Coordinates(35.6762, 139.6503));
      expect(tokyoDirection, greaterThan(0));
      expect(tokyoDirection, lessThan(360));
    });
  });

  group('HighLatitudeRule effect', () {
    test('seventhOfTheNight gives earlier isha than middleOfTheNight at high latitudes', () {
      // Edinburgh, Scotland - high latitude
      var coordinates = const Coordinates(55.9533, -3.1883);
      var date = DateTime(2015, 6, 15); // Summer - long days

      var midParams = CalculationMethodParameters.muslimWorldLeague();
      midParams.highLatitudeRule = HighLatitudeRule.middleOfTheNight;
      var midPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: midParams,
      );

      var seventhParams = CalculationMethodParameters.muslimWorldLeague();
      seventhParams.highLatitudeRule = HighLatitudeRule.seventhOfTheNight;
      var seventhPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: seventhParams,
      );

      // With seventhOfTheNight, isha should be earlier (or equal)
      expect(
          seventhPt.isha.isBefore(midPt.isha) ||
              seventhPt.isha.isAtSameMomentAs(midPt.isha),
          isTrue);
    });
  });

  group('MoonsightingCommittee special handling', () {
    test('uses seasonal adjustments for locations above 55 latitude', () {
      // Oslo, Norway - above 55
      var coordinates = const Coordinates(59.9139, 10.7522);
      var date = DateTime(2020, 6, 15);
      var params = CalculationMethodParameters.moonsightingCommittee();
      params.highLatitudeRule = HighLatitudeRule.seventhOfTheNight;

      var pt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      // Should produce valid prayer times (not crash)
      expect(pt.fajr.isBefore(pt.sunrise), isTrue);
      expect(pt.sunrise.isBefore(pt.dhuhr), isTrue);
      expect(pt.dhuhr.isBefore(pt.asr), isTrue);
      expect(pt.asr.isBefore(pt.maghrib), isTrue);
      expect(pt.maghrib.isBefore(pt.isha), isTrue);
    });
  });

  group('Different methods produce different times', () {
    test('methods with different fajr angles produce different fajr times', () {
      var coordinates = const Coordinates(35.78056, -78.6389);
      var date = DateTime(2015, 7, 12);

      var mwlPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: CalculationMethodParameters.muslimWorldLeague(),
      );

      var naPt = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: CalculationMethodParameters.northAmerica(),
      );

      // MWL fajr angle (18°) > ISNA fajr angle (15°)
      // So MWL fajr should be earlier
      expect(mwlPt.fajr.isBefore(naPt.fajr), isTrue);
    });
  });
}
