/// A data class used to hold latitude and longitude values
/// to use in different methods/classes
///
/// ```dart
/// final cords = Coordinates(-39.1, 12.09)
/// ```
class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates(this.latitude, this.longitude);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Coordinates &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  /// Creates a copy of this Coordinates with the given fields replaced with new values
  Coordinates copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Coordinates(
      latitude ?? this.latitude,
      longitude ?? this.longitude,
    );
  }

  @override
  String toString() =>
      'Coordinates(latitude: $latitude, longitude: $longitude)';
}
