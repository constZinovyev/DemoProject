//
//  ResponseValidatorImplementation.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ResponseValidatorImplementation.h"
#import "MappingDataModel.h"
#import "NSError+CustomError.h"

@implementation ResponseValidatorImplementation

- (NSError *)validateResponse:(NSDictionary *)response mappingDataModel:(MappingDataModel *)mappingModel {
    
    if (!response || !mappingModel || ![response isKindOfClass:[NSDictionary class]]) {
        return [self validationError];
    }
    
    NSArray *results = response[mappingModel.resultKey];
    if (results == nil || ![results isKindOfClass:[NSArray class]]) {
        return [self validationError];
    }
    
    NSArray *keys = mappingModel.attributeMapping.allValues;
    for (NSDictionary *item in results) {
        BOOL isItemCorrect = [item isKindOfClass:[NSDictionary class]];
        if (isItemCorrect) {
            for (NSString *key in keys) {
                id value = item[key];
                isItemCorrect = value == nil || [value isKindOfClass:[NSString class]];
                if (!isItemCorrect) {
                    break;
                }
            }
        }
        if (!isItemCorrect) {
            return [self validationError];
        }
    }
    
    return nil;
}

- (NSError *)validationError {
    return [NSError errorWithDomain:kDemoValidationErrorDomain
                                         code:kErrorCode
                                  description:kDemoValidationErrorDescription];
}

@end
