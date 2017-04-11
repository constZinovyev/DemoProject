//
//  AppDelegate.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "AppDelegate.h"
#import "StartAppConfiguratorImplementation.h"

@interface AppDelegate ()

@property (nonatomic, strong) id<StartAppConfigurator> startConfigurator;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureAppDelegate];
    [self.startConfigurator configureInitialSettingsWithWindow:self.window];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Приватные методы

- (void)configureAppDelegate {
    self.startConfigurator = [[StartAppConfiguratorImplementation alloc] init];
}

@end
