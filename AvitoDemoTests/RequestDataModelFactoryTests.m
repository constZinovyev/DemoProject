//
//  RequestDataModelFactoryTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "RequestDataModelFactory.h"
#import "RequestDataModel.h"

@interface RequestDataModelFactoryTests : XCTestCase

@property (nonatomic, strong) RequestDataModelFactory *factory;

@end

@implementation RequestDataModelFactoryTests

- (void)setUp {
    [super setUp];
    
    self.factory = [[RequestDataModelFactory alloc] init];
}

- (void)tearDown {
    self.factory = nil;
    
    [super tearDown];
}

- (void)testThatFactoryCreatesGitHubRequestCorrectly {
    // given
    NSString *searchTerm = @"asd";
    NSString *expectedString = @"https://api.github.com/search/users";
    ContentType type = ContentGitHubType;
    
    // when
    RequestDataModel *model = [self.factory requestDataModelForContentType:type
                                                                searchTerm:searchTerm];
    // then
    XCTAssertEqualObjects(model.searchURL, expectedString);
    XCTAssertEqual(model.queryParameters[@"q"],searchTerm);
    XCTAssertNotNil(model.queryParameters[@"per_page"]);
}

- (void)testThatFactoryCreatesAppleRequestCorrectly {
    // given
    NSString *searchTerm = @"asd";
    NSString *expectedString = @"https://itunes.apple.com/search";
    ContentType type = ContentAppleType;
    
    // when
    RequestDataModel *model = [self.factory requestDataModelForContentType:type
                                                                searchTerm:searchTerm];
    // then
    XCTAssertEqualObjects(model.searchURL, expectedString);
    XCTAssertEqual(model.queryParameters[@"term"],searchTerm);
    XCTAssertNotNil(model.queryParameters[@"limit"]);
}

- (void)testThatFactoryCreatesRequestWithIncorrectType {
    // given
    
    // when
    RequestDataModel *model = [self.factory requestDataModelForContentType:3
                                                                searchTerm:@""];
    // then
    XCTAssertNil(model);
}

- (void)testThatFactoryCreatesRequestWithNilTerm {
    // given
    ContentType type = ContentAppleType;

    // when
    RequestDataModel *model = [self.factory requestDataModelForContentType:type
                                                                searchTerm:nil];
    // then
    XCTAssertNil(model);
}

@end
