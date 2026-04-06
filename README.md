# Attendify GeoCheck

A Flutter geo-fenced attendance application built with **MVVM + Cubit**. Users can set office location, see real-time distance from office, and mark attendance only when they are within a **50-meter radius**.

## Project Structure / Approach

This project follows a layered MVVM approach:

- `presentation` (View + ViewModel): Widgets + `AttendanceCubit`
- `domain` (Model contracts): entities, repository interfaces, and use cases
- `data` (Model implementation): datasource implementations and repository implementation
- `core`: shared utilities, failures, and platform services

Main classes:
- `AttendanceCubit`: screen-level state and business orchestration
- `AttendanceRepository`: domain contract
- `AttendanceRepositoryImpl`: integrates GPS and local persistence

## State Management

Cubit is used as the ViewModel layer:
- `setOfficeLocation()` stores office coordinates from current GPS
- `startDistanceTracking()` streams location and computes distance to office
- `markAttendance()` validates range and stores check-in record locally

## Local Persistence

- `SharedPreferences` stores:
  - office location (`lat/lon/set_at`)
  - attendance records list (JSON strings)

## How to Run

1. Install Flutter (stable channel).
2. Run:

```bash
flutter pub get
flutter run
```

## Permissions

This app requires location permission and location service enabled on device/emulator.

- Android: add location permissions in `AndroidManifest.xml`
- iOS: add location usage descriptions in `Info.plist`

## Generative AI Usage

AI assistance was used for:
- converting assessment requirements into implementation architecture
- generating starter boilerplate for MVVM + Cubit layers
- drafting initial README and project organization

All code was reviewed and organized into project layers before commit.
