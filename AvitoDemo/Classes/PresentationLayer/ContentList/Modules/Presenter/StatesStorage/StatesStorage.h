//
//  StatesStorage.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ContentType.h"

@class ContentListState;

/**
 Хранилище состояний
 Отвечает за взаимодействие с объектами состояний
 */
@interface StatesStorage : NSObject

@property (nonatomic, strong) NSString *lastSearchTerm;
@property (nonatomic, strong) NSArray<ContentListState *> *states;

- (instancetype)initWithStates:(NSArray *)states;

/**
 Получение выбраного состояния
 */
- (ContentListState *)currentState;

/**
 Метод по переданному типу контента меняет текущее состояние
 */
- (void)setCurrentStateWithType:(ContentType)type;


/**
 Обновляет объекты определенного состояния
 */
- (void)updateStateWithType:(ContentType)type andObjects:(NSArray *)objects;

/**
 Обновляет смещение в таблице для текущего состояние 
 */
- (void)updateCurrentStateWithContentOffset:(CGPoint)contentOffset;

@end
