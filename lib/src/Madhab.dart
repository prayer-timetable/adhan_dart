class Madhab {
  // Madhab(){}
  static const String shafi = 'shafi';
  static const String hanafi = 'hanafi';
}

shadowLength(madhab) {
  const shafi = Madhab.shafi;
  const hanafi = Madhab.hanafi;
  switch (madhab) {
    case shafi:
      return 1;
    case hanafi:
      return 2;
    default:
      throw 'Invalid Madhab';
  }
}
