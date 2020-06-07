class SunCalc {
  final double azimuth;
  final double altitude;

  SunCalc({
    this.azimuth,
    this.altitude,
  });

  factory SunCalc.position(
    double azimuth,
    double altitude,
  ) {
    return SunCalc(
      azimuth: azimuth,
      altitude: altitude,
    );
  }
}
