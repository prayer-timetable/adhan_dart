import 'dart:math';

degreesToRadians(degrees) {
  return (degrees * pi) / 180.0;
}

radiansToDegrees(radians) {
  return (radians * 180.0) / pi;
}

normalizeToScale(number, max) {
  return number - (max * ((number / max).floor()));
}

unwindAngle(angle) {
  return normalizeToScale(angle, 360.0);
}

quadrantShiftAngle(angle) {
  if (angle >= -180 && angle <= 180) {
    return angle;
  }

  return angle - (360 * (angle / 360).round());
}
