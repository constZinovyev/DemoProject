//
//  ContentListAssembly.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ServicesAssembly;

/**
 @author Konstantin Zinovyev

 Фабрика собирающая VIPER модуль
 */
@interface ContentListAssembly : NSObject

/**
 @author Konstantin Zinovyev
 
 Метод создает модуль со всеми зависимостями
 */
- (UIViewController *)configureModuleWithServicesFactory:(ServicesAssembly *)servicesFactory;

@end
