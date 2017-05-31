//
//  LSDataProvider.m
//  YahooWeather
//
//  Created by Oleksandr Kurtsev on 31.05.17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSDataProvider.h"
#import "AFNetworking.h"

#define QUERY_PREFIX @"http://query.yahooapis.com/v1/public/yql?q="
#define QUERY_SUFFIX @"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="

@implementation LSDataProvider

+ (void)weatherForCity:(LSCity*)city completion:(void (^)(LSWeather*))completion{
    NSString *query = [NSString stringWithFormat:@"%@%@%@", QUERY_PREFIX, [[NSString stringWithFormat:@"select * from weather.forecast where woeid=%@", city.woeidId] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], QUERY_SUFFIX];
    // Remove old file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSError *fileError;
    [[NSFileManager defaultManager] removeItemAtPath:[documentsPath stringByAppendingPathComponent:@"yql"] error:&fileError];
    if (fileError) {
        
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:query]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (completion) {
            completion([self weatherFromData:filePath]);
        }
    }];
    [downloadTask resume];
    
}

+ (NSArray*)cities {
    
    NSMutableArray* result = [NSMutableArray array];
    
    LSCity* kharkov = [LSCity new];
    kharkov.nameCity = @"Kharkov";
    kharkov.woeidId = @"922137";
    
    LSCity* kiev = [LSCity new];
    kiev.nameCity = @"Kiev";
    kiev.woeidId = @"924938";
    
    LSCity* odessa = [LSCity new];
    odessa.nameCity = @"Odessa";
    odessa.woeidId = @"929398";
    
    LSCity* london = [LSCity new];
    london.nameCity = @"London";
    london.woeidId = @"44418";
    
    LSCity* amsterdam = [LSCity new];
    amsterdam.nameCity = @"Amsterdam";
    amsterdam.woeidId = @"727232";
    
    [result addObject:kharkov];
    [result addObject:kiev];
    [result addObject:odessa];
    [result addObject:london];
    [result addObject:amsterdam];

    return result.copy;
}

+ (LSWeather*)weatherFromData:(NSURL*)filePath {
    
    LSWeather* weather = [LSWeather new];
    
    NSData *jsonData = [[NSString stringWithContentsOfURL:filePath encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    
    NSDictionary* item = results[@"query"][@"results"][@"channel"][@"item"];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([item[@"lat"] doubleValue], [item[@"long"] doubleValue]);
    weather.coordinate = coordinate;
    
    return weather;
}

@end
