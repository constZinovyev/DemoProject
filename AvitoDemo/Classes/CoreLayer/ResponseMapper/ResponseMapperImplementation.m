//
//  ResponseMapperImplementation.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ResponseMapperImplementation.h"
#import "MappingDataModel.h"
#import "UserPlainObject.h"

@interface ResponseMapperImplementation ()

@end

@implementation ResponseMapperImplementation

- (NSArray *)mapResponse:(NSDictionary *)response mappingDataModel:(MappingDataModel *)mappingModel {
    if (response == nil || mappingModel == nil) {
        return nil;
    }
    NSArray *items = response[mappingModel.resultKey];
    NSMutableArray *plains = [[NSMutableArray alloc] init];
    
        for (NSDictionary *item in items) {
            
            UserPlainObject *userModel = [[UserPlainObject alloc] init];
            [userModel setValue:@(mappingModel.objectType)
                         forKey:NSStringFromSelector(@selector(type))];
            [mappingModel.attributeMapping enumerateKeysAndObjectsUsingBlock:^(NSString *objectKey, NSString *responseKey, BOOL *stop) {
                NSString *value = item[responseKey];
                [userModel setValue:value
                             forKey:objectKey];
            }];
            [plains addObject:userModel];
        }
    return [plains copy];
}

@end
