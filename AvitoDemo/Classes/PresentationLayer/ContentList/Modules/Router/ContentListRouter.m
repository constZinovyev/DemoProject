//
//  ContentListRouter.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListRouter.h"

static NSString *const kErrorTitleButton = @"Ок";

@implementation ContentListRouter

#pragma mark - Методы ContentListRouterInput

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:kErrorTitleButton
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alert addAction:action];
    [self.transitionHandler presentViewController:alert
                                         animated:YES
                                       completion:nil];
}

@end
