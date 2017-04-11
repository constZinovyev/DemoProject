//
//  ContentListViewInput.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContentListState;

@protocol ContentListViewInput <NSObject>

/**
 @author Konstantin Zinovyev

 Метод настраивает view, используя массив возомжных состояний
 */
- (void)configureWithStates:(NSArray *)states;

/**
 Обновляет view по переданному состоянию
 */
- (void)updateViewWithState:(ContentListState *)state;

/**
 Запрашивает текущее смещение в таблице
 */
- (CGPoint)obtainCurrentOffsetTableView;

@end
