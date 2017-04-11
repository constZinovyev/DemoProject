//
//  MappingDataModel.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentType.h"

/**
 Модель маппинга из json->plain objects
 */
@interface MappingDataModel : NSObject

@property (nonatomic, strong) NSString *resultKey;

@property (nonatomic, assign) ContentType objectType;

@property (nonatomic, strong) NSDictionary *attributeMapping;

@end
