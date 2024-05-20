import 'package:adhan_dart/src/Madhab.dart';
import 'package:adhan_dart/src/HighLatitudeRule.dart';

class CalculationParameters {
  String? method;
  late double fajrAngle;
  late double ishaAngle;
  int? ishaInterval;
  double? maghribAngle;
  String? madhab;

  String? highLatitudeRule;
  late Map adjustments;
  late Map methodAdjustments;

  CalculationParameters(String methodName, double fajrAngle, double ishaAngle,
      {int? ishaInterval,
      double? maghribAngle,
      String? highLatitudeRule,
      String? madhab,
      Map? adjustments,
      Map? methodAdjustments}) {
    method = methodName;
    this.fajrAngle = fajrAngle;
    this.ishaAngle = ishaAngle;
    this.ishaInterval = ishaInterval ?? 0;
    this.maghribAngle = maghribAngle;
    this.madhab = Madhab.shafi;
    this.highLatitudeRule = HighLatitudeRule.middleOfTheNight;
    this.adjustments = {'fajr': 0, 'sunrise': 0, 'dhuhr': 0, 'asr': 0, 'maghrib': 0, 'isha': 0};
    this.methodAdjustments = {
      'fajr': 0,
      'sunrise': 0,
      'dhuhr': 0,
      'asr': 0,
      'maghrib': 0,
      'isha': 0
    };
  }

  nightPortions() {
    switch (highLatitudeRule) {
      case HighLatitudeRule.middleOfTheNight:
        return {'fajr': 1 / 2, 'isha': 1 / 2};
      case HighLatitudeRule.seventhOfTheNight:
        return {'fajr': 1 / 7, 'isha': 1 / 7};
      case HighLatitudeRule.twilightAngle:
        return {'fajr': fajrAngle / 60, 'isha': ishaAngle / 60};
      default:
        throw ('Invalid high latitude rule found when attempting to compute night portions: $highLatitudeRule');
    }
  }
}
