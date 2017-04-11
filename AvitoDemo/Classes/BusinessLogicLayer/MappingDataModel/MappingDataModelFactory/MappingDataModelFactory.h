//
//  MappingDataModelFactory.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentType.h"

@class MappingDataModel;

/**
 Фабрика создает модель маппинга, по которой будут маппится объекты из json -> plain
 */
@interface MappingDataModelFactory : NSObject

- (MappingDataModel *)mappingDataModelForContentType:(ContentType)contentType;

@end
