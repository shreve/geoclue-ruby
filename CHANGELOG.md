# Changelog

All notable changes to the project will be documented here.

## [0.1.2] - 2020-06-28

### Added
- Add settlement field in results to capture city, town, village

### Fixed
- Update ReverseGeocoder to use OpenStreetMap
  Previous solution LocationIQ removed public access API

## [0.1.1] - 2019-06-09

### Fixed
- Properly add bin to bin list to publish

## [0.1.0] - 2019-06-08

Initial implementation

### Added
- Fetch coordinates from GeoClue via DBus
- Reverse geocode coordinates to an address
- CLI to access this functionality
- Tests, mostly related to cache
