/// Controls how prayer times are rounded to the nearest minute.
enum Rounding {
  /// Round to the nearest minute. This is the default.
  nearest,

  /// Always round up to the next minute.
  up,

  /// No rounding. Times are returned with second precision.
  none,
}
