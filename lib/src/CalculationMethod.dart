import 'package:adhan_dart/src/CalculationParameters.dart';

/// Various calculation methods
class CalculationMethod {
  // Muslim World League
  static muslimWorldLeague() {
    CalculationParameters params =
        CalculationParameters(method: 'MuslimWorldLeague', fajrAngle: 18, ishaAngle: 17);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Egyptian General Authority of Survey
  static egyptian() {
    CalculationParameters params =
        CalculationParameters(method: 'Egyptian', fajrAngle: 19.5, ishaAngle: 17.5);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // University of Islamic Sciences, Karachi
  static karachi() {
    CalculationParameters params =
        CalculationParameters(method: 'Karachi', fajrAngle: 18, ishaAngle: 18);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Umm al-Qura University, Makkah
  static ummAlQura() {
    return CalculationParameters(
        method: 'UmmAlQura', fajrAngle: 18.5, ishaAngle: 0, ishaInterval: 90);
  }

  // Dubai
  static dubai() {
    CalculationParameters params =
        CalculationParameters(method: 'Dubai', fajrAngle: 18.2, ishaAngle: 18.2);
    params.methodAdjustments = {'sunrise': -3, 'dhuhr': 3, 'asr': 3, 'maghrib': 3};
    return params;
  }

  // Moonsighting Committee
  static moonsightingCommittee() {
    CalculationParameters params =
        CalculationParameters(method: 'MoonsightingCommittee', fajrAngle: 18, ishaAngle: 18);
    params.methodAdjustments = {'dhuhr': 5, 'maghrib': 3};
    return params;
  }

  // ISNA
  static northAmerica() {
    CalculationParameters params =
        CalculationParameters(method: 'NorthAmerica', fajrAngle: 15, ishaAngle: 15);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Kuwait
  static kuwait() {
    return CalculationParameters(method: 'Kuwait', fajrAngle: 18, ishaAngle: 17.5);
  }

  // Qatar
  static qatar() {
    return CalculationParameters(method: 'Qatar', fajrAngle: 18, ishaAngle: 0, ishaInterval: 90);
  }

  // Singapore
  static singapore() {
    CalculationParameters params =
        CalculationParameters(method: 'Singapore', fajrAngle: 20, ishaAngle: 18);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Institute of Geophysics, University of Tehran
  static tehran() {
    CalculationParameters params = CalculationParameters(
        method: 'Tehran', fajrAngle: 17.7, ishaAngle: 14, ishaInterval: 0, maghribAngle: 4.5);
    return params;
  }

  // Dianet
  static turkiye() {
    CalculationParameters params =
        CalculationParameters(method: 'Turkiye', fajrAngle: 18, ishaAngle: 17);
    params.methodAdjustments = {'sunrise': -7, 'dhuhr': 5, 'asr': 4, 'maghrib': 7};
    return params;
  }

  // Moroccan ministry of Habous and Islamic Affairs
  static morocco() {
    CalculationParameters params =
        CalculationParameters(method: 'Morocco', fajrAngle: 19, ishaAngle: 17);
    params.methodAdjustments = {'sunrise': -3, 'dhuhr': 5, 'maghrib': 5};
    return params;
  }

  // Other
  static other() {
    return CalculationParameters(method: 'Other', fajrAngle: 0, ishaAngle: 0);
  }
}
