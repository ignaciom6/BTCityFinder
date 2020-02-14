//
//  BTArraySearcher.m
//  BackbaseTest
//
//  Created by Ignacio on 12/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTArraySearcher.h"
#import "BTCityModel.h"

@implementation BTArraySearcher

+ (NSMutableArray *)searchText:(NSString *)text inArray:(NSArray *)array
{
    __block NSUInteger binarySearchFirstIndex;
    __block NSUInteger binarySearchLastIndex;
    __block BOOL characterFound = NO;

    //Binary Search
    NSRange searchRange = NSMakeRange(0, [array count]);
    
    [array indexOfObject:text
           inSortedRange:searchRange
                 options:NSBinarySearchingFirstEqual
         usingComparator:^(BTCityModel *city, id prefix)
    {
        NSComparisonResult comparison = [city.name compare:prefix];
        NSComparisonResult result;
        characterFound = NO;
        
        NSRange nameRange = [city.name rangeOfString:text options:NSCaseInsensitiveSearch];
        if(nameRange.length != 0 && nameRange.location == 0)
        {
            binarySearchFirstIndex = [array indexOfObject:city];
            characterFound = YES;
        }
        
        if (comparison == NSOrderedAscending) { //city < prefix
            result = NSOrderedAscending;
        } else if (comparison == NSOrderedDescending) { //city > prefix
            result = NSOrderedDescending;
        } else {
            result = NSOrderedSame;
        }
        
        
        return result;
        
    }];
    
    [array indexOfObject:text
           inSortedRange:searchRange
                 options:NSBinarySearchingLastEqual
         usingComparator:^(BTCityModel *city, id prefix)
    {
        NSComparisonResult comparison = [city.name compare:prefix];
        NSComparisonResult result;
        characterFound = NO;

        NSRange nameRange = [city.name rangeOfString:text options:NSCaseInsensitiveSearch];
        if(nameRange.length != 0 && nameRange.location == 0)
        {
            binarySearchLastIndex = [array indexOfObject:city];
            comparison = NSOrderedAscending; //I want to know if there is another match to the right
            characterFound = YES;
        }

        if (comparison == NSOrderedAscending) {
            result =  NSOrderedAscending;
        } else if (comparison == NSOrderedDescending) {
            result =  NSOrderedDescending;
        } else {
            result =  NSOrderedSame;
        }
        
        return result;
    }];
    
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    if (characterFound) {
        NSUInteger rangeLength = binarySearchLastIndex - binarySearchFirstIndex + 1;
        searchArray = [[array subarrayWithRange:NSMakeRange(binarySearchFirstIndex, rangeLength)] mutableCopy];
    } else {
        [searchArray removeAllObjects];
    }
    
    return searchArray;
}


@end
