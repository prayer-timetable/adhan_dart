import 'package:adhan_dart/adhan_dart.dart';

/// Enum holding all the available methods
enum CalculationMethod {
  algerian,
  dubai,
  egyptian,
  france,
  gulfRegion,
  indonesian,
  jafari,
  jordan,
  karachi,
  kuwait,
  moonsightingCommittee,
  morocco,
  muslimWorldLeague,
  northAmerica,
  other,
  qatar,
  russia,
  singapore,
  tehran,
  tunisia,
  turkiye,
  ummAlQura,
}

/// Class holding the calculation parameters for each method
class CalculationMethodParameters {
  /// Algerian Ministry of Religious Affairs and Wakfs
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 17°
  static CalculationParameters algerian() {
    return CalculationParameters(
        method: CalculationMethod.algerian, fajrAngle: 18, ishaAngle: 17);
  }

  /// Dubai
  ///
  /// Settings:
  /// - Fajr Angle: 18.2°
  /// - Isha Angle: 18.2°
  /// - Method Adjustments: Sunrise -3min, Dhuhr +3min, Asr +3min, Maghrib +3min
  static CalculationParameters dubai() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.dubai, fajrAngle: 18.2, ishaAngle: 18.2);
    params.methodAdjustments = {
      Prayer.sunrise: -3,
      Prayer.dhuhr: 3,
      Prayer.asr: 3,
      Prayer.maghrib: 3
    };
    return params;
  }

  /// Egyptian General Authority of Survey
  ///
  /// Settings:
  /// - Fajr Angle: 19.5°
  /// - Isha Angle: 17.5°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters egyptian() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.egyptian, fajrAngle: 19.5, ishaAngle: 17.5);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// Union des Organisations Islamiques de France (UOIF)
  ///
  /// Settings:
  /// - Fajr Angle: 12°
  /// - Isha Angle: 12°
  static CalculationParameters france() {
    return CalculationParameters(
        method: CalculationMethod.france, fajrAngle: 12, ishaAngle: 12);
  }

  /// Gulf Region
  ///
  /// Settings:
  /// - Fajr Angle: 19.5°
  /// - Isha Interval: 90 minutes after Maghrib
  static CalculationParameters gulfRegion() {
    return CalculationParameters(
        method: CalculationMethod.gulfRegion,
        fajrAngle: 19.5,
        ishaAngle: 0,
        ishaInterval: 90);
  }

  /// Kementerian Agama Republik Indonesia (KEMENAG)
  ///
  /// Settings:
  /// - Fajr Angle: 20°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters indonesian() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.indonesian, fajrAngle: 20, ishaAngle: 18);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// Shia Ithna-Ashari, Leva Institute, Qum
  ///
  /// Settings:
  /// - Fajr Angle: 16°
  /// - Isha Angle: 14°
  /// - Maghrib Angle: 4°
  static CalculationParameters jafari() {
    return CalculationParameters(
        method: CalculationMethod.jafari,
        fajrAngle: 16,
        ishaAngle: 14,
        maghribAngle: 4);
  }

  /// Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Maghrib +5min
  static CalculationParameters jordan() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.jordan, fajrAngle: 18, ishaAngle: 18);
    params.methodAdjustments = {Prayer.maghrib: 5};
    return params;
  }

  /// University of Islamic Sciences, Karachi
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters karachi() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.karachi, fajrAngle: 18, ishaAngle: 18);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// Kuwait
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 17.5°
  static CalculationParameters kuwait() {
    return CalculationParameters(
        method: CalculationMethod.kuwait, fajrAngle: 18, ishaAngle: 17.5);
  }

  /// Moonsighting Committee
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Dhuhr +5min, Maghrib +3min
  static CalculationParameters moonsightingCommittee() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.moonsightingCommittee,
        fajrAngle: 18,
        ishaAngle: 18);
    params.methodAdjustments = {Prayer.dhuhr: 5, Prayer.maghrib: 3};
    return params;
  }

  /// Morocco
  ///
  /// Settings:
  /// - Fajr Angle: 19°
  /// - Isha Angle: 17°
  /// - Method Adjustments: Sunrise -3min, Dhuhr +5min, Maghrib +5min
  static CalculationParameters morocco() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.morocco, fajrAngle: 19, ishaAngle: 17);
    params.methodAdjustments = {
      Prayer.sunrise: -3,
      Prayer.dhuhr: 5,
      Prayer.maghrib: 5
    };
    return params;
  }

  /// Muslim World League
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 17°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters muslimWorldLeague() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.muslimWorldLeague,
        fajrAngle: 18,
        ishaAngle: 17);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// North America (ISNA)
  ///
  /// Settings:
  /// - Fajr Angle: 15°
  /// - Isha Angle: 15°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters northAmerica() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.northAmerica, fajrAngle: 15, ishaAngle: 15);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// Other (Custom)
  ///
  /// Settings:
  /// - Fajr Angle: 0°
  /// - Isha Angle: 0°
  static CalculationParameters other() {
    return CalculationParameters(
        method: CalculationMethod.other, fajrAngle: 0, ishaAngle: 0);
  }

  /// Qatar
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Interval: 90 minutes after Maghrib
  static CalculationParameters qatar() {
    return CalculationParameters(
        method: CalculationMethod.qatar,
        fajrAngle: 18,
        ishaAngle: 0,
        ishaInterval: 90);
  }

  /// Spiritual Administration of Muslims of Russia
  ///
  /// Settings:
  /// - Fajr Angle: 16°
  /// - Isha Angle: 15°
  static CalculationParameters russia() {
    return CalculationParameters(
        method: CalculationMethod.russia, fajrAngle: 16, ishaAngle: 15);
  }

  /// Singapore
  ///
  /// Settings:
  /// - Fajr Angle: 20°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters singapore() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.singapore, fajrAngle: 20, ishaAngle: 18);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    params.rounding = Rounding.up;
    return params;
  }

  /// Tehran
  ///
  /// Settings:
  /// - Fajr Angle: 17.7°
  /// - Isha Angle: 14°
  /// - Maghrib Angle: 4.5°
  /// - Isha Interval: 0 (not used)
  static CalculationParameters tehran() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.tehran,
        fajrAngle: 17.7,
        ishaAngle: 14,
        ishaInterval: 0,
        maghribAngle: 4.5);
    return params;
  }

  /// Tunisian Ministry of Religious Affairs
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 18°
  static CalculationParameters tunisia() {
    return CalculationParameters(
        method: CalculationMethod.tunisia, fajrAngle: 18, ishaAngle: 18);
  }

  /// Turkey (Diyanet)
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 17°
  /// - Method Adjustments: Sunrise -7min, Dhuhr +5min, Asr +4min, Maghrib +7min
  static CalculationParameters turkiye() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.turkiye, fajrAngle: 18, ishaAngle: 17);
    params.methodAdjustments = {
      Prayer.sunrise: -7,
      Prayer.dhuhr: 5,
      Prayer.asr: 4,
      Prayer.maghrib: 7
    };
    return params;
  }

  /// Umm al-Qura University, Makkah
  ///
  /// Settings:
  /// - Fajr Angle: 18.5°
  /// - Isha Interval: 90 minutes after Maghrib
  ///
  /// Note: Add +30 minute custom adjustment for Isha during Ramadan
  static CalculationParameters ummAlQura() {
    return CalculationParameters(
        method: CalculationMethod.ummAlQura,
        fajrAngle: 18.5,
        ishaAngle: 0,
        ishaInterval: 90);
  }
}
