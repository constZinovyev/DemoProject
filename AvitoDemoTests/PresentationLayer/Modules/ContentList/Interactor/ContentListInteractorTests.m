//
//  ContentListInteractorTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ContentListInteractor.h"

#import "ContentListInteractorOutput.h"
#import "ContentService.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface ContentListInteractorTests : XCTestCase

@property (nonatomic, strong) ContentListInteractor *interactor;

@property (nonatomic, strong) id mockOutput;
@property (nonatomic, strong) id mockGitHubService;
@property (nonatomic, strong) id mockAppleService;

@end

@implementation ContentListInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[ContentListInteractor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(ContentListInteractorOutput));
    self.mockGitHubService = OCMProtocolMock(@protocol(ContentService));
    self.mockAppleService = OCMProtocolMock(@protocol(ContentService));
    
    self.interactor.output = self.mockOutput;
    self.interactor.contentGitHubService = self.mockGitHubService;
    self.interactor.contentAppleService = self.mockAppleService;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockGitHubService = nil;
    self.mockAppleService = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов ContentListInteractorInput

- (void)testThatInteractorUpdatesGitHubCorrectly {
    // given
    NSArray *objects = @[@1, @3, @5];
    ContentType type = ContentGitHubType;
    NSString *term = @"asd";
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        ContentServiceCompletionBlockWithError completionBlock;
        [invocation getArgument:&completionBlock atIndex:4];
        
        completionBlock(objects, nil);
    };
    OCMStub([self.mockGitHubService loadContentWithType:type
                                             searchTerm:term
                                         competionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    [[self.mockOutput reject] didUpdateContentListWithError:OCMOCK_ANY type:type searchTerm:OCMOCK_ANY];
    
    // when
    [self.interactor updateContentListWithType:type
                                    searchTerm:term];
    
    // then
    OCMVerify([self.mockOutput didUpdateContentListSuccessfullyWithType:type
                                                           plainObjects:objects
                                                             searchTerm:term]);
    OCMVerifyAll(self.mockOutput);
}

- (void)testThatInteractorUpdatesGitHubWithError {
    // given
    id error = [NSObject new];
    ContentType type = ContentGitHubType;
    NSString *term = @"asd";
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        ContentServiceCompletionBlockWithError completionBlock;
        [invocation getArgument:&completionBlock atIndex:4];
        
        completionBlock(nil, error);
    };
    OCMStub([self.mockGitHubService loadContentWithType:type
                                             searchTerm:term
                                         competionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    [[self.mockOutput reject] didUpdateContentListSuccessfullyWithType:type
                                                          plainObjects:OCMOCK_ANY
                                                            searchTerm:OCMOCK_ANY];
    
    // when
    [self.interactor updateContentListWithType:type
                                    searchTerm:term];
    
    // then
    OCMVerify([self.mockOutput didUpdateContentListWithError:error
                                                        type:type
                                                  searchTerm:term]);
    OCMVerifyAll(self.mockOutput);
}

- (void)testThatInteractorUpdatesAppleCorrectly {
    // given
    NSArray *objects = @[@1, @3, @5];
    ContentType type = ContentAppleType;
    NSString *term = @"asd";
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        ContentServiceCompletionBlockWithError completionBlock;
        [invocation getArgument:&completionBlock atIndex:4];
        
        completionBlock(objects, nil);
    };
    OCMStub([self.mockAppleService loadContentWithType:type
                                             searchTerm:term
                                         competionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    [[self.mockOutput reject] didUpdateContentListWithError:OCMOCK_ANY
                                                       type:type
                                                 searchTerm:OCMOCK_ANY];
    
    // when
    [self.interactor updateContentListWithType:type
                                    searchTerm:term];
    
    // then
    OCMVerify([self.mockOutput didUpdateContentListSuccessfullyWithType:type
                                                           plainObjects:objects
                                                             searchTerm:term]);
    OCMVerifyAll(self.mockOutput);
}

- (void)testThatInteractorUpdatesAppleWithError {
    // given
    id error = [NSObject new];
    ContentType type = ContentAppleType;
    NSString *term = @"asd";
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        ContentServiceCompletionBlockWithError completionBlock;
        [invocation getArgument:&completionBlock atIndex:4];
        
        completionBlock(nil, error);
    };
    OCMStub([self.mockAppleService loadContentWithType:type
                                             searchTerm:term
                                         competionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    [[self.mockOutput reject] didUpdateContentListSuccessfullyWithType:type
                                                          plainObjects:OCMOCK_ANY
                                                            searchTerm:OCMOCK_ANY];
    
    // when
    [self.interactor updateContentListWithType:type
                                    searchTerm:term];
    
    // then
    OCMVerify([self.mockOutput didUpdateContentListWithError:error
                                                        type:type
                                                  searchTerm:term]);
    OCMVerifyAll(self.mockOutput);
}


- (void)testThatInteractorUpdatesWithIncorrectType {
    // given
    [[[self.mockAppleService reject] ignoringNonObjectArgs] loadContentWithType:0 searchTerm:OCMOCK_ANY competionBlock:OCMOCK_ANY];
    [[[self.mockGitHubService reject] ignoringNonObjectArgs] loadContentWithType:0 searchTerm:OCMOCK_ANY competionBlock:OCMOCK_ANY];
    
    // when
    [self.interactor updateContentListWithType:3
                                    searchTerm:@""];
    
    // then
    OCMVerifyAll(self.mockAppleService);
    OCMVerifyAll(self.mockGitHubService);
}

@end
