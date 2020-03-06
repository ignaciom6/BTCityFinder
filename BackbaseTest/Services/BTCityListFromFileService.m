//
//  BTCityListFromFileService.m
//  BackbaseTest
//
//  Created by Ignacio on 13/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCityListFromFileService.h"

@implementation BTCityListFromFileService

- (void)getCitiesFromFile:(NSString *)file type:(NSString *)format withCompletion:(void (^)(NSArray *value, NSError *error))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:format];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data) {
        NSArray *citiesArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        completion(citiesArray, nil);
    } else {
        NSError *error = [NSError errorWithDomain:@"BTCityListFromFileService" code:-1 userInfo:@{@"error" : @"Could not retrieve cities file"}];
        completion(nil, error);
    }
    
    
}

@end
