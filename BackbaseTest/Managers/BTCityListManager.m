//
//  BTCityListManager.m
//  BackbaseTest
//
//  Created by Ignacio on 13/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCityListManager.h"
#import "BTCityListFromFileService.h"
#import "BTCityModel.h"

@implementation BTCityListManager


- (void)getCitiesArrayWithCompletion:(void (^)(NSArray *value, NSError *error))completion
{
    BTCityListFromFileService *cityListService = [[BTCityListFromFileService alloc] init];
    [cityListService getCitiesFromFileWithCompletion:^(NSArray * _Nonnull value, NSError * _Nonnull error) {
        if (value) {
            NSMutableArray *citiesResultArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *cityDict in value)
            {
                BTCityModel *city = [[BTCityModel alloc] initWithDictionary:cityDict];
                [citiesResultArray addObject:city];
            }
            completion(citiesResultArray, nil);
        } else {
            completion(nil, error);
        }
    }];
}

@end
