//
//  ContentService.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ContentType.h"

typedef void (^ContentServiceCompletionBlockWithError)(NSArray *objects, NSError * error);

@protocol ContentService <NSObject>

/**
 Метод инициирует загрузку контента
 */
- (void)loadContentWithType:(ContentType)type
                 searchTerm:(NSString *)searchTerm
             competionBlock:(ContentServiceCompletionBlockWithError)block;

@end
