//
//  BTArrayUtils.h
//  BackbaseTest
//
//  Created by Ignacio on 12/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTArrayUtils : NSObject

+ (NSMutableArray *)searchText:(NSString *)text inArray:(NSArray *)array;
+ (NSArray *)orderArrayAlphabetically:(NSArray *)array;

@end
