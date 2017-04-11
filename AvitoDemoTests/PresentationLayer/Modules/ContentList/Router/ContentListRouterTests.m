//
//  ContentListRouterTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import <OCMock/OCMock.h>

#import "ContentListRouter.h"

@interface ContentListRouterTests : XCTestCase

@property (nonatomic, strong) ContentListRouter *router;
@property (nonatomic, strong) id mockTransitionHandler;

@end

@implementation ContentListRouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[ContentListRouter alloc] init];
    self.mockTransitionHandler = OCMClassMock([UIViewController class]);
    
    self.router.transitionHandler = self.mockTransitionHandler;
}

- (void)tearDown {
    self.router = nil;
    self.mockTransitionHandler = nil;

    [super tearDown];
}

- (void)testThatRouterShowsAlertCorrectly {
    // given
    NSString *title = @"title";
    NSString *message = @"message";
    id alert = [UIAlertController new];
    id mockAlertController = OCMClassMock([UIAlertController class]);
    
    OCMStub([mockAlertController alertControllerWithTitle:title
                                              message:message
                                       preferredStyle:UIAlertControllerStyleAlert]).andReturn(alert);
    
    // when
    [self.router showAlertWithTitle:title
                            message:message];
    
    // then
    OCMVerify([self.mockTransitionHandler presentViewController:alert
                                                       animated:YES
                                                     completion:nil]);
}

@end
