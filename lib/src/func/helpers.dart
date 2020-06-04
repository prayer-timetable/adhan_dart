/* *********************** */
/* HELPER FUNCTIONS        */
/* *********************** */

bool isDSTCalc(DateTime d) =>
    new DateTime(d.year, 6, 1).timeZoneOffset == d.timeZoneOffset;

double round2Decimals(value) => num.parse(value.toStringAsFixed(2));

DateTime secondsToDateTime(int seconds, DateTime date, {int offset = 0}) {
  int dstAdjust = isDSTCalc(date) ? 1 : 0;

  return new DateTime(
    date.add(Duration(days: offset)).year,
    date.add(Duration(days: offset)).month,
    date.add(Duration(days: offset)).day,
    0,
    0,
    0,
  ).add(Duration(seconds: seconds)).add(Duration(hours: dstAdjust));
}

DateTime hourFractionToDateTime(
    double hourFraction, DateTime date, bool summerTimeCalc, bool showSeconds) {
  // adjust times for dst
  int dstAdjust = summerTimeCalc && isDSTCalc(date) ? 1 : 0;

  int hour;
  if (hourFraction != double.nan && hourFraction != null)
    hour = hourFraction.floor();
  else
    hour = 23;

  int minute = showSeconds
      ? ((hourFraction - hour) * 60).round()
      : ((hourFraction - hour) * 60).floor(); // rounding minutes

  int second = showSeconds ? (hourFraction - hour - minute) : 0;

  return DateTime(date.year, date.month, date.day, hour, minute, second)
      .add(Duration(hours: dstAdjust));
}
