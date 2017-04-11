//
//  RequestConfiguratorTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "RequestConfiguratorImplementation.h"
#import "RequestDataModel.h"

@interface RequestConfiguratorTests : XCTestCase

@property (nonatomic, strong) id<RequestConfigurator> configurator;

@end

@implementation RequestConfiguratorTests

- (void)setUp {
    [super setUp];
    
    self.configurator = [[RequestConfiguratorImplementation alloc] init];
}

- (void)tearDown {
    self.configurator = nil;
    
    [super tearDown];
}

- (void)testThatConfiguratorObtainRequestCorrectly {
    // given
    RequestDataModel *model = [[RequestDataModel alloc] init];
    model.searchURL = @"http://github.com/search";
    model.queryParameters = @{
                              @"key1":@"value1",
                              @"key2":@"value2"
                              };
    NSString *expectedString = @"http://github.com/search?key1=value1&key2=value2";
    // then
    NSURLRequest *request = [self.configurator obtainRequestWithDataModel:model];
    
    // when
    XCTAssertNotNil(request);
    XCTAssertNotNil(request.URL);
    NSLog(@"%@",request.URL.absoluteString);
    XCTAssertEqualObjects(request.URL.absoluteString, expectedString);
}

- (void)testThatConfiguratorObtainRequestFromNilModel {
    // given
    
    // then
    NSURLRequest *request = [self.configurator obtainRequestWithDataModel:nil];
    
    // when
    XCTAssertNil(request);
    
}

@end
