# Changelog

All notable changes to this project will be documented in this file.

## 1.2.0

- Calculation method changes (full credit to MoathCodes), typing fixes.

## 1.1.2

- Explicit `method`, `fajrAngle`, `ishaAngle` parameters for `CalculationParameters`.
- Explicit `coordinates`, `date`, `calculationParameters` parameters for `PrayerTimes`.

## 1.1.1

- Fixed documentation.
- Calculation parameters bug fix.

## 1.1.0

- Exposed `highLatitudeRule`, `madhab`, `adjustments`, `methodAdjustments` on `CalculationParameters`.
- Updated timezone package.
- New lint rules, fixed static methods naming convention.
- Turkey method renamed to Turkiye.

## 1.0.8

- Bug fix for UmmAlQura and Qatar calculation methods.

## 1.0.7

- `nextPrayer()` and `currentPrayer()` no longer return null before Fajr/after Isha.
- Added `ishaBefore` and `fajrAfter` prayer values.

## 1.0.6

- Fix for day of year calculation.

## 1.0.5

- Example added.

## 1.0.4

- Day of year native `DateTime` implementation in DateUtils.

## 1.0.3

- Null safety migration.

## 1.0.2

- Minor import fix.

## 1.0.1

- Timezone package moved to dev dependencies.

## 1.0.0

- Initial release.
