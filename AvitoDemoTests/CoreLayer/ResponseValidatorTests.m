//
//  ResponseValidatorTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ResponseValidatorImplementation.h"
#import "MappingDataModel.h"

@interface ResponseValidatorTests : XCTestCase

@property (nonatomic, strong) id<ResponseValidator> validator;

@end

@implementation ResponseValidatorTests

- (void)setUp {
    [super setUp];
    
    self.validator = [[ResponseValidatorImplementation alloc] init];
}

- (void)tearDown {
    self.validator = nil;
    
    [super tearDown];
}

- (void)testThanValidatorHandleResponseCorrectly {
    // given
    MappingDataModel *model = [MappingDataModel new];
    model.resultKey = @"result";
    NSString *titleKey = @"login";
    NSString *subtitleKey = @"password";
    model.attributeMapping = @{
                             @"1" : titleKey,
                             @"2" : subtitleKey,
                             };
    NSArray *items = @[
                       @{
                           titleKey : @"asd",
                           subtitleKey : @"123"
                        },
                       @{
                           titleKey : @"asd",
                       },
                       @{
                           subtitleKey : @"123"
                       },
                       @{
                           titleKey : @"asd",
                           subtitleKey : @"123",
                           @"extraKey" : @"extra"
                       },
                       @{
                           titleKey : @"asd",
                           subtitleKey : @"123"
                       },
                       @{}
                           ];
    id response = @{
                    model.resultKey : items
                    };
    
    // when
    id error = [self.validator validateResponse:response
                               mappingDataModel:model];
    
    // then
    XCTAssertNil(error);
}

- (void)testThanValidatorHandleIncorrectResponseDataClass {
    // given
    MappingDataModel *model = [MappingDataModel new];
    model.resultKey = @"result";
    NSString *titleKey = @"login";
    NSString *subtitleKey = @"password";
    model.attributeMapping = @{
                               @"1" : titleKey,
                               @"2" : subtitleKey,
                               };
    NSArray *items = @[
                       @{
                           titleKey : @"asd",
                           subtitleKey : @(123)
                           }
                       ];
    id response = @{
                    model.resultKey : items
                    };
    
    // when
    id error = [self.validator validateResponse:response
                               mappingDataModel:model];
    
    // then
    XCTAssertNotNil(error);
}

- (void)testThanValidatorHandleNilResponse {
    // given
    id model = [NSObject new];
    
    // when
    id error = [self.validator validateResponse:nil
                               mappingDataModel:model];
    
    // then
    XCTAssertNotNil(error);
}

- (void)testThanValidatorHandleNilModel {
    // given
    id response = [NSDictionary new];
    
    // when
    id error = [self.validator validateResponse:response
                               mappingDataModel:nil];
    
    // then
    XCTAssertNotNil(error);
}

- (void)testThanValidatorHandleNilResponseAndNilModel {
    // given
    
    // when
    id error = [self.validator validateResponse:nil
                               mappingDataModel:nil];
    
    // then
    XCTAssertNotNil(error);
}

- (void)testThanValidatorHandleIncorrectResponseClass {
    // given
    id model = [NSObject new];
    id response = [NSObject new];
    
    // when
    id error = [self.validator validateResponse:response
                               mappingDataModel:model];
    
    // then
    XCTAssertNotNil(error);
}

- (void)testThanValidatorHandleIncorrectResultKey {
    // given
    MappingDataModel *model = [MappingDataModel new];
    model.resultKey = @"results";
    id response = @{
                    @"result" : @[]
                    };
    
    // when
    id error = [self.validator validateResponse:response
                               mappingDataModel:model];
    
    // then
    XCTAssertNotNil(error);
}

- (void)testThanValidatorHandleIncorrectResultType {
    // given
    MappingDataModel *model = [MappingDataModel new];
    model.resultKey = @"result";
    id response = @{
                    model.resultKey : @{}
                    };
    
    // when
    id error = [self.validator validateResponse:response
                               mappingDataModel:model];
    
    // then
    XCTAssertNotNil(error);
}



@end
