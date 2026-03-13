import 'package:adhan_dart/src/Coordinates.dart';
import 'package:adhan_dart/src/DateUtils.dart';
import 'package:adhan_dart/src/SolarTime.dart';

/// Strategy for resolving prayer times inside the polar circle where
/// sunrise or sunset may not occur for extended periods.
enum PolarCircleResolution {
  /// Use prayer times from the closest date where sunrise and sunset
  /// are both valid. Searches forward and backward up to ~6 months.
  aqrabYaum,

  /// Adjust latitude toward the equator in 0.5° steps until sunrise
  /// and sunset can be computed.
  aqrabBalad,

  /// Do not resolve. Prayer times may be invalid in polar regions.
  /// This is the default.
  unresolved,
}

const double _latitudeVariationStep = 0.5;
const double _unsafeLatitude = 65.0;

bool _isValidSolarTime(SolarTime solarTime) {
  return !solarTime.sunrise.isNaN && !solarTime.sunset.isNaN;
}

class PolarCircleResolvedValues {
  final DateTime date;
  final DateTime tomorrow;
  final Coordinates coordinates;
  final SolarTime solarTime;
  final SolarTime tomorrowSolarTime;

  PolarCircleResolvedValues({
    required this.date,
    required this.tomorrow,
    required this.coordinates,
    required this.solarTime,
    required this.tomorrowSolarTime,
  });
}

PolarCircleResolvedValues? _aqrabYaumResolver(
  Coordinates coordinates,
  DateTime date, {
  int daysAdded = 1,
  int direction = 1,
}) {
  if (daysAdded > (365 / 2).ceil()) {
    return null;
  }

  DateTime testDate = date.add(Duration(days: direction * daysAdded));
  DateTime tomorrow = dateByAddingDays(testDate, 1);
  SolarTime solarTime = SolarTime(testDate, coordinates);
  SolarTime tomorrowSolarTime = SolarTime(tomorrow, coordinates);

  if (!_isValidSolarTime(solarTime) || !_isValidSolarTime(tomorrowSolarTime)) {
    return _aqrabYaumResolver(
      coordinates,
      date,
      daysAdded: daysAdded + (direction > 0 ? 0 : 1),
      direction: -direction,
    );
  }

  return PolarCircleResolvedValues(
    date: date,
    tomorrow: tomorrow,
    coordinates: coordinates,
    solarTime: solarTime,
    tomorrowSolarTime: tomorrowSolarTime,
  );
}

PolarCircleResolvedValues? _aqrabBaladResolver(
  Coordinates coordinates,
  DateTime date,
  double latitude,
) {
  Coordinates adjusted = Coordinates(latitude, coordinates.longitude);
  SolarTime solarTime = SolarTime(date, adjusted);
  DateTime tomorrow = dateByAddingDays(date, 1);
  SolarTime tomorrowSolarTime = SolarTime(tomorrow, adjusted);

  if (!_isValidSolarTime(solarTime) || !_isValidSolarTime(tomorrowSolarTime)) {
    if (latitude.abs() >= _unsafeLatitude) {
      double sign = latitude >= 0 ? 1 : -1;
      return _aqrabBaladResolver(
        coordinates,
        date,
        latitude - sign * _latitudeVariationStep,
      );
    }
    return null;
  }

  return PolarCircleResolvedValues(
    date: date,
    tomorrow: tomorrow,
    coordinates: adjusted,
    solarTime: solarTime,
    tomorrowSolarTime: tomorrowSolarTime,
  );
}

/// Resolves solar times for a date and coordinates that may be in a
/// polar region where sunrise/sunset cannot be computed.
///
/// Returns resolved values or a default fallback if resolution fails.
PolarCircleResolvedValues resolvePolarCircle(
  PolarCircleResolution resolver,
  DateTime date,
  Coordinates coordinates,
) {
  PolarCircleResolvedValues defaultReturn = PolarCircleResolvedValues(
    date: date,
    tomorrow: dateByAddingDays(date, 1),
    coordinates: coordinates,
    solarTime: SolarTime(date, coordinates),
    tomorrowSolarTime: SolarTime(dateByAddingDays(date, 1), coordinates),
  );

  switch (resolver) {
    case PolarCircleResolution.aqrabYaum:
      return _aqrabYaumResolver(coordinates, date) ?? defaultReturn;
    case PolarCircleResolution.aqrabBalad:
      double latitude = coordinates.latitude;
      double sign = latitude >= 0 ? 1 : -1;
      return _aqrabBaladResolver(
            coordinates,
            date,
            latitude - sign * _latitudeVariationStep,
          ) ??
          defaultReturn;
    case PolarCircleResolution.unresolved:
      return defaultReturn;
  }
}
