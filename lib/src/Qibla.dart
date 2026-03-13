import 'dart:math';

import 'package:adhan_dart/src/Coordinates.dart';
import 'package:adhan_dart/src/MathUtils.dart';

/// A class used to calculate the Qibla direction from a given location.
///
/// The Qibla is the direction that Muslims face during prayer, pointing
/// towards the Kaaba in Makkah, Saudi Arabia.
///
/// Example:
/// ```dart
/// final coordinates = Coordinates(-39.231, 12.412);
/// final qiblaAngle = Qibla.qibla(coordinates);
/// print(qiblaAngle); // prints a value of 28.015999604802534
/// ```
class Qibla {
  static const Coordinates makkah = Coordinates(21.4225241, 39.8261818);

  /// Calculates the Qibla direction from the given coordinates.
  ///
  /// Returns the angle in degrees from North (clockwise).
  ///
  /// Example:
  /// ```dart
  /// final coordinates = Coordinates(35.78056, -78.6389);
  /// final angle = Qibla.qibla(coordinates);
  /// ```
  static double qibla(Coordinates coordinates) {
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
