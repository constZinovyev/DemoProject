//
//  ResponseValidator.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

@class MappingDataModel;

@protocol ResponseValidator <NSObject>

/**
 Проверяет корректность полученных данных
 */
- (NSError *)validateResponse:(NSDictionary *)response mappingDataModel:(MappingDataModel *)mappingModel;

@end
