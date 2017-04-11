//
//  ServicesAssembly.h
//  AvitoDemo
//
//  Created by k.zinovyev on 07.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol ContentService;

/**
 Фабрика сервисов
 */
@interface ServicesAssembly : NSObject

- (id<ContentService>)serviceGitHubSearch;
- (id<ContentService>)serviceAppleSearch;

@end
