//
//  ResponseMapperTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ResponseMapperImplementation.h"
#import "MappingDataModel.h"
#import "UserPlainObject.h"

@interface ResponseMapperTests : XCTestCase

@property (nonatomic, strong) id<ResponseMapper> mapper;

@end

@implementation ResponseMapperTests

- (void)setUp {
    [super setUp];
    
    self.mapper = [[ResponseMapperImplementation alloc] init];
}

- (void)tearDown {
    self.mapper = nil;
    
    [super tearDown];
}

- (void)testThatMapperHandlesResponseWithModelCorrectly {
    // given
    NSString *resultKey = @"results";
    NSString *titleKey = @"login";
    NSString *subtitleKey = @"password";
    NSUInteger type = 1;
    NSArray *items = @[
                       @{
                           titleKey : @"asd",
                           subtitleKey : @"123",
                           
                        },
                       @{
                           titleKey : @"kunf",
                           subtitleKey : @"lokj",
                           },
                       @{
                           titleKey : @"asd"
                           }
                       
                       ];
    NSDictionary *dict = @{resultKey : items};
    MappingDataModel *model = [[MappingDataModel alloc] init];
    model.resultKey = resultKey;
    model.attributeMapping = @{
                               NSStringFromSelector(@selector(title)) : titleKey,
                               NSStringFromSelector(@selector(subtitle)) : subtitleKey
                               };
    model.objectType = type;
    
    // when
    NSArray *result = [self.mapper mapResponse:dict
                              mappingDataModel:model];
    
    // then
    XCTAssertEqual(result.count, items.count);
    [result enumerateObjectsUsingBlock:^(UserPlainObject *plain, NSUInteger index, BOOL *stop) {
        XCTAssertEqualObjects(plain.title, items[index][titleKey]);
        XCTAssertEqualObjects(plain.subtitle, items[index][subtitleKey]);
        XCTAssertEqualObjects(plain.type, @(type));
    }];
}


- (void)testThatMapperHandlesNilResponse {
    // given
    id model = [NSObject new];
    
    // when
    NSArray *result = [self.mapper mapResponse:nil
                              mappingDataModel:model];
    
    // then
    XCTAssertNil(result);
}

- (void)testThatMapperHandlesNilModel {
    // given
    id response = [NSObject new];
    
    // when
    NSArray *result = [self.mapper mapResponse:response
                              mappingDataModel:nil];
    
    // then
    XCTAssertNil(result);
}

- (void)testThatMapperHandlesNilModelAndNilResponse {
    // given
    
    // when
    NSArray *result = [self.mapper mapResponse:nil
                              mappingDataModel:nil];
    
    // then
    XCTAssertNil(result);
}

@end
