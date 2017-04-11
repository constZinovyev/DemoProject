//
//  DownloadableImageTests.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "UIImageView+DownloadableImage.h"
#import "ImageDownloader.h"
#import "ContentCellObject.h"

typedef void (^ProxyBlock)(NSInvocation *);
typedef void (^SessionBlock)(NSData *data, NSURLResponse *response, NSError *error);

@interface DownloadableImageTests : XCTestCase

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DownloadableImageTests

- (void)setUp {
    [super setUp];
    
    self.imageView = [[UIImageView alloc] init];
}

- (void)tearDown {
    self.imageView = nil;
    
    [super tearDown];
}

- (void)testThatViewDoawnloadImageCorrectly {
    // given
    id mockDownloader = OCMClassMock([ImageDownloader class]);
    UIImage *image = [UIImage new];
    NSString *imageURL = @"url";
    id syncObject = OCMProtocolMock(@protocol(SyncObjectContainer));
    OCMStub([syncObject imageURL]).andReturn(imageURL);
    OCMStub([mockDownloader sharedInstance]).andReturn(mockDownloader);
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        ImageDownloadeCompletionBlock block;
        [invocation getArgument:&block atIndex:3];
        
        block(image, nil);
    };
    OCMStub([mockDownloader downloadImageWithURL:imageURL
                                  competionBlock:OCMOCK_ANY]).andDo(proxyBlock);

    // when
    [self.imageView ad_downloadWithSyncObject:syncObject];
    
    // then
    XCTAssertEqual(self.imageView.image, image);
}

- (void)testThatViewDoawnloadImageWithError {
    // given
    id mockDownloader = OCMClassMock([ImageDownloader class]);
    id error = [NSObject new];
    NSString *imageURL = @"url";
    id syncObject = OCMProtocolMock(@protocol(SyncObjectContainer));
    OCMStub([syncObject imageURL]).andReturn(imageURL);
    OCMStub([mockDownloader sharedInstance]).andReturn(mockDownloader);
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        ImageDownloadeCompletionBlock block;
        [invocation getArgument:&block atIndex:3];
        
        block(nil, error);
    };
    OCMStub([mockDownloader downloadImageWithURL:imageURL
                                  competionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    
    // when
    [self.imageView ad_downloadWithSyncObject:syncObject];
    
    // then
    XCTAssertNil(self.imageView.image);
}

- (void)testThatViewDoawnloadImageWithIncorrectNextSyncObject {
    // given
    id mockDownloader = OCMClassMock([ImageDownloader class]);
    UIImage *image = [UIImage new];
    NSString *imageURL = @"url";
    NSString *nextURL = @"nextUrl";
    id<SyncObjectContainer> syncObject = [ContentCellObject new];
    syncObject.imageURL = imageURL;
    OCMStub([mockDownloader sharedInstance]).andReturn(mockDownloader);
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        ImageDownloadeCompletionBlock block;
        [invocation getArgument:&block atIndex:3];
        syncObject.imageURL = nextURL;
        block(image, nil);
    };
    OCMStub([mockDownloader downloadImageWithURL:imageURL
                                  competionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    
    // when
    [self.imageView ad_downloadWithSyncObject:syncObject];
    
    // then
    XCTAssertNil(self.imageView.image);
}

@end
