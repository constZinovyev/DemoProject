//
//  ContentCellObject.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ContentCellObject.h"

@interface ContentCellObject ()

@property (nonatomic, strong) NSString *cellIdentifier;

@end

@implementation ContentCellObject

- (instancetype)initWithTitle:(NSString *)title
                     subtitle:(NSString *)subtitle
                     imageURL:(NSString *)imageURL
                   identifier:(NSString *)identifier {
    self = [super init];
    
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _imageURL = imageURL;
        _cellIdentifier = identifier;
    }
    
    return self;
}

+ (instancetype)cellObjectWithTitle:(NSString *)title
                           subtitle:(NSString *)subtitle
                           imageURL:(NSString *)imageURL
                         identifier:(NSString *)identifier {
    return [[self alloc] initWithTitle:title
                              subtitle:subtitle
                              imageURL:imageURL
                            identifier:identifier];
}

@end
