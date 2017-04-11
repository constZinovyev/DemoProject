//
//  ContentListPresenter.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListPresenter.h"
#import <CoreGraphics/CoreGraphics.h>

#import "ContentListViewInput.h"
#import "ContentListInteractorInput.h"
#import "ContentListRouterInput.h"
#import "ContentListState.h"
#import "StatesStorage.h"

static NSString *const kErrorTitle = @"Ошибка";
static NSString *const kErrorText = @"Пустые данные";

@implementation ContentListPresenter

#pragma mark - Методы ContentListViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view configureWithStates:self.statesStorage.states];
    ContentListState *currentState = [self.statesStorage currentState];
    [self.view updateViewWithState:currentState];
}

- (void)didTriggerChangeStateToType:(ContentType)type {
    CGPoint offset = [self.view obtainCurrentOffsetTableView];
    [self.statesStorage updateCurrentStateWithContentOffset:offset];
    
    [self.statesStorage setCurrentStateWithType:type];
    
    ContentListState *currentState = [self.statesStorage currentState];
    [self.view updateViewWithState:currentState];
}

- (void)didTriggerClickSearchWithTerm:(NSString *)term {
    if ([self.statesStorage.lastSearchTerm isEqualToString:term] || term.length == 0) {
        return;
    }
    self.statesStorage.lastSearchTerm = term;
    [self.interactor updateContentListWithType:ContentGitHubType
                                    searchTerm:term];
    [self.interactor updateContentListWithType:ContentAppleType
                                    searchTerm:term];
}

#pragma mark - Методы ContentListInteractorOutput

- (void)didUpdateContentListWithError:(NSError *)error
                                 type:(ContentType)type
                           searchTerm:(NSString *)searchTerm {
    [self.statesStorage updateStateWithType:type
                                 andObjects:@[]];
    if (![self isMatchingCurrentStateWithType:type
                                   searchTerm:searchTerm]) {
        return;
    }
    [self.router showAlertWithTitle:kErrorTitle
                            message:error.localizedDescription];
}

- (void)didUpdateContentListSuccessfullyWithType:(ContentType)type
                                    plainObjects:(NSArray *)plainObjects
                                      searchTerm:(NSString *)searchTerm {
    [self.statesStorage updateStateWithType:type
                                 andObjects:plainObjects];
    if (![self isMatchingCurrentStateWithType:type
                                   searchTerm:searchTerm]) {
        return;
    }
    ContentListState *currentState = [self.statesStorage currentState];
    if (plainObjects.count == 0) {
        [self.router showAlertWithTitle:kErrorTitle
                                message:kErrorText];
    }
    [self.view updateViewWithState:currentState];
}

#pragma mark - Приватные методы

- (BOOL)isMatchingCurrentStateWithType:(ContentType)type
                            searchTerm:(NSString *)searchTerm {
    ContentListState *currentState = [self.statesStorage currentState];
    if (currentState.type != type || ![self.statesStorage.lastSearchTerm isEqualToString:searchTerm]) {
        return NO;
    }
    return YES;

}

@end
