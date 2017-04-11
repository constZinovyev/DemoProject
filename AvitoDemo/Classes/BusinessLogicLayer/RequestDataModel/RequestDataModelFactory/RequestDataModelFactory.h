//
//  RequestDataModelFactory.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentType.h"

@class RequestDataModel;

/**
 Фабрика создает модель запроса, по которой будет создан request
 */
@interface RequestDataModelFactory : NSObject

- (RequestDataModel *)requestDataModelForContentType:(ContentType)contentType
                                          searchTerm:(NSString *)term;

@end
