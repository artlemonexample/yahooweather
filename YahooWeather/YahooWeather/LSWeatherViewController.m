//
//  LSWeatherViewController.m
//  YahooWeather
//
//  Created by Oleksandr Kurtsev on 31.05.17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSWeatherViewController.h"
#import "LSDataProvider.h"
#import <MapKit/MapKit.h>

@interface LSWeatherViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation LSWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.city) {
        [LSDataProvider weatherForCity:self.city completion:^(LSWeather *weather) {
            [self.mapView setCenterCoordinate:weather.coordinate animated:YES];
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
