import 'package:adhan_dart/adhan_dart.dart';

class CalculationParameters {
  late CalculationMethod method;
  late double fajrAngle;
  late double ishaAngle;
  int? ishaInterval;
  double? maghribAngle;
  Madhab? madhab;
  Shafaq? shafaq;
  late Rounding rounding;
  PolarCircleResolution? polarCircleResolution;

  HighLatitudeRule? highLatitudeRule;
  late Map<Prayer, int> adjustments;
  late Map<Prayer, int> methodAdjustments;

  CalculationParameters(
      {required CalculationMethod method,
      required double fajrAngle,
      required double ishaAngle,
      int? ishaInterval,
      double? maghribAngle,
      HighLatitudeRule? highLatitudeRule,
      Madhab? madhab,
      Shafaq? shafaq,
      Rounding? rounding,
      PolarCircleResolution? polarCircleResolution,
      Map<Prayer, int>? adjustments,
      Map<Prayer, int>? methodAdjustments}) {
    this.method = method;
    this.fajrAngle = fajrAngle;
    this.ishaAngle = ishaAngle;
    this.ishaInterval = ishaInterval ?? 0;
    this.maghribAngle = maghribAngle;
    this.madhab = madhab ?? Madhab.shafi;
    this.shafaq = shafaq ?? Shafaq.general;
    this.rounding = rounding ?? Rounding.nearest;
    this.polarCircleResolution =
        polarCircleResolution ?? PolarCircleResolution.unresolved;
    this.highLatitudeRule =
        highLatitudeRule ?? HighLatitudeRule.middleOfTheNight;
    this.adjustments = adjustments ??
        {
          Prayer.fajr: 0,
          Prayer.sunrise: 0,
          Prayer.dhuhr: 0,
          Prayer.asr: 0,
          Prayer.maghrib: 0,
          Prayer.isha: 0
        };
    this.methodAdjustments = methodAdjustments ??
        {
          Prayer.fajr: 0,
          Prayer.sunrise: 0,
          Prayer.dhuhr: 0,
          Prayer.asr: 0,
          Prayer.maghrib: 0,
          Prayer.isha: 0
        };
  }

  CalculationParameters copyWith({
    CalculationMethod? method,
    double? fajrAngle,
    double? ishaAngle,
    int? ishaInterval,
    double? maghribAngle,
    Madhab? madhab,
    Shafaq? shafaq,
    Rounding? rounding,
    PolarCircleResolution? polarCircleResolution,
    HighLatitudeRule? highLatitudeRule,
    Map<Prayer, int>? adjustments,
    Map<Prayer, int>? methodAdjustments,
  }) =>
      CalculationParameters(
        method: method ?? this.method,
        fajrAngle: fajrAngle ?? this.fajrAngle,
        ishaAngle: ishaAngle ?? this.ishaAngle,
        ishaInterval: ishaInterval ?? this.ishaInterval,
        maghribAngle: maghribAngle ?? this.maghribAngle,
        madhab: madhab ?? this.madhab,
        shafaq: shafaq ?? this.shafaq,
        rounding: rounding ?? this.rounding,
        polarCircleResolution:
            polarCircleResolution ?? this.polarCircleResolution,
        highLatitudeRule: highLatitudeRule ?? this.highLatitudeRule,
        adjustments: adjustments ?? this.adjustments,
        methodAdjustments: methodAdjustments ?? this.methodAdjustments,
      );

  Map<Prayer, double> nightPortions() {
    switch (highLatitudeRule) {
      case HighLatitudeRule.middleOfTheNight:
        return {Prayer.fajr: 1 / 2, Prayer.isha: 1 / 2};
      case HighLatitudeRule.seventhOfTheNight:
        return {Prayer.fajr: 1 / 7, Prayer.isha: 1 / 7};
      case HighLatitudeRule.twilightAngle:
        return {Prayer.fajr: fajrAngle / 60, Prayer.isha: ishaAngle / 60};
      default:
        throw ('Invalid high latitude rule found when attempting to compute night portions: $highLatitudeRule');
    }
  }
}
