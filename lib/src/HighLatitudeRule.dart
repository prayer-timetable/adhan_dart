import 'package:adhan_dart/src/Coordinates.dart';

/// Used to handle prayer time calculations in high latitude regions.
///
/// At high latitudes, Fajr and Isha may not occur because the sun
/// does not reach the required angle below the horizon. These rules
/// provide fallback calculations for such cases.
enum HighLatitudeRule {
  /// Fajr will never be earlier than the middle of the night and
  /// Isha will never be later than the middle of the night.
  middleOfTheNight,

  /// Fajr will never be earlier than the beginning of the last
  /// seventh of the night and Isha will never be later than the
  /// end of the first seventh of the night.
  seventhOfTheNight,

  /// Similar to seventhOfTheNight, but instead of 1/7, the fraction
  /// of the night used is fajrAngle/60 and ishaAngle/60.
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
