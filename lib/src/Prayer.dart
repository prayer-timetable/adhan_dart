/// Enum for each prayer
/// * five obligatory prayers
///   - fajr
///   - dhuhr
///   - asr
///   - maghrib
///   - isha
/// * three additional values
///   - sunrise
///   - ishaBefore (isha prayer of the day before)
///   - fajrAfter (fajr prayer of the next day)
enum Prayer {
  fajr('Fajr'),
  sunrise('Sunrise'),
  dhuhr('Dhuhr'),
  asr('Asr'),
  maghrib('Maghrib'),
  isha('Isha'),
  ishaBefore('Isha'),
  fajrAfter('Fajr');

  /// The display name for this prayer.
  final String displayName;

  const Prayer(this.displayName);
}
