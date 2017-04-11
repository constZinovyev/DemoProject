//
//  ContentCellActions.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentCellActions <NSObject>

/**
 Метод сообщает делегату о нажатии на конкретный imageView
 */
- (void)didTapOnImageView:(UIImageView *)imageView;

@end
