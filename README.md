# Backbase Test

This app takes a list of cities from a json file included in the project and shows it in an alphabetically ordered tableView. You can filter this list by typing on the search bar at the top of the main view. You can also select a city of this list and it will show its position on a map.

## Getting Started

Clone or download the project from the GIT repository and open BackbaseTest.xcodeproj.

### Prerequisites

This app works with iOS 11.0 and above.

## Running the tests

BTCitiesListViewControllerTests.m class runs tests to prove the correct return values when a user starts searching for a city with the searchBar. 

## Deployment

User will need an iOS device with iOS 11 or higher.

## Built With

XCode 11.3.1 (11C504).

## Version

BackBaseTest v1.0

## Authors

* **Ignacio Mariani**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Known issues

Method searchText:inArray: performs a binary search. This is achieved by using NSArray method `idexOfObject:inSortedRange:options:usingComparator:` that compares two objects. In this case, the objects compared are the prefix entered by the user and the city.composedName string. In the end, this methot is not being used and the reason is I couldn't find why it reverses the values in `usingComparator`. The first time it runs, `BTCityModel *city` returns a BTCityModel object, and `id prefix` returns a string, but the second time it's executed, these values are reversed. `BTCityModel *city` returns a string and `id prefix` is a BTCityModel object. what causes the app to crash with an `unrecognized selector sent to instance`.
Anyway, the method was left written in the code so it can be improved in a future version.

