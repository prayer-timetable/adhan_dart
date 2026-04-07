import 'package:adhan_dart/src/Coordinates.dart';

/// Used to handle prayer time calculations in high latitude regions
enum HighLatitudeRule {
  middleOfTheNight,
  seventhOfTheNight,
  twilightAngle;

  /// Returns the recommended high latitude rule for the given coordinates.
  ///
  /// For latitudes above 48°, [seventhOfTheNight] is recommended because
  /// twilight-based calculations become unreliable at higher latitudes.
  /// For latitudes at or below 48°, [middleOfTheNight] is sufficient.
  static HighLatitudeRule recommended(Coordinates coordinates) {
    if (coordinates.latitude > 48) {
      return HighLatitudeRule.seventhOfTheNight;
    } else {
      return HighLatitudeRule.middleOfTheNight;
    }
  }
}
