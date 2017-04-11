//
//  RequestConfiguratorImplementation.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "RequestConfiguratorImplementation.h"
#import "RequestDataModel.h"

@implementation RequestConfiguratorImplementation

- (NSURLRequest *)obtainRequestWithDataModel:(RequestDataModel *)dataModel {
    if (dataModel == nil) {
        return nil;
    }
    NSString *parametrs = [self stringByParametrs:dataModel.queryParameters];
    NSString *stringRequest = [NSString  stringWithFormat:@"%@%@", dataModel.searchURL, parametrs];
    
    NSURL *url = [NSURL URLWithString:stringRequest];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

#pragma mark - Приватные методы

- (NSString *)stringByParametrs:(NSDictionary *)parametrs {
    NSMutableString *result = [@"" mutableCopy];
    [parametrs enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        NSString *prefix = (result.length == 0) ? @"?" : @"&";
        NSString *stringValue = [value stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [result appendFormat: @"%@%@=%@", prefix, key, stringValue];
    }];
    return result;
}

@end
