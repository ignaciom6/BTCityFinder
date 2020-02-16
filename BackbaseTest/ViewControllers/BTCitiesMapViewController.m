//
//  BTCitiesMapViewController.m
//  BackbaseTest
//
//  Created by Ignacio on 14/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCitiesMapViewController.h"
#import "BTCityModel.h"

@interface BTCitiesMapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) BTCityModel *city;
@property (strong, nonatomic) IBOutlet MKMapView *mainMap;

@end

@implementation BTCitiesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mainMap.delegate = self;
    self.title = self.city.composedName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    double latitude = self.city.coordDataModel.latitude;
    double longitude = self.city.coordDataModel.longitude;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(1, 1);
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(location, span);
    
    annotation.coordinate = location;
    [annotation setTitle:self.city.composedName];
    
    [self.mainMap addAnnotation:annotation];
    [self.mainMap setRegion:mapRegion];
    [self.mainMap selectAnnotation:annotation animated:YES];
}

- (void)setCustomCity:(BTCityModel *)citySelected
{
    self.city = citySelected;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
