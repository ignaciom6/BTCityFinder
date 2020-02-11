//
//  BTCityModel.m
//  BackbaseTest
//
//  Created by Ignacio on 11/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCityModel.h"

static NSString *const kNameKey = @"name";
static NSString *const kCountryKey = @"country";
static NSString *const kIdKey = @"_id";
static NSString *const kCoordKey = @"coord";

@implementation BTCityModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _name = [dictionary objectForKey:kNameKey];
        _country = [dictionary objectForKey:kCountryKey];
        _cityId = [[dictionary objectForKey:kIdKey] doubleValue];
        _coordDataModel = [[BTCityCoordinatesDataModel alloc] initWithDictionary:[dictionary objectForKey:kCoordKey]];
    }
    
    return self;
}

@end
