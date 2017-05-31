//
//  LSCitiesViewController.m
//  YahooWeather
//
//  Created by Artem Kravchenko on 5/31/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSCitiesViewController.h"

#import "YQL.h"

@interface LSCitiesViewController ()

@property (nonatomic, strong) YQL *weatherProvider;

@end

@implementation LSCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *result = [self.weatherProvider query:@"select * from weather.forecast where woeid=924938"];
    NSLog(@"%@", result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YQL *)weatherProvider
{
    if (!_weatherProvider)
    {
        _weatherProvider = [YQL new];
    }
    return _weatherProvider;
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
