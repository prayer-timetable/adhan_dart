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
  fajr,
  sunrise,
  dhuhr,
  asr,
  maghrib,
  isha,
  ishaBefore,
  fajrAfter,
}
