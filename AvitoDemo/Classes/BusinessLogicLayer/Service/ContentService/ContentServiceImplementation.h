//
//  ContentServiceImplementation.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentService.h"

@protocol RequestConfigurator;
@protocol NetworkClient;
@protocol ResponseDeserialization;
@protocol ResponseValidator;
@protocol ResponseMapper;
@class RequestDataModelFactory;
@class MappingDataModelFactory;

/**
 Сервис получения данных
 */
@interface ContentServiceImplementation : NSObject <ContentService>

@property (nonatomic, strong) id<RequestConfigurator> requestConfigurator;
@property (nonatomic, strong) id<NetworkClient> networkClient;
@property (nonatomic, strong) id<ResponseDeserialization> responseDeserialization;
@property (nonatomic, strong) id<ResponseValidator> responseValidator;
@property (nonatomic, strong) id<ResponseMapper> responseMapper;

@property (nonatomic, strong) RequestDataModelFactory *requestModelFactory;
@property (nonatomic, strong) MappingDataModelFactory *mappingModelFactory;

@end
