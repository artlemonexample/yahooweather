//
//  LSDataProvider.h
//  YahooWeather
//
//  Created by Oleksandr Kurtsev on 31.05.17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSWeather.h"
#import "LSCity.h"

@interface LSDataProvider : NSObject

+ (void)weatherForCity:(LSCity*)city completion:(void (^)(LSWeather*))completion;
+ (NSArray*)cities;

@end
