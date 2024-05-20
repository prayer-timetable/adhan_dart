import 'package:adhan_dart/src/Madhab.dart';
import 'package:adhan_dart/src/HighLatitudeRule.dart';

class CalculationParameters {
  late String method;
  late double fajrAngle;
  late double ishaAngle;
  int? ishaInterval;
  double? maghribAngle;
  String? madhab;

  String? highLatitudeRule;
  late Map adjustments;
  late Map methodAdjustments;

  CalculationParameters(
      {required String method,
      required double fajrAngle,
      required double ishaAngle,
      int? ishaInterval,
      double? maghribAngle,
      String? highLatitudeRule,
      String? madhab,
      Map? adjustments,
      Map? methodAdjustments}) {
    this.method = method;
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

  CalculationParameters copyWith({
    String? method,
    double? fajrAngle,
    double? ishaAngle,
    int? ishaInterval,
    double? maghribAngle,
    String? madhab,
    String? highLatitudeRule,
    Map? adjustments,
    Map? methodAdjustments,
  }) =>
      CalculationParameters(
        method: method ?? this.method,
        fajrAngle: fajrAngle ?? this.fajrAngle,
        ishaAngle: ishaAngle ?? this.ishaAngle ?? this.fajrAngle,

        // maghribAngle: maghribAngle ?? this.maghribAngle,
        madhab: madhab ?? this.madhab,
        highLatitudeRule: highLatitudeRule ?? this.highLatitudeRule,
        adjustments: adjustments ?? this.adjustments,
        methodAdjustments: methodAdjustments ?? this.methodAdjustments,
      );

  nightPortions() {
    switch (highLatitudeRule) {
      case HighLatitudeRule.middleOfTheNight:
        return {'fajr': 1 / 2, 'isha': 1 / 2};
      case HighLatitudeRule.seventhOfTheNight:
        return {'fajr': 1 / 7, 'isha': 1 / 7};
      case HighLatitudeRule.twilightAngle:
        return {'fajr': fajrAngle / 60, 'isha': ishaAngle ?? fajrAngle / 60};
      default:
        throw ('Invalid high latitude rule found when attempting to compute night portions: $highLatitudeRule');
    }
  }
}
