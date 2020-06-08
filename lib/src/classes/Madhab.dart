class Madhab {
  // Madhab(){}
  static const String Shafi = 'shafi';
  static const String Hanafi = 'hanafi';
}

shadowLength(madhab) {
  const shafi = Madhab.Shafi;
  const hanafi = Madhab.Hanafi;
  switch (madhab) {
    case shafi:
      return 1;
    case hanafi:
      return 2;
    default:
      throw "Invalid Madhab";
  }
}
