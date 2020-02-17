//
//  BTCitiesListViewControllerTests.m
//  BackbaseTestTests
//
//  Created by Ignacio on 15/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTCitiesListViewController.h"
#import "BTCityModel.h"

@interface BTCitiesListViewControllerTests : XCTestCase

@end

@interface BTCitiesListViewController (Test) <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *citiesArray;
@property (nonatomic, strong) NSArray *citySearchArray;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@end

@implementation BTCitiesListViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSearchBarExists {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BTCitiesListViewController *listVC = [storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    [listVC view];
    
    XCTAssertNotNil(listVC.searchBar);
}

- (void)testShouldSetSearchBarDelegate {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BTCitiesListViewController *listVC = [storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    [listVC view];
    
    XCTAssertNotNil(listVC.searchBar.delegate);
}

- (void)testSearchBarResult {
    //Given
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BTCitiesListViewController *listVC = [storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    [listVC view];
    
    NSArray *citiesStringsArray = [[NSArray alloc] initWithObjects:
                                   @"Alabama, US",
                                   @"Albuquerque, US",
                                   @"Amsterdam, NL",
                                   @"Bangkok, TH",
                                   @"Buenos Aires, AR",
                                   @"Denver, US",
                                   @"Doha, QA",
                                   @"Earlton, CA",
                                   @"Firenze, IT",
                                   @"Madrid, CO",
                                   @"Madrid, ES",
                                   @"Ontario, CA",
                                   @"Orlando, US",
                                   @"芦屋, JP",nil];
    
    NSMutableArray *listOfCities = [[NSMutableArray alloc] init];
    
    for(NSString *cityName in citiesStringsArray) {
        BTCityModel *city = [[BTCityModel alloc] init];
        city.composedName = cityName;
        [listOfCities addObject:city];
    }
    
    listVC.citiesArray = [[NSArray alloc] initWithArray:listOfCities];
    
    //Test case insensitive
    [listVC searchBar:listVC.searchBar textDidChange:@"fIrENze"];
    XCTAssertEqual(listVC.citySearchArray.count, 1);
    BTCityModel *firenzeCity = listVC.citySearchArray[0];
    XCTAssertEqual(firenzeCity.composedName, @"Firenze, IT");
    
    //Test one character matching
    [listVC searchBar:listVC.searchBar textDidChange:@"a"];
    XCTAssertEqual(listVC.citySearchArray.count, 3);
    BTCityModel *alabamaCity = listVC.citySearchArray[0];
    BTCityModel *albuquerqueCity = listVC.citySearchArray[1];
    BTCityModel *amsterdamCity = listVC.citySearchArray[2];
    XCTAssertEqual(alabamaCity.composedName, @"Alabama, US");
    XCTAssertEqual(albuquerqueCity.composedName, @"Albuquerque, US");
    XCTAssertEqual(amsterdamCity.composedName, @"Amsterdam, NL");
    
    //Test two characters matching
    [listVC searchBar:listVC.searchBar textDidChange:@"al"];
    XCTAssertEqual(listVC.citySearchArray.count, 2);
    alabamaCity = listVC.citySearchArray[0];
    albuquerqueCity = listVC.citySearchArray[1];
    XCTAssertEqual(alabamaCity.composedName, @"Alabama, US");
    XCTAssertEqual(albuquerqueCity.composedName, @"Albuquerque, US");
    
    //Test three characters matching
    [listVC searchBar:listVC.searchBar textDidChange:@"alb"];
    XCTAssertEqual(listVC.citySearchArray.count, 1);
    albuquerqueCity = listVC.citySearchArray[0];
    XCTAssertEqual(albuquerqueCity.composedName, @"Albuquerque, US");
    
    //Test inserting one unmatching character after the first ones matched
    [listVC searchBar:listVC.searchBar textDidChange:@"albi"];
    XCTAssertEqual(listVC.citySearchArray.count, 0);
    
    //Test a character that is not the first letter of a city from the array
    [listVC searchBar:listVC.searchBar textDidChange:@"c"];
    XCTAssertEqual(listVC.citySearchArray.count, 0);
    
    [listVC searchBar:listVC.searchBar textDidChange:@" "];
    XCTAssertEqual(listVC.citySearchArray.count, 0);

    [listVC searchBar:listVC.searchBar textDidChange:@"1"];
    XCTAssertEqual(listVC.citySearchArray.count, 0);
    
    //Test a diferent character than "a" with repeated cities
    [listVC searchBar:listVC.searchBar textDidChange:@"b"];
    XCTAssertEqual(listVC.citySearchArray.count, 2);
    BTCityModel *bangkokCity = listVC.citySearchArray[0];
    BTCityModel *buenosAiresCity = listVC.citySearchArray[1];
    XCTAssertEqual(bangkokCity.composedName, @"Bangkok, TH");
    XCTAssertEqual(buenosAiresCity.composedName, @"Buenos Aires, AR");

    //Test adding one more character
    [listVC searchBar:listVC.searchBar textDidChange:@"bu"];
    XCTAssertEqual(listVC.citySearchArray.count, 1);
    buenosAiresCity = listVC.citySearchArray[0];
    XCTAssertEqual(buenosAiresCity.composedName, @"Buenos Aires, AR");
    
    //Test same city name with diferent country
    [listVC searchBar:listVC.searchBar textDidChange:@"m"];
    XCTAssertEqual(listVC.citySearchArray.count, 2);
    BTCityModel *madridCoCity = listVC.citySearchArray[0];
    BTCityModel *madridEsCity = listVC.citySearchArray[1];
    XCTAssertEqual(madridCoCity.composedName, @"Madrid, CO");
    XCTAssertEqual(madridEsCity.composedName, @"Madrid, ES");
    
    //Test character ","
    [listVC searchBar:listVC.searchBar textDidChange:@"madrid,"];
    XCTAssertEqual(listVC.citySearchArray.count, 2);
    madridCoCity = listVC.citySearchArray[0];
    madridEsCity = listVC.citySearchArray[1];
    XCTAssertEqual(madridCoCity.composedName, @"Madrid, CO");
    XCTAssertEqual(madridEsCity.composedName, @"Madrid, ES");
    
    //Test if the correct city is returned
    [listVC searchBar:listVC.searchBar textDidChange:@"madrid, c"];
    XCTAssertEqual(listVC.citySearchArray.count, 1);
    madridCoCity = listVC.citySearchArray[0];
    XCTAssertEqual(madridCoCity.composedName, @"Madrid, CO");
    
    [listVC searchBar:listVC.searchBar textDidChange:@"madrid, e"];
    XCTAssertEqual(listVC.citySearchArray.count, 1);
    madridEsCity = listVC.citySearchArray[0];
    XCTAssertEqual(madridEsCity.composedName, @"Madrid, ES");
    
    //Test adding an extra character to a search that already gave us a result
    [listVC searchBar:listVC.searchBar textDidChange:@"madrid, esa"];
    XCTAssertEqual(listVC.citySearchArray.count, 0);
    
    //Test another alphabet
    [listVC searchBar:listVC.searchBar textDidChange:@"芦屋"];
    XCTAssertEqual(listVC.citySearchArray.count, 1);
    BTCityModel *japanCity = listVC.citySearchArray[0];
    XCTAssertEqual(japanCity.composedName, @"芦屋, JP");
}



@end
