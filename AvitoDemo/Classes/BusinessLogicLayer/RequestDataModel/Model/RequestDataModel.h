//
//  RequestDataModel.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Класс описывает модель запроса
 */
@interface RequestDataModel : NSObject

@property (nonatomic, strong) NSString *searchURL;

@property (nonatomic, strong) NSDictionary *queryParameters;

@end
