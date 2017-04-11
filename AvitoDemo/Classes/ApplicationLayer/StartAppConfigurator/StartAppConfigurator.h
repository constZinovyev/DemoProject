//
//  StartAppConfigurator.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartAppConfigurator <NSObject>

/**
 *  Начальная конфигурация всех дополнительных сервисов
 */
- (void)configureInitialSettingsWithWindow:(UIWindow *)window;

@end
