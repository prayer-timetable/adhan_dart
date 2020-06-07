class Madhab {
  // Madhab(){}
  final String Shafi = 'shafi';
  final String Hanafi = 'hanafi';
}

shadowLength(madhab) {
  const shafi = 'shafi';
  const hanafi = 'hanafi';
  switch (madhab) {
    case shafi:
      return 1;
    case hanafi:
      return 2;
    default:
      throw "Invalid Madhab";
  }
}
