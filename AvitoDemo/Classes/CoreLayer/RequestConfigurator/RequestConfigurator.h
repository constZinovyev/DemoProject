//
//  RequestConfigurator.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

@class RequestDataModel;

@protocol RequestConfigurator <NSObject>

/**
 Создает запрос по модели
 */
- (NSURLRequest *)obtainRequestWithDataModel:(RequestDataModel *)dataModel;

@end
