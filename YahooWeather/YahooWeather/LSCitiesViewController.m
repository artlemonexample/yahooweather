//
//  LSCitiesViewController.m
//  YahooWeather
//
//  Created by Artem Kravchenko on 5/31/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSCitiesViewController.h"
#import "LSDataProvider.h"
#import "LSWeatherViewController.h"

@interface LSCitiesViewController ()

@property (nonatomic, strong) NSArray* cities;

@end

@implementation LSCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cities = [LSDataProvider cities];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LSWeatherViewController *weatherController = [segue destinationViewController];
    weatherController.city = self.cities[[self.tableView indexPathForCell:sender].row];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"city_cell" forIndexPath:indexPath];
    
    LSCity* city = [[self cities] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = city.nameCity;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cities.count;
}

@end
