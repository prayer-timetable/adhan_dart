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

  Duration totalSeconds = Duration(seconds: (hourFraction * 3600).round());

  int hour = totalSeconds.inHours;
  int minute = totalSeconds.inMinutes.remainder(60);
  int second = totalSeconds.inSeconds.remainder(60);

  // rounding
  if (second > 30 && !showSeconds) minute++;
  if (minute == 60) minute = 0;

  // int hour;
  // if (hourFraction != double.nan && hourFraction != null)
  //   hour = hourFraction.floor();
  // else
  //   hour = 23;

  // int minute = showSeconds
  //     ? ((hourFraction - hour) * 60).floor()
  //     : ((hourFraction - hour) * 60).round(); // rounding minutes

  // print('###\nhourFraction: $hourFraction\thour: $hour\tminute: $minute');

  // int second = showSeconds ? (hourFraction - hour - minute / 60).floor : 0;

  // print('***** second: $second');
  return DateTime(date.year, date.month, date.day, hour, minute, second)
      .add(Duration(hours: dstAdjust));
}
