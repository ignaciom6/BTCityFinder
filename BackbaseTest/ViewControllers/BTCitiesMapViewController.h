//
//  BTCitiesMapViewController.h
//  BackbaseTest
//
//  Created by Ignacio on 14/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTCityModel.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTCitiesMapViewController : UIViewController

- (void)setCustomCity:(BTCityModel *)citySelected;

@end

NS_ASSUME_NONNULL_END
