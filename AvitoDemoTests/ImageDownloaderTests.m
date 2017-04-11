//
//  ImageDownloaderTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ImageDownloader.h"

typedef void (^ProxyBlock)(NSInvocation *);
typedef void (^SessionBlock)(NSData *data, NSURLResponse *response, NSError *error);
static NSTimeInterval const kTestExpectationTimeout = 1.0f;

@interface ImageDownloader ()

@property (nonatomic, strong) NSURLSession *session;

@end

@interface ImageDownloaderTests : XCTestCase

@property (nonatomic, strong) ImageDownloader *dowloander;

@end

@implementation ImageDownloaderTests

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {

    [super tearDown];
}

- (void)testThatDownloadObtainImageCorrectly {
    // given
    XCTestExpectation *expectation = [self expectationWithDescription:@"image downloader expectation"];
    ImageDownloader *downloader = [[ImageDownloader alloc] init];
    downloader.session = OCMClassMock([NSURLSession class]);
    NSString *imageURL = @"http://git.ru";
    id data = [NSObject new];
    id image = [NSObject new];
    id mockUIImage = OCMClassMock([UIImage class]);
    OCMStub([mockUIImage imageWithData:data]).andReturn(image);
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        SessionBlock block;
        [invocation getArgument:&block atIndex:3];
        
        block(data, nil, nil);
    };
    OCMStub([downloader.session dataTaskWithRequest:OCMOCK_ANY
                                  completionHandler:OCMOCK_ANY]).andDo(proxyBlock);
    __block id resultImage;
    __block id resultError;
    // when
    [downloader downloadImageWithURL:imageURL
                      competionBlock:^(UIImage *image, NSError *error) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              resultImage = image;
                              resultError = error;
                              [expectation fulfill];
                          });
                      }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        
        XCTAssertEqual(resultImage, image);
        XCTAssertNil(resultError);
    }];
    
}

- (void)testThatDownloadObtainImageWithError {
    // given
    XCTestExpectation *expectation = [self expectationWithDescription:@"image downloader expectation"];
    ImageDownloader *downloader = [[ImageDownloader alloc] init];
    downloader.session = OCMClassMock([NSURLSession class]);
    NSString *imageURL = @"http://git.ru";
    id expectredError = [NSObject new];
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        SessionBlock block;
        [invocation getArgument:&block atIndex:3];
        
        block(nil, nil, expectredError);
    };
    OCMStub([downloader.session dataTaskWithRequest:OCMOCK_ANY
                                  completionHandler:OCMOCK_ANY]).andDo(proxyBlock);
    __block id resultImage;
    __block id resultError;
    // when
    [downloader downloadImageWithURL:imageURL
                      competionBlock:^(UIImage *image, NSError *error) {
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              resultImage = image;
                              resultError = error;
                              [expectation fulfill];
                          });
                      }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        
        XCTAssertEqual(resultError, expectredError);
        XCTAssertNil(resultImage);
    }];
}

@end
