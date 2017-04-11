//
//  ContentListCellObjectsBuilder.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentType.h"

@protocol ContentCellActions;

@interface ContentListCellObjectsBuilder : NSObject

/**
 Создает массив cell object'ов по view модели
 */
- (NSArray *)buildCellObjectsFromItems:(NSArray *)items
                           contentType:(ContentType)type
                                output:(id<ContentCellActions>)output;

@end
