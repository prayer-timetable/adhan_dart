/// Madhab for Asr prayer time calculation.
///
/// The madhab determines the shadow length factor used to calculate
/// the Asr prayer time.
enum Madhab {
  /// Shafi madhab. Asr begins when shadow length equals the object height
  /// plus the shadow length at noon (shadow factor = 1).
  shafi(1),

  /// Hanafi madhab. Asr begins when shadow length equals twice the object
  /// height plus the shadow length at noon (shadow factor = 2).
  hanafi(2);

  /// The shadow length multiplier used for Asr calculation.
  final int shadowLength;

  const Madhab(this.shadowLength);
}

/// Returns the shadow length factor for the given madhab.
///
/// Preserved for backward compatibility with existing code.
int shadowLength(Madhab madhab) => madhab.shadowLength;
