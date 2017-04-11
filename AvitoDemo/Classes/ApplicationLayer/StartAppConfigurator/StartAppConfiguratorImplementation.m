//
//  StartAppConfiguratorImplementation.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 08.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "StartAppConfiguratorImplementation.h"

#import "ContentListAssembly.h"
#import "ServicesAssembly.h"

static const NSUInteger kCacheMemoryCapacity = 3 * 1024 * 1024;
static const NSUInteger kCacheDiskCapacity = 10 * 1024 * 1024;

@interface StartAppConfiguratorImplementation ()

@property (nonatomic, strong) ContentListAssembly *rootControllerAssembly;
@property (nonatomic, strong) ServicesAssembly *servicesAssembly;

@end

@implementation StartAppConfiguratorImplementation

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _rootControllerAssembly = [[ContentListAssembly alloc] init];
        _servicesAssembly = [[ServicesAssembly alloc] init];
    }
    
    return self;
}

- (void)configureInitialSettingsWithWindow:(UIWindow *)window {
    [self setupCacheSize];
    window.rootViewController = [self.rootControllerAssembly configureModuleWithServicesFactory:self.servicesAssembly];
}

#pragma mark - Приватные методы

- (void)setupCacheSize {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:kCacheMemoryCapacity
                                                         diskCapacity:kCacheDiskCapacity
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
}

@end
