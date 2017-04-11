//
//  NSError+CustomError.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "NSError+CustomError.h"

@implementation NSError (CustomError)

+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description {
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey : description
                               };
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:userInfo];
    return error;
}

@end
