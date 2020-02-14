//
//  BTCityCoordinatesDataModel.m
//  BackbaseTest
//
//  Created by Ignacio on 11/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCityCoordinatesDataModel.h"

static NSString *const kLatKey = @"lat";
static NSString *const kLonKey = @"lon";

@implementation BTCityCoordinatesDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _latitude = [[dictionary objectForKey:kLatKey] doubleValue];
        _longitude = [[dictionary objectForKey:kLonKey] doubleValue];
    }
    
    return self;
    
}

@end
