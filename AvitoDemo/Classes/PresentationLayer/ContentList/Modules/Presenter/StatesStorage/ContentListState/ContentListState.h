//
//  ContentListState.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ContentType.h"

/**
 Класс содержит в себе данные состояния необходимые для отображения
 */
@interface ContentListState : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, assign) ContentType type;
@property (nonatomic, assign) CGPoint contentOffset;

- (instancetype)initWithTitle:(NSString *)title
                         type:(ContentType)type;

@end
