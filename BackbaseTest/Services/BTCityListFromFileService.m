//
//  BTCityListFromFileService.m
//  BackbaseTest
//
//  Created by Ignacio on 13/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCityListFromFileService.h"

@implementation BTCityListFromFileService

- (void)getCitiesFromFileWithCompletion:(void (^)(NSArray *value, NSError *error))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *citiesArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSError *err = nil;
    
    completion(citiesArray, err);
}

@end
