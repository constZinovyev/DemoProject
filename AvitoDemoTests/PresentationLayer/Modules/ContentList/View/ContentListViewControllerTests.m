//
//  ContentListViewControllerTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ContentListViewController.h"

#import "ContentListViewOutput.h"

@interface ContentListViewControllerTests : XCTestCase

@property (nonatomic, strong) ContentListViewController *controller;

@property (nonatomic, strong) id mockOutput;

@end

@implementation ContentListViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[ContentListViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(ContentListViewOutput));

    self.controller.output = self.mockOutput;
}

- (void)tearDown {
    self.controller = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование жизненного цикла

- (void)testThatControllerNotifiesPresenterOnDidLoad {
	// given

	// when
	[self.controller viewDidLoad];

	// then
	OCMVerify([self.mockOutput didTriggerViewReadyEvent]);
}

#pragma mark - Тестирование методов интерфейса

#pragma mark - Тестирование методов ContentListViewInput

@end
