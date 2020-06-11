import 'package:adhan/src/CalculationParameters.dart';

class CalculationMethod {
  // Muslim World League
  static MuslimWorldLeague() {
    CalculationParameters params =
        new CalculationParameters("MuslimWorldLeague", 18, 17);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Egyptian General Authority of Survey
  static Egyptian() {
    CalculationParameters params =
        new CalculationParameters("Egyptian", 19.5, 17.5);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // University of Islamic Sciences, Karachi
  static Karachi() {
    CalculationParameters params = new CalculationParameters("Karachi", 18, 18);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Umm al-Qura University, Makkah
  static UmmAlQura() {
    return new CalculationParameters("UmmAlQura", 18.5, 0, ishaInterval: 90);
  }

  // Dubai
  static Dubai() {
    CalculationParameters params =
        new CalculationParameters("Dubai", 18.2, 18.2);
    params.methodAdjustments = {
      'sunrise': -3,
      'dhuhr': 3,
      'asr': 3,
      'maghrib': 3
    };
    return params;
  }

  // Moonsighting Committee
  static MoonsightingCommittee() {
    CalculationParameters params =
        new CalculationParameters("MoonsightingCommittee", 18, 18);
    params.methodAdjustments = {'dhuhr': 5, 'maghrib': 3};
    return params;
  }

  // ISNA
  static NorthAmerica() {
    CalculationParameters params =
        new CalculationParameters("NorthAmerica", 15, 15);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Kuwait
  static Kuwait() {
    return new CalculationParameters("Kuwait", 18, 17.5);
  }

  // Qatar
  static Qatar() {
    return new CalculationParameters("Qatar", 18, 0, ishaInterval: 90);
  }

  // Singapore
  static Singapore() {
    CalculationParameters params =
        new CalculationParameters("Singapore", 20, 18);
    params.methodAdjustments = {'dhuhr': 1};
    return params;
  }

  // Institute of Geophysics, University of Tehran
  static Tehran() {
    CalculationParameters params = new CalculationParameters("Tehran", 17.7, 14,
        ishaInterval: 0, maghribAngle: 4.5);
    return params;
  }

  // Dianet
  static Turkey() {
    CalculationParameters params = new CalculationParameters("Turkey", 18, 17);
    params.methodAdjustments = {
      'sunrise': -7,
      'dhuhr': 5,
      'asr': 4,
      'maghrib': 7
    };
    return params;
  }

  // Moroccan ministry of Habous and Islamic Affairs
  static Morocco() {
    CalculationParameters params = new CalculationParameters("Morocco", 19, 17);
    params.methodAdjustments = {'sunrise': -3, 'dhuhr': 5, 'maghrib': 5};
    return params;
  }

  // Other
  static Other() {
    return new CalculationParameters("Other", 0, 0);
  }
}
