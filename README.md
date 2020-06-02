# Dart Prayer Calc Library

Library for calculating muslim prayer times based on work published here:

https://www.academia.edu/35801795/Prayer_Time_Algorithm_for_Software_Development

# Dart Classes

## PrayerCalc

This class returns 5 daily prayers plus Sunrise. Takes following inputs:

* date (year, month, day)
* latitude
* longitude
* elevation
* solar angle (for both Dusk and Dawn)

## Durations

This class calculates durations to and from the prayers, taking into account next day Dawn for Isha prayer, as well as Previous day Isha when calculating Dawn for day after midnight. It also determines current, next and previous prayers based on current time. Main durations for all prayers:

* countdown to next prayer
* countup since last prayer
* percentage left to next prayer (from current prayer) - helpful for progress bars

## Sunnah

This class calculates times that apply to certain sunnah-defined times. It provides the following:

* Midnight (mid-point between the Sunset-Maghrib and Dawn-Fajr)
* Last third of the night (as above, beginning of the last third)

This document still under review and more updates coming insha'Allah soon.
