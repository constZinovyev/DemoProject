//
//  FullImageAnimator.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FullImageAnimator : NSObject

@property (nonatomic, weak) IBOutlet UIView *imageContainerView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

/**
 Инициирует анимацию отображения картинки во весь экран
 */
- (void)showFullImageFromImageView:(UIImageView *)imageView;

@end
