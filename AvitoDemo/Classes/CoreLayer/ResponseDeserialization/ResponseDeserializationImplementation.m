//
//  ResponseDeserializationImplementation.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ResponseDeserializationImplementation.h"

@implementation ResponseDeserializationImplementation

- (NSDictionary *)deserializeServerResponse:(NSData *)responseData {
    if (responseData == nil) {
        return nil;
    }
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                             options:NSJSONReadingMutableContainers
                                                               error:nil];
    return [response copy];
}

@end
