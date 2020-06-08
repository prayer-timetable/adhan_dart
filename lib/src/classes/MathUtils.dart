import 'dart:math';

double degreesToRadians(double degrees) {
  return (degrees * pi) / 180.0;
}

double radiansToDegrees(double radians) {
  return (radians * 180.0) / pi;
}

double normalizeToScale(double number, double max) {
  // print(number);
  // print(max);
  return number - (max * ((number / max).floor()));
}

double unwindAngle(double angle) {
  // print(angle);
  return normalizeToScale(angle, 360.0);
}

double quadrantShiftAngle(double angle) {
  if (angle >= -180 && angle <= 180) {
    return angle;
  }

  return angle - (360 * (angle / 360).round());
}
