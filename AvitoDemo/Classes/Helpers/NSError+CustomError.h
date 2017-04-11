//
//  NSError+CustomError.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorConstants.h"

@interface NSError (CustomError)

/**
 Метод создает ошибку
 */
+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description;

@end
