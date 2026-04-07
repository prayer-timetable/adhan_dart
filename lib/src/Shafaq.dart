/// Shafaq is the twilight glow observed after sunset, used by the
/// MoonsightingCommittee method to determine Isha time.
enum Shafaq {
  /// General is a combination of Ahmer and Abyad. This is the default value
  /// and is recommended for most locations.
  general,

  /// Ahmer means the twilight is the red glow in the sky.
  /// Used by the Shafi, Maliki, and Hanbali madhabs.
  ahmer,

  /// Abyad means the twilight is the white glow in the sky.
  /// Used by the Hanafi madhab.
  abyad,
}
