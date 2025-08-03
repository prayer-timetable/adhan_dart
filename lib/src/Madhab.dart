int shadowLength(Madhab madhab) {
  switch (madhab) {
    case Madhab.shafi:
      return 1;
    case Madhab.hanafi:
      return 2;
  }
}

/// Enum containing 2 values
/// - shafi
/// - hanafi
///
/// Can be passed to the PrayerTimes class to set the madhab for calculations.
enum Madhab { shafi, hanafi }
