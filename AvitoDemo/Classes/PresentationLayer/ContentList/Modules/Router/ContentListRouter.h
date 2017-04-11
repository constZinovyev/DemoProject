//
//  ContentListRouter.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListRouterInput.h"

@interface ContentListRouter : NSObject <ContentListRouterInput>

@property (nonatomic, weak) UIViewController *transitionHandler;

@end
