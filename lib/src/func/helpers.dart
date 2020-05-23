/* *********************** */
/* HELPER FUNCTIONS        */
/* *********************** */
DateTime convertToDateTime(seconds, {int offset = 0}) {
  DateTime now = DateTime.now();
  int dstAdjust = isDSTCalc(now) ? 1 : 0;

  return new DateTime(
          now.add(Duration(days: offset)).year,
          now.add(Duration(days: offset)).month,
          now.add(Duration(days: offset)).day,
          0,
          0,
          0,
          0)
      .add(Duration(seconds: seconds))
      .add(Duration(hours: dstAdjust));
}

bool isDSTCalc(DateTime d) =>
    new DateTime(d.year, 6, 1).timeZoneOffset == d.timeZoneOffset;

double round2Decimals(value) => num.parse(value.toStringAsFixed(2));
