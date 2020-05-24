/* *********************** */
/* HELPER FUNCTIONS        */
/* *********************** */
DateTime convertToDateTime(int seconds, DateTime date, {int offset = 0}) {
  int dstAdjust = isDSTCalc(date) ? 1 : 0;

  return new DateTime(
          date.add(Duration(days: offset)).year,
          date.add(Duration(days: offset)).month,
          date.add(Duration(days: offset)).day,
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
