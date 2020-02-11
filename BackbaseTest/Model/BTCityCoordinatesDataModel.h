//
//  BTCityCoordinatesDataModel.h
//  BackbaseTest
//
//  Created by Ignacio on 11/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTCityCoordinatesDataModel : NSObject

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
