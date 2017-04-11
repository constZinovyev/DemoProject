//
//  ImageDownloader.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ImageDownloader.h"
#import <UIKit/UIKit.h>

@interface ImageDownloader ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ImageDownloader

+ (instancetype)sharedInstance {
    static ImageDownloader *sharedDownloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDownloader = [[self alloc] init];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        sharedDownloader.session = session;
        
    });
    return sharedDownloader;
}

- (void)downloadImageWithURL:(NSString *)imageURL competionBlock:(ImageDownloadeCompletionBlock)block {
    NSURL *url = [NSURL URLWithString:imageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (block) {
            UIImage *image = data == nil ? nil : [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                block(image, error);
            });
        }
    }];
    dataTask.priority = NSURLSessionTaskPriorityLow;
    [dataTask resume];
}

@end
