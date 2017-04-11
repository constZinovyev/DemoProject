//
//  MappingDataModelFactoryTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MappingDataModelFactory.h"
#import "MappingDataModel.h"

@interface MappingDataModelFactoryTests : XCTestCase

@property (nonatomic, strong) MappingDataModelFactory *factory;

@end

@implementation MappingDataModelFactoryTests

- (void)setUp {
    [super setUp];
    
    self.factory = [[MappingDataModelFactory alloc] init];
}

- (void)tearDown {
    self.factory = nil;
    
    [super tearDown];
}

- (void)testThatFactoryCreatesGitHubMappingCorrectly {
    // given
    ContentType type = ContentGitHubType;
    NSDictionary *expectedAttributes = @{
                                         @"image" : @"avatar_url",
                                         @"title" : @"login",
                                         @"subtitle" : @"html_url"
                                         };
    
    // when
    MappingDataModel *model = [self.factory mappingDataModelForContentType:type];
    
    // then
    XCTAssertEqualObjects(model.resultKey, @"items");
    XCTAssertEqual(model.objectType, type);
    XCTAssertTrue([model.attributeMapping isEqualToDictionary:expectedAttributes]);
}

- (void)testThatFactoryCreatesAppleMappingCorrectly {
    // given
    ContentType type = ContentAppleType;
    NSDictionary *expectedAttributes = @{
                                         @"image" : @"artworkUrl60",
                                         @"title" : @"artistName",
                                         @"subtitle" : @"trackName"
                                         };
    
    // when
    MappingDataModel *model = [self.factory mappingDataModelForContentType:type];
    
    // then
    XCTAssertEqualObjects(model.resultKey, @"results");
    XCTAssertEqual(model.objectType, type);
    XCTAssertTrue([model.attributeMapping isEqualToDictionary:expectedAttributes]);
}

- (void)testThatFactoryCreatesMappingWithIncorrectType {
    // given
    
    // when
    MappingDataModel *model = [self.factory mappingDataModelForContentType:3];
    
    // then
    XCTAssertNil(model);
}

@end
