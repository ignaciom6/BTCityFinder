//
//  BTCityListManager.h
//  BackbaseTest
//
//  Created by Ignacio on 13/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTCityListManager : NSObject

- (void)getCitiesArrayForFile:(NSString *)file type:(NSString *)type withCompletion:(void (^)(NSArray *value, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
