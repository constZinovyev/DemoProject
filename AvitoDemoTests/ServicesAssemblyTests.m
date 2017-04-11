//
//  ServicesAssemblyTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ServicesAssembly.h"
#import "ContentServiceImplementation.h"

#import "RequestConfiguratorImplementation.h"
#import "NetworkClientImplementation.h"
#import "ResponseDeserializationImplementation.h"
#import "ResponseValidatorImplementation.h"
#import "ResponseMapperImplementation.h"

#import "RequestDataModelFactory.h"
#import "MappingDataModelFactory.h"

@interface ServicesAssemblyTests : XCTestCase

@property (nonatomic, strong) ServicesAssembly *assembly;

@end

@implementation ServicesAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [[ServicesAssembly alloc] init];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesServiceGitHubCorrectly {
    // given
    
    // when
    ContentServiceImplementation *service = [self.assembly serviceGitHubSearch];
    
    // then
    XCTAssertNotNil(service.requestConfigurator);
    XCTAssertNotNil(service.responseDeserialization);
    XCTAssertNotNil(service.responseValidator);
    XCTAssertNotNil(service.responseMapper);
    XCTAssertNotNil(service.networkClient);
    XCTAssertNotNil(service.mappingModelFactory);
    XCTAssertNotNil(service.requestModelFactory);
    XCTAssertTrue([service.requestConfigurator isKindOfClass:[RequestConfiguratorImplementation class]]);
    XCTAssertTrue([service.responseDeserialization isKindOfClass:[ResponseDeserializationImplementation class]]);
    XCTAssertTrue([service.responseValidator isKindOfClass:[ResponseValidatorImplementation class]]);
    XCTAssertTrue([service.responseMapper isKindOfClass:[ResponseMapperImplementation class]]);
    XCTAssertTrue([service.networkClient isKindOfClass:[NetworkClientImplementation class]]);
    XCTAssertTrue([service.requestModelFactory isKindOfClass:[RequestDataModelFactory class]]);
    XCTAssertTrue([service.mappingModelFactory isKindOfClass:[MappingDataModelFactory class]]);
}

- (void)testThatAssemblyCreatesServiceAppleCorrectly {
    // given
    
    // when
    ContentServiceImplementation *service = [self.assembly serviceAppleSearch];
    
    // then
    XCTAssertNotNil(service.requestConfigurator);
    XCTAssertNotNil(service.responseDeserialization);
    XCTAssertNotNil(service.responseValidator);
    XCTAssertNotNil(service.responseMapper);
    XCTAssertNotNil(service.networkClient);
    XCTAssertNotNil(service.mappingModelFactory);
    XCTAssertNotNil(service.requestModelFactory);
    XCTAssertTrue([service.requestConfigurator isKindOfClass:[RequestConfiguratorImplementation class]]);
    XCTAssertTrue([service.responseDeserialization isKindOfClass:[ResponseDeserializationImplementation class]]);
    XCTAssertTrue([service.responseValidator isKindOfClass:[ResponseValidatorImplementation class]]);
    XCTAssertTrue([service.responseMapper isKindOfClass:[ResponseMapperImplementation class]]);
    XCTAssertTrue([service.networkClient isKindOfClass:[NetworkClientImplementation class]]);
    XCTAssertTrue([service.requestModelFactory isKindOfClass:[RequestDataModelFactory class]]);
    XCTAssertTrue([service.mappingModelFactory isKindOfClass:[MappingDataModelFactory class]]);
}

@end
