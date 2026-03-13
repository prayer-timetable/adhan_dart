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
  twilightAngle,
}
