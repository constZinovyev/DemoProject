//
//  ServicesAssembly.m
//  AvitoDemo
//
//  Created by k.zinovyev on 07.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ServicesAssembly.h"

#import "ContentService.h"
#import "ContentServiceImplementation.h"

#import "RequestConfiguratorImplementation.h"
#import "NetworkClientImplementation.h"
#import "ResponseDeserializationImplementation.h"
#import "ResponseValidatorImplementation.h"
#import "ResponseMapperImplementation.h"

#import "RequestDataModelFactory.h"
#import "MappingDataModelFactory.h"

@implementation ServicesAssembly

- (id<ContentService>)serviceGitHubSearch {
    return [self contentService];
}

- (id<ContentService>)serviceAppleSearch {
    return [self contentService];
}

#pragma mark - Приватные методы

-(id<ContentService>)contentService {
    ContentServiceImplementation *service = [[ContentServiceImplementation alloc] init];
    
    service.requestConfigurator = [[RequestConfiguratorImplementation alloc] init];
    service.networkClient = [[NetworkClientImplementation alloc] init];
    service.responseDeserialization = [[ResponseDeserializationImplementation alloc] init];
    service.responseValidator = [[ResponseValidatorImplementation alloc] init];
    service.responseMapper = [[ResponseMapperImplementation alloc] init];
    
    service.requestModelFactory = [[RequestDataModelFactory alloc] init];
    service.mappingModelFactory = [[MappingDataModelFactory alloc] init];
    
    return service;
}

@end
