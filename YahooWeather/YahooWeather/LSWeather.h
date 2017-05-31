//
//  LSWeather.h
//  YahooWeather
//
//  Created by Oleksandr Kurtsev on 31.05.17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LSWeather : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
