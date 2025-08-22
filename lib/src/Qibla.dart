import 'dart:math';

import 'package:adhan_dart/src/Coordinates.dart';
import 'package:adhan_dart/src/MathUtils.dart';

/// A class used to calculate the Qibla direction
/// returns an angle in degrees that you could place as a mark
/// on a compass.
/// Example:
/// ```dart
/// final coordinates = Coordinates(-39.231, 12.412);
/// final qiblaAngle = Qibla.qibla(coordinates);
/// print(qiblaAngle); // prints a value of 28.015999604802534
/// ```
class Qibla {
  /// The method used to calculate the Qibla direction
  /// returns an angle in degrees that you could place as a mark
  /// on a compass.
  /// Example:
  /// ```dart
  /// final coordinates = Coordinates(-39.231, 12.412);
  /// final qiblaAngle = Qibla.qibla(coordinates);
  /// print(qiblaAngle); // prints a value of 28.015999604802534
  /// ```
  static double qibla(Coordinates coordinates) {
    Coordinates makkah = const Coordinates(21.4225241, 39.8261818);

    // Equation from "Spherical Trigonometry For the use of colleges and schools" page 50
    double term1 = (sin(degreesToRadians(makkah.longitude) -
        degreesToRadians(coordinates.longitude)));
    double term2 = (cos(degreesToRadians(coordinates.latitude)) *
        tan(degreesToRadians(makkah.latitude)));
    double term3 = (sin(degreesToRadians(coordinates.latitude)) *
        cos(degreesToRadians(makkah.longitude) -
            degreesToRadians(coordinates.longitude)));
    double angle = atan2(term1, term2 - term3);

    return unwindAngle(radiansToDegrees(angle));
  }
}
