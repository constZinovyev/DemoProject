//
//  ContentServiceTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ContentServiceImplementation.h"

#import "RequestConfigurator.h"
#import "NetworkClient.h"
#import "ResponseDeserialization.h"
#import "ResponseValidator.h"
#import "ResponseMapper.h"

#import "MappingDataModelFactory.h"
#import "RequestDataModelFactory.h"
#import "RequestDataModel.h"
#import "MappingDataModel.h"

static NSTimeInterval const kTestExpectationTimeout = 1.0f;
typedef void (^ProxyBlock)(NSInvocation *);

@interface ContentServiceTests : XCTestCase

@property (nonatomic, strong) ContentServiceImplementation *service;

@property (nonatomic, strong) id mockRequestConfigurator;
@property (nonatomic, strong) id mockNetworkClient;
@property (nonatomic, strong) id mockResponseDeserialization;
@property (nonatomic, strong) id mockResponseValidator;
@property (nonatomic, strong) id mockResponseMapper;

@property (nonatomic, strong) id mockRequestModelFactory;
@property (nonatomic, strong) id mockMappingModelFactory;

@end

@implementation ContentServiceTests

- (void)setUp {
    [super setUp];
    
    self.service = [[ContentServiceImplementation alloc] init];
    self.mockRequestConfigurator = OCMProtocolMock(@protocol(RequestConfigurator));
    self.mockNetworkClient = OCMProtocolMock(@protocol(NetworkClient));
    self.mockResponseDeserialization = OCMProtocolMock(@protocol(ResponseDeserialization));
    self.mockResponseValidator = OCMProtocolMock(@protocol(ResponseValidator));
    self.mockResponseMapper = OCMProtocolMock(@protocol(ResponseMapper));
    
    self.mockRequestModelFactory = OCMClassMock([RequestDataModelFactory class]);
    self.mockMappingModelFactory = OCMClassMock([MappingDataModelFactory class]);
    
    self.service.requestConfigurator = self.mockRequestConfigurator;
    self.service.networkClient = self.mockNetworkClient;
    self.service.responseDeserialization = self.mockResponseDeserialization;
    self.service.responseValidator = self.mockResponseValidator;
    self.service.responseMapper = self.mockResponseMapper;
    self.service.requestModelFactory = self.mockRequestModelFactory;
    self.service.mappingModelFactory = self.mockMappingModelFactory;
    
}

- (void)tearDown {
    self.service = nil;
    self.mockRequestConfigurator = nil;
    self.mockNetworkClient = nil;
    self.mockResponseDeserialization = nil;
    self.mockResponseValidator = nil;
    self.mockResponseMapper = nil;
    
    self.mockRequestModelFactory = nil;
    self.mockMappingModelFactory = nil;
    
    [super tearDown];
}

- (void)testThatCerviceLoadContentCorrectly {
    // given
    XCTestExpectation *expectation = [self expectationWithDescription:@"serviice expectation"];
    NSString *term = @"term";
    NSData *resultData = [NSData new];
    NSArray *epxectedObjects = @[@1,@3,@5,@7,@9];
    __block NSArray *resultObjects;
    __block NSError *resultError;
    ContentType type = 1;
    [self stubNetworkClientWithData:resultData
                              error:nil
                               type:type
                         searchTerm:term];
    
    id mappingModel = [NSObject new];
    id response = [NSObject new];
    OCMStub([self.mockMappingModelFactory mappingDataModelForContentType:type]).andReturn(mappingModel);
    OCMStub([self.mockResponseDeserialization deserializeServerResponse:resultData]).andReturn(response);
    OCMStub([self.mockResponseValidator validateResponse:response
                                        mappingDataModel:mappingModel]).andReturn(nil);
    OCMStub([self.mockResponseMapper mapResponse:response
                                mappingDataModel:mappingModel]).andReturn(epxectedObjects);

    
    // when
    [self.service loadContentWithType:type
                           searchTerm:term
                       competionBlock:^(NSArray *objects, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           resultObjects = objects;
           resultError = error;
           [expectation fulfill];
       });
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError *error) {
        XCTAssertEqualObjects(resultObjects, epxectedObjects);
        XCTAssertNil(resultError);
    }];
}

- (void)testThatCerviceLoadContentWithError {
    // given
    XCTestExpectation *expectation = [self expectationWithDescription:@"serviice expectation"];
    NSString *term = @"";
    id expectedError = [NSObject new];
    __block NSArray *resultObjects;
    __block NSError *resultError;
    ContentType type = 1;
    [self stubNetworkClientWithData:nil
                              error:expectedError
                               type:type
                         searchTerm:term];
    [[self.mockResponseDeserialization reject] deserializeServerResponse:OCMOCK_ANY];
    [[self.mockResponseValidator reject] validateResponse:OCMOCK_ANY
                                mappingDataModel:OCMOCK_ANY];
    [[self.mockResponseMapper reject] mapResponse:OCMOCK_ANY
                                 mappingDataModel:OCMOCK_ANY];
    
    // when
    [self.service loadContentWithType:type
                           searchTerm:term
                       competionBlock:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            resultObjects = objects;
            resultError = error;
            [expectation fulfill];
        });
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError *error) {
        OCMVerifyAll(self.mockResponseMapper);
        OCMVerifyAll(self.mockResponseValidator);
        OCMVerifyAll(self.mockResponseDeserialization);
        XCTAssertNil(resultObjects);
        XCTAssertNotNil(resultError);
    }];
}

- (void)testThatCerviceLoadContentWithValidationError {
    // given
    XCTestExpectation *expectation = [self expectationWithDescription:@"serviice expectation"];
    NSString *term = @"";
    __block NSArray *resultObjects;
    __block NSError *resultError;
    id resultData = [NSData new];
    id expectedError = [NSObject new];
    ContentType type = 1;
    [self stubNetworkClientWithData:resultData
                              error:nil
                               type:type
                         searchTerm:term];
    
    id mappingModel = [NSObject new];
    id response = [NSObject new];
    OCMStub([self.mockMappingModelFactory mappingDataModelForContentType:type]).andReturn(mappingModel);
    OCMStub([self.mockResponseDeserialization deserializeServerResponse:resultData]).andReturn(response);
    OCMStub([self.mockResponseValidator validateResponse:response
                                        mappingDataModel:mappingModel]).andReturn(expectedError);
    [[self.mockResponseMapper reject] mapResponse:OCMOCK_ANY mappingDataModel:OCMOCK_ANY];
    
    // when
    [self.service loadContentWithType:type
                           searchTerm:term
                       competionBlock:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            resultObjects = objects;
            resultError = error;
            [expectation fulfill];
        });
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError *error) {
        OCMVerifyAll(self.mockResponseMapper);
        XCTAssertNil(resultObjects);
        XCTAssertNotNil(resultError);
    }];
}

#pragma mark - Приватные методы

- (void)stubNetworkClientWithData:(NSData *)data
                            error:(NSError *)error
                             type:(ContentType)type
                       searchTerm:(NSString *)term {
    id requestmodel = [NSObject new];
    id request = [NSObject new];
    OCMStub([self.mockRequestModelFactory requestDataModelForContentType:type
                                                              searchTerm:term]).andReturn(requestmodel);
    OCMStub([self.mockRequestConfigurator obtainRequestWithDataModel:requestmodel]).andReturn(request);
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        NetworkClientResponseBlock block;
        [invocation getArgument:&block atIndex:3];
        
        block(data, error);
    };
    OCMStub([self.mockNetworkClient sendRequest:request
                                 competionBlock:OCMOCK_ANY]).andDo(proxyBlock);
}

@end
