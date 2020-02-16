//
//  BTArrayUtils.m
//  BackbaseTest
//
//  Created by Ignacio on 12/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTArrayUtils.h"
#import "BTCityModel.h"

@implementation BTArrayUtils

/*
 Method searchText:inArray: performs a binary search. This is achieved by using NSArray method indexOfObject:inSortedRange:options:usingComparator: that compares two objects. In this case, the objects compared are the prefix entered by the user and the city.composedName string. In the end, this method is not used and the reason is I couldn't find why it reverses the values in usingComparator. The first time it runs, BTCityModel *city returns a BTCityModel object, and id prefix returns a string, but the second time it's executed, these values are reversed. BTCityModel *city returns a string and id prefix is a BTCityModel object. What causes the app to crash with an "unrecognized selector sent to instance".
 */

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
        characterFound = NO;
        
        NSRange nameRange = [city.composedName rangeOfString:text options:NSCaseInsensitiveSearch];
        if(nameRange.length != 0 && nameRange.location == 0)
        {
            binarySearchFirstIndex = [array indexOfObject:city];
            characterFound = YES;
        }
        
        return [city.composedName compare:prefix];
        
    }];
    
    [array indexOfObject:text
           inSortedRange:searchRange
                 options:NSBinarySearchingLastEqual
         usingComparator:^(BTCityModel *city, id prefix)
    {
        NSComparisonResult comparison = [city.composedName compare:prefix];
        characterFound = NO;

        NSRange nameRange = [city.composedName rangeOfString:text options:NSCaseInsensitiveSearch];
        if(nameRange.length != 0 && nameRange.location == 0)
        {
            binarySearchLastIndex = [array indexOfObject:city];
            comparison = NSOrderedAscending; //I want to know if there is another match to the right
            characterFound = YES;
        }
        
        return comparison;
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

+ (NSArray *)orderArrayAlphabetically:(NSArray *)array
{
    NSArray *sortedCitiesArray;
    sortedCitiesArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *aComposedName = [(BTCityModel*)a composedName];
        NSString *bComposedName = [(BTCityModel*)b composedName];
        return [aComposedName compare:bComposedName];
    }];
    return sortedCitiesArray;
}


@end
