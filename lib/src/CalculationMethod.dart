import 'package:adhan_dart/adhan_dart.dart';

enum CalculationMethod {
  dubai,
  egyptian,
  karachi,
  kuwait,
  moonsightingCommittee,
  morocco,
  muslimWorldLeague,
  northAmerica,
  other,
  qatar,
  singapore,
  tehran,
  turkiye,
  ummAlQura,
}

/// Various calculation methods
class CalculationMethodParameters {
  // Dubai
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

  // Egyptian General Authority of Survey
  static CalculationParameters egyptian() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.egyptian, fajrAngle: 19.5, ishaAngle: 17.5);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  // University of Islamic Sciences, Karachi
  static CalculationParameters karachi() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.karachi, fajrAngle: 18, ishaAngle: 18);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  // Kuwait
  static CalculationParameters kuwait() {
    return CalculationParameters(
        method: CalculationMethod.kuwait, fajrAngle: 18, ishaAngle: 17.5);
  }

  // Moonsighting Committee
  static CalculationParameters moonsightingCommittee() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.moonsightingCommittee,
        fajrAngle: 18,
        ishaAngle: 18);
    params.methodAdjustments = {Prayer.dhuhr: 5, Prayer.maghrib: 3};
    return params;
  }

  // Moroccan ministry of Habous and Islamic Affairs
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

  // Muslim World League
  static CalculationParameters muslimWorldLeague() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.muslimWorldLeague,
        fajrAngle: 18,
        ishaAngle: 17);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  // ISNA
  static CalculationParameters northAmerica() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.northAmerica, fajrAngle: 15, ishaAngle: 15);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  // Other
  static CalculationParameters other() {
    return CalculationParameters(
        method: CalculationMethod.other, fajrAngle: 0, ishaAngle: 0);
  }

  // Qatar
  static CalculationParameters qatar() {
    return CalculationParameters(
        method: CalculationMethod.qatar,
        fajrAngle: 18,
        ishaAngle: 0,
        ishaInterval: 90);
  }

  // Singapore
  static CalculationParameters singapore() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.singapore, fajrAngle: 20, ishaAngle: 18);
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  // Institute of Geophysics, University of Tehran
  static CalculationParameters tehran() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethod.tehran,
        fajrAngle: 17.7,
        ishaAngle: 14,
        ishaInterval: 0,
        maghribAngle: 4.5);
    return params;
  }

  // Dianet
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

  // Umm al-Qura University, Makkah
  static CalculationParameters ummAlQura() {
    return CalculationParameters(
        method: CalculationMethod.ummAlQura,
        fajrAngle: 18.5,
        ishaAngle: 0,
        ishaInterval: 90);
  }
}
