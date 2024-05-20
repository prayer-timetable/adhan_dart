import 'package:adhan_dart/src/CalculationParameters.dart';

/// Various calculation methods
class CalculationMethod {
  // Muslim World League
  static muslimWorldLeague() {
    CalculationParameters params = CalculationParameters('MuslimWorldLeague', 18, 17);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Egyptian General Authority of Survey
  static egyptian() {
    CalculationParameters params = CalculationParameters('Egyptian', 19.5, 17.5);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // University of Islamic Sciences, Karachi
  static karachi() {
    CalculationParameters params = CalculationParameters('Karachi', 18, 18);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Umm al-Qura University, Makkah
  static ummAlQura() {
    return CalculationParameters('UmmAlQura', 18.5, 0, ishaInterval: 90);
  }

  // Dubai
  static dubai() {
    CalculationParameters params = CalculationParameters('Dubai', 18.2, 18.2);
    params.methodAdjustments = {'sunrise': -3, 'dhuhr': 3, 'asr': 3, 'maghrib': 3};
    return params;
  }

  // Moonsighting Committee
  static moonsightingCommittee() {
    CalculationParameters params = CalculationParameters('MoonsightingCommittee', 18, 18);
    params.methodAdjustments = {'dhuhr': 5, 'maghrib': 3};
    return params;
  }

  // ISNA
  static northAmerica() {
    CalculationParameters params = CalculationParameters('NorthAmerica', 15, 15);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Kuwait
  static kuwait() {
    return CalculationParameters('Kuwait', 18, 17.5);
  }

  // Qatar
  static qatar() {
    return CalculationParameters('Qatar', 18, 0, ishaInterval: 90);
  }

  // Singapore
  static singapore() {
    CalculationParameters params = CalculationParameters('Singapore', 20, 18);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Institute of Geophysics, University of Tehran
  static tehran() {
    CalculationParameters params =
        CalculationParameters('Tehran', 17.7, 14, ishaInterval: 0, maghribAngle: 4.5);
    return params;
  }

  // Dianet
  static turkiye() {
    CalculationParameters params = CalculationParameters('Turkey', 18, 17);
    params.methodAdjustments = {'sunrise': -7, 'dhuhr': 5, 'asr': 4, 'maghrib': 7};
    return params;
  }

  // Moroccan ministry of Habous and Islamic Affairs
  static morocco() {
    CalculationParameters params = CalculationParameters('Morocco', 19, 17);
    params.methodAdjustments = {'sunrise': -3, 'dhuhr': 5, 'maghrib': 5};
    return params;
  }

  // Other
  static other() {
    return CalculationParameters('Other', 0, 0);
  }
}
