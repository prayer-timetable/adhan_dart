# Changelog

All notable changes to this project will be documented in this file.

## 2.0.1 — 2026-05-11

### Changed

- **Dev dependency** `timezone` updated to **^0.11.0** (Dart **^3.10.0** for package consumers running tests or examples that load tzdata).
- **Tests and examples** initialize the full IANA database via **`package:timezone/data/latest_all.dart`** so zone names used in tests (e.g. `Europe/Oslo`, `Asia/Kuala_Lumpur`) remain available; **`latest.dart`** in timezone 0.11+ embeds a reduced zone set.
- **CI** minimum matrix SDK set to **3.10.0** to match timezone 0.11.
- **README**: documenting **`latest_all`** vs **`latest`**, and that local development/tests need Dart **3.10+** with current dev dependencies.

## 2.0.0 — 2026-05-10

### Added

- Configurable **`Rounding`** on `CalculationParameters`; **`PolarCircleResolution`** for extreme latitudes; **`sunset`** on `PrayerTimes`; **`Shafaq`** for Moonsighting Committee Isha (where applicable).
- Many **calculation methods** (e.g. Gulf, Russia, Jordan, Tunisia, Algeria, France UOIF, Portugal, Jafari, and others); **`displayName`** on `Prayer` and `CalculationMethod`; **`toString`** on `PrayerTimes`, `SunnahTimes`, and `CalculationParameters`.
- **`Madhab`** as an enhanced enum with **`shadowLength`**; `shadowLength(Madhab)` kept for compatibility.
- **Coordinate range validation** on `Coordinates`; expanded **tests**; **GitHub Actions** CI; **`lints`**; changelog and README updates; **pubspec** metadata and **`.gitignore`** improvements.

### Changed

- **Type safety** (e.g. `Coordinates` instead of `dynamic` where appropriate); docs/TODO cleanup; **dart formatting** applied across sources.

### Breaking changes

- **`PrayerTimes.currentPrayer` / `PrayerTimes.nextPrayer`** — The time argument is now an optional **named** parameter (`{DateTime? date}`) defaulting to `DateTime.now()`. Replace positional calls such as `currentPrayer(dateTime)` with **`currentPrayer(date: dateTime)`** (and likewise for `nextPrayer`). This is a compile-time break for existing call sites.
- **`CalculationMethod` and other public enums** — Many new calculation methods were added. **`switch` statements that are exhaustive over these enums must be updated** to handle the new values or use a default branch.
- **Singapore preset rounding** — `CalculationMethodParameters.singapore()` now sets **`Rounding.up`** for minute rounding. Published times can differ by up to a minute at boundaries compared to earlier releases that always used implicit nearest-minute behavior for that preset.
- **`Coordinates`** — **Assertions** enforce latitude ∈ [−90, 90] and longitude ∈ [−180, 180]. Out-of-range values that previously propagated may **fail in debug mode** (asserts are omitted in some release builds depending on your compile flags).
- **`PolarCircleResolution`** — When set to anything other than **`unresolved`**, polar-day/night edge cases use the new resolution logic and **may produce different times** than before for extreme latitudes.

Contributions in this release were driven largely by **Mahmoud Hamdi ([@mahmoodhamdi](https://github.com/mahmoodhamdi))** via GitHub pull requests **#17–#48** (stacked features, tests, docs, and tooling). Thank you for the extensive work on calculation methods, API polish, and quality improvements.

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
