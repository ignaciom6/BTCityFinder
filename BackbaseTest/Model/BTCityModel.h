//
//  BTCityModel.h
//  BackbaseTest
//
//  Created by Ignacio on 11/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTCityCoordinatesDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTCityModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *composedName;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) BTCityCoordinatesDataModel *coordDataModel;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
