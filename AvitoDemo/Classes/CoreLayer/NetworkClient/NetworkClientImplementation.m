//
//  NetworkClientImplementation.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "NetworkClientImplementation.h"
#import "NSError+CustomError.h"

@implementation NetworkClientImplementation

- (void)sendRequest:(NSURLRequest *)request competionBlock:(NetworkClientResponseBlock)block {
    if (request == nil) {
        block(nil, [self networkError]);
        return;
    }
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (block) {
            block(data, error);
        }
    }];
    [dataTask resume];
}

#pragma mark - Приватные методы

- (NSError *)networkError {
    return [NSError errorWithDomain:kDemoClientErrorDomain
                               code:kDemoClientErrorCode
                           description:kDemoClientErrorDescription];
}

@end
