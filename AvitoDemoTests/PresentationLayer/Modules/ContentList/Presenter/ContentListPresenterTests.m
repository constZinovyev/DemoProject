//
//  ContentListPresenterTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ContentListPresenter.h"

#import "ContentListViewInput.h"
#import "ContentListInteractorInput.h"
#import "ContentListRouterInput.h"
#import "StatesStorage.h"
#import "ContentListState.h"

@interface ContentListPresenterTests : XCTestCase

@property (nonatomic, strong) ContentListPresenter *presenter;

@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockRouter;
@property (nonatomic, strong) id mockView;
@property (nonatomic, strong) id mockStatesStorage;

@end

@implementation ContentListPresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[ContentListPresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(ContentListInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(ContentListRouterInput));
    self.mockView = OCMProtocolMock(@protocol(ContentListViewInput));
    self.mockStatesStorage = OCMClassMock([StatesStorage class]);

    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
    self.presenter.view = self.mockView;
    self.presenter.statesStorage = self.mockStatesStorage;
}

- (void)tearDown {
    self.presenter = nil;

    self.mockView = nil;
    self.mockRouter = nil;
    self.mockInteractor = nil;
    self.mockStatesStorage = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов ContentListViewOutput

- (void)testThatPresenterHandlesViewReadyEvent {
    // given
    NSArray *states = @[@1,@2];
    id state = [NSObject new];
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    OCMStub([self.mockStatesStorage states]).andReturn(states);
    
    // when
    [self.presenter didTriggerViewReadyEvent];

    // then
    OCMVerify([self.mockView configureWithStates:states]);
    OCMVerify([self.mockView updateViewWithState:state]);
}

- (void)testThatPresenterHandlesChangingState {
    // given
    id state = [NSObject new];
    CGPoint offset = CGPointMake(100, 100);
    OCMStub([self.mockView obtainCurrentOffsetTableView]).andReturn(offset);
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    ContentType type = 1;
    
    // when
    [self.presenter didTriggerChangeStateToType:type];
    
    // then
    OCMVerify([self.mockStatesStorage updateCurrentStateWithContentOffset:offset]);
    OCMVerify([self.mockStatesStorage setCurrentStateWithType:type]);
    OCMVerify([self.mockView updateViewWithState:state]);
}

- (void)testThatPresenterHandlesSearchTerm {
    // given
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(@"another");
    NSString *term = @"term";
    
    // when
    [self.presenter didTriggerClickSearchWithTerm:term];
    
    // then
    OCMVerify([self.mockStatesStorage setLastSearchTerm:term]);
    OCMVerify([self.mockInteractor updateContentListWithType:ContentAppleType
                                                  searchTerm:term]);
    OCMVerify([self.mockInteractor updateContentListWithType:ContentGitHubType
                                                  searchTerm:term]);
}

- (void)testThatPresenterHandlesRepeatSearchTerm {
    // given
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(@"term");
    NSString *term = @"term";
    [[self.mockStatesStorage reject] setLastSearchTerm:OCMOCK_ANY];
    [[self.mockInteractor reject] updateContentListWithType:ContentAppleType
                                                 searchTerm:OCMOCK_ANY];
    [[self.mockInteractor reject] updateContentListWithType:ContentGitHubType
                                                 searchTerm:OCMOCK_ANY];
    // when
    [self.presenter didTriggerClickSearchWithTerm:term];
    
    // then
    OCMVerifyAll(self.mockInteractor);
    OCMVerifyAll(self.mockStatesStorage);
}

- (void)testThatPresenterHandlesEmptyTerm {
    // given
    NSString *term = nil;
    [[self.mockStatesStorage reject] setLastSearchTerm:OCMOCK_ANY];
    [[self.mockInteractor reject] updateContentListWithType:ContentAppleType
                                                 searchTerm:OCMOCK_ANY];
    [[self.mockInteractor reject] updateContentListWithType:ContentGitHubType
                                                 searchTerm:OCMOCK_ANY];
    // when
    [self.presenter didTriggerClickSearchWithTerm:term];
    
    // then
    OCMVerifyAll(self.mockInteractor);
    OCMVerifyAll(self.mockStatesStorage);
}

#pragma mark - Тестирование методов ContentListInteractorOutput

- (void)testThatPresentUpdatesContentSuccessfully {
    // given
    ContentType type = ContentAppleType;
    NSArray *objects = @[@1, @3];
    NSString *searchTerm = @"term";
    ContentListState *state = [ContentListState new];
    state.type = type;
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(searchTerm);
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    [[self.mockRouter reject] showAlertWithTitle:OCMOCK_ANY
                                         message:OCMOCK_ANY];
    
    // when
    [self.presenter didUpdateContentListSuccessfullyWithType:type
                                                plainObjects:objects
                                                  searchTerm:searchTerm];
    
    // then
    OCMVerify([self.mockStatesStorage updateStateWithType:type
                                               andObjects:objects]);
    OCMVerifyAll(self.mockRouter);
    OCMVerify([self.mockView updateViewWithState:state]);
}

- (void)testThatPresentUpdatesContentSuccessfullyWithEmptyObjects {
    // given
    ContentType type = ContentAppleType;
    NSArray *objects = @[];
    NSString *searchTerm = @"term";
    ContentListState *state = [ContentListState new];
    state.type = type;
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(searchTerm);
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    
    // when
    [self.presenter didUpdateContentListSuccessfullyWithType:type
                                                plainObjects:objects
                                                  searchTerm:searchTerm];
    
    // then
    OCMVerify([self.mockStatesStorage updateStateWithType:type
                                        andObjects:objects]);
    OCMVerify([self.mockRouter showAlertWithTitle:OCMOCK_ANY
                                                 message:OCMOCK_ANY]);
    OCMVerify([self.mockView updateViewWithState:state]);
}

- (void)testThatPresentNotNeedUpdateContentWitnIncorrectType {
    // given
    ContentType type = ContentAppleType;
    NSArray *objects = @[@1, @3];
    NSString *searchTerm = @"term";
    ContentListState *state = [ContentListState new];
    state.type = ContentGitHubType;
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(searchTerm);
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    [[self.mockRouter reject] showAlertWithTitle:OCMOCK_ANY
                                         message:OCMOCK_ANY];
    [[self.mockView reject] updateViewWithState:OCMOCK_ANY];
    
    // when
    [self.presenter didUpdateContentListSuccessfullyWithType:type
                                                plainObjects:objects
                                                  searchTerm:searchTerm];
    
    // then
    OCMVerify([self.mockStatesStorage updateStateWithType:type
                                               andObjects:objects]);
    OCMVerifyAll(self.mockRouter);
    OCMVerifyAll(self.mockView);
}

- (void)testThatPresentNotNeedUpdateContentWitnIncorrectLastTerm {
    // given
    ContentType type = ContentAppleType;
    NSArray *objects = @[@1, @3];
    NSString *searchTerm = @"term";
    ContentListState *state = [ContentListState new];
    state.type = ContentAppleType;
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(@"incorrect");
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    [[self.mockRouter reject] showAlertWithTitle:OCMOCK_ANY
                                         message:OCMOCK_ANY];
    [[self.mockView reject] updateViewWithState:OCMOCK_ANY];
    
    // when
    [self.presenter didUpdateContentListSuccessfullyWithType:type
                                                plainObjects:objects
                                                  searchTerm:searchTerm];
    
    // then
    OCMVerify([self.mockStatesStorage updateStateWithType:type
                                               andObjects:objects]);
    OCMVerifyAll(self.mockRouter);
    OCMVerifyAll(self.mockView);
}

- (void)testThatPresentUpdatesContentFromInteractorWithError {
    // given
    ContentType type = ContentAppleType;
    NSArray *objects = @[];
    NSString *searchTerm = @"term";
    id error = OCMClassMock([NSError class]);
    OCMStub([error localizedDescription]).andReturn(@"desc");
    ContentListState *state = [ContentListState new];
    state.type = ContentAppleType;
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(searchTerm);
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    
    // when
    [self.presenter didUpdateContentListWithError:error
                                             type:type
                                       searchTerm:searchTerm];
    
    // then
    OCMVerify([self.mockStatesStorage updateStateWithType:type
                                               andObjects:objects]);
    OCMVerify([self.mockRouter showAlertWithTitle:OCMOCK_ANY
                                          message:OCMOCK_ANY]);

}

- (void)testThatPresentNotNeedHandleErrorWithIncorrectType {
    // given
    ContentType type = ContentAppleType;
    NSArray *objects = @[];
    NSString *searchTerm = @"term";
    id error = [NSObject new];
    ContentListState *state = [ContentListState new];
    state.type = ContentGitHubType;
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(searchTerm);
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    [[self.mockRouter reject] showAlertWithTitle:OCMOCK_ANY
                                         message:OCMOCK_ANY];
    
    // when
    [self.presenter didUpdateContentListWithError:error
                                             type:type
                                       searchTerm:searchTerm];
    
    // then
    OCMVerify([self.mockStatesStorage updateStateWithType:type
                                               andObjects:objects]);
    OCMVerifyAll(self.mockRouter);
}

- (void)testThatPresentNotNeedHandleErrorWithIncorrectSearchTerm {
    // given
    ContentType type = ContentAppleType;
    NSArray *objects = @[];
    NSString *searchTerm = @"term";
    id error = [NSObject new];
    ContentListState *state = [ContentListState new];
    state.type = ContentAppleType;
    OCMStub([self.mockStatesStorage lastSearchTerm]).andReturn(@"incorrect");
    OCMStub([self.mockStatesStorage currentState]).andReturn(state);
    [[self.mockRouter reject] showAlertWithTitle:OCMOCK_ANY
                                         message:OCMOCK_ANY];
    
    // when
    [self.presenter didUpdateContentListWithError:error
                                             type:type
                                       searchTerm:searchTerm];
    
    // then
    OCMVerify([self.mockStatesStorage updateStateWithType:type
                                               andObjects:objects]);
    OCMVerifyAll(self.mockRouter);
}

@end
