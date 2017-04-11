//
//  ResponseMapper.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

@class MappingDataModel;

@protocol ResponseMapper <NSObject>

/**
 Маппинг объектов из json -> plain objects
 */
- (NSArray *)mapResponse:(id)response mappingDataModel:(MappingDataModel *)mappingModel;

@end
