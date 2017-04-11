//
//  ContentListState.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ContentListState.h"

@implementation ContentListState

- (instancetype)initWithTitle:(NSString *)title
                         type:(ContentType)type {
    self = [super init];
    
    if (self) {
        _title = title;
        _type = type;
        _contentOffset = CGPointZero;
    }
    
    return self;
}

@end
