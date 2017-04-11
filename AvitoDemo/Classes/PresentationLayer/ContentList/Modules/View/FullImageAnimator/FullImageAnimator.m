//
//  FullImageAnimator.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "FullImageAnimator.h"

static const CGFloat kAnimationDuration = 0.3f;
static const CGFloat kBackgroundAlpha = 0.4f;
@interface FullImageAnimator ()

@property (nonatomic, assign) CGRect collapseFrameImageView;

@end

@implementation FullImageAnimator

- (void)showFullImageFromImageView:(UIImageView *)imageView {
    if (imageView.image == nil) {
        return;
    }
    self.imageContainerView.hidden = NO;
    CGRect imageFrame = [self.imageContainerView convertRect:imageView.frame
                                                    fromView:imageView.superview];
    self.collapseFrameImageView = imageFrame;
    self.imageView.image = imageView.image;
    [self.imageView setFrame:imageFrame];
    [UIView animateWithDuration:kAnimationDuration animations:^{
       self.imageContainerView.backgroundColor = [UIColor colorWithRed:0
                                                                 green:0
                                                                  blue:0
                                                                 alpha:kBackgroundAlpha];
       [self.imageView setFrame:self.imageContainerView.frame];
    }];
}

- (IBAction)didTapFullImageView {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.imageView setFrame:self.collapseFrameImageView];
        self.imageContainerView.backgroundColor = [UIColor colorWithRed:0
                                                                  green:0
                                                                   blue:0
                                                                  alpha:0];
    } completion:^(BOOL finished) {
        self.imageView.image = nil;
        self.imageContainerView.hidden = YES;
    }];
}

@end
