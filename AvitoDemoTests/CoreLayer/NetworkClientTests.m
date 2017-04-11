//
//  NetworkClientTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "NetworkClientImplementation.h"

typedef void (^ProxyBlock)(NSInvocation *);
typedef void (^NetworkClientBlock)(NSData *data, NSURLResponse *response, NSError *error);
static NSTimeInterval const kTestExpectationTimeout = 1.0f;

@interface NetworkClientTests : XCTestCase

@property (nonatomic, strong) id<NetworkClient> client;

@end

@implementation NetworkClientTests

- (void)setUp {
    [super setUp];
    
    self.client = [[NetworkClientImplementation alloc] init];
}

- (void)tearDown {
    self.client = nil;
    
    [super tearDown];
}

- (void)testThatClientHandlesRequestCorrectly {
    // given
    XCTestExpectation *expectation = [self expectationWithDescription:@"network client expectation"];
    id expectedData = [NSObject new];
    id expectedError = [NSObject new];
    id request = OCMClassMock([NSURLRequest class]);
    id config = OCMClassMock([NSURLSessionConfiguration class]);
    id session = OCMClassMock([NSURLSession class]);
    OCMStub([config defaultSessionConfiguration]).andReturn(config);
    OCMStub([session sessionWithConfiguration:config]).andReturn(session);
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        NetworkClientBlock block;
        [invocation getArgument:&block atIndex:3];
        
        block(expectedData, nil, expectedError);
    };
    OCMStub([session dataTaskWithRequest:request
                       completionHandler:OCMOCK_ANY]).andDo(proxyBlock);
    __block id resultData;
    __block id resultError;
    // when
    [self.client sendRequest:request competionBlock:^(NSData *data, NSError *error) {
        resultError = error;
        resultData = data;
        [expectation fulfill];
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        
        XCTAssertEqual(expectedData, resultData);
        XCTAssertEqual(expectedError, resultError);
    }];
}

- (void)testThatClientHandlesWithNilRequest {
    // given
    XCTestExpectation *expectation = [self expectationWithDescription:@"network client expectation"];
    id config = OCMClassMock([NSURLSessionConfiguration class]);
    id session = OCMClassMock([NSURLSession class]);
    [[config reject] defaultSessionConfiguration];
    [[session reject] sessionWithConfiguration:config];
    [[session reject] dataTaskWithRequest:OCMOCK_ANY
                        completionHandler:OCMOCK_ANY];
    __block id resultData;
    __block id resultError;
    
    // when
    [self.client sendRequest:nil competionBlock:^(NSData *data, NSError *error) {
        resultError = error;
        resultData = data;
        [expectation fulfill];
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        
        XCTAssertNil(resultData);
        XCTAssertNotNil(resultError);
        OCMVerifyAll(config);
        OCMVerifyAll(session);
    }];
}

@end
