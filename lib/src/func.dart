bool isDSTCalc(DateTime d) =>
    new DateTime(d.year, 6, 1).timeZoneOffset == d.timeZoneOffset;
