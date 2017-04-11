//
//  ResponseDeserializationTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ResponseDeserializationImplementation.h"

@interface ResponseDeserializationTests : XCTestCase

@property (nonatomic, strong) id<ResponseDeserialization> deserialization;

@end

@implementation ResponseDeserializationTests

- (void)setUp {
    [super setUp];
    
    self.deserialization = [[ResponseDeserializationImplementation alloc] init];
}

- (void)tearDown {
    self.deserialization = nil;
    
    [super tearDown];
}

- (void)testThatDeserializationHandlesDataCorrectly {
    // given
    NSDictionary *expectedDictionary = @{
                                         @"key" : @"value"
                                         };
    NSData *data = [NSJSONSerialization dataWithJSONObject:expectedDictionary
                                                   options:0 error:nil];
    // when
    NSDictionary *result = [self.deserialization deserializeServerResponse:data];
    
    // then
    XCTAssertEqualObjects(expectedDictionary, result);
}

- (void)testThatDeserializationHandlesNilData {
    // given
    
    // when
    NSDictionary *result = [self.deserialization deserializeServerResponse:nil];
    
    // then
    XCTAssertNil(result);
}

@end
