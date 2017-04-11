//
//  ContentListRouterInput.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ContentListRouterInput <NSObject>

/**
 Метод показывает алерт с ошибкой
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message;

@end
