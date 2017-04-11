//
//  ContentCellObject.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellObject.h"
#import "ContentCellActions.h"
#import "SyncObjectContainer.h"

@interface ContentCellObject : NSObject <CellObject, SyncObjectContainer>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, weak) id<ContentCellActions> output;
@property (nonatomic, assign) BOOL isLeftAlign;

+ (instancetype)cellObjectWithTitle:(NSString *)title
                           subtitle:(NSString *)subtitle
                           imageURL:(NSString *)imageURL
                         identifier:(NSString *)identifier;

@end
