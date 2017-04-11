//
//  ContentListDataDisplayManager.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ContentType.h"
#import "ContentCellActions.h"

@class ContentListCellObjectsBuilder;

@interface ContentListDataDisplayManager : NSObject <UITableViewDataSource, UITableViewDelegate, ContentCellActions>

@property (nonatomic, strong) ContentListCellObjectsBuilder *cellObjectsBuilder;
@property (nonatomic, weak) id<ContentCellActions> delegate;

/**
 Обновляет таблицу, используя переданные объекты
 */
- (void)updateTableModelWithObjects:(NSArray *)objects
                        contentType:(ContentType)type;

@end
