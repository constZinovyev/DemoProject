//
//  StatesStorage.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "StatesStorage.h"
#import "ContentListState.h"

@interface StatesStorage ()

@property (nonatomic, assign) NSUInteger indexCurrentState;

@end

@implementation StatesStorage

- (instancetype)initWithStates:(NSArray *)states {
    self = [super init];
    
    if (self) {
        _states = [states  copy];
        _lastSearchTerm = @"";
    }
    
    return self;
}

- (ContentListState *)currentState {
    return self.states[self.indexCurrentState];
}

- (void)setCurrentStateWithType:(ContentType)type {
    [self.states enumerateObjectsUsingBlock:^(ContentListState *state, NSUInteger index, BOOL *stop) {
        if (state.type == type) {
            self.indexCurrentState = index;
            *stop = YES;
            return;
        }
    }];
}

- (void)updateStateWithType:(ContentType)type andObjects:(NSArray *)objects {
    [self.states enumerateObjectsUsingBlock:^(ContentListState *state, NSUInteger index, BOOL *stop) {
        if (state.type == type) {
            state.objects = objects;
            state.contentOffset = CGPointZero;
            *stop = YES;
            return;
        }
    }];
}

- (void)updateCurrentStateWithContentOffset:(CGPoint)contentOffset {
    ContentListState *currentState = [self currentState];
    currentState.contentOffset = contentOffset;
}

@end
