//
//  ContentListAssembly.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListAssembly.h"

#import "ContentListViewController.h"
#import "ContentListInteractor.h"
#import "ContentListPresenter.h"
#import "ContentListRouter.h"

#import "ContentListDataDisplayManager.h"
#import "ContentListCellObjectsBuilder.h"
#import "ContentListState.h"
#import "ContentType.h"
#import "StatesStorage.h"

#import "ServicesAssembly.h"

static NSString *const kContentListStoryboardName = @"ContentList";

@interface ContentListAssembly ()

@property (nonatomic, strong) ServicesAssembly *servicesFactory;
@property (nonatomic, strong) UIStoryboard *storyboard;

@property (nonatomic, strong) ContentListViewController *viewController;
@property (nonatomic, strong) ContentListRouter *routerContentList;
@property (nonatomic, strong) ContentListPresenter *presenterContentList;
@property (nonatomic, strong) ContentListInteractor *interactorContentList;

@end

@implementation ContentListAssembly

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _servicesFactory = [[ServicesAssembly alloc] init];
        _storyboard = [UIStoryboard storyboardWithName:kContentListStoryboardName
                                                bundle:[NSBundle mainBundle]];
    }
    
    return self;
    
}
- (UIViewController *)configureModuleWithServicesFactory:(ServicesAssembly *)servicesFactory {
    self.servicesFactory = servicesFactory;
    self.viewController = [self.storyboard instantiateInitialViewController];
    
    self.viewController.output = self.presenterContentList;
    self.viewController.dataDisplayManager = [self dataDisplayManagerContentList];
    
    return self.viewController;
}

#pragma mark - Module Component

- (ContentListPresenter *)presenterContentList {
    if (_presenterContentList == nil) {
        _presenterContentList = [[ContentListPresenter alloc] init];
        _presenterContentList.view = self.viewController;
        _presenterContentList.router = self.routerContentList;
        _presenterContentList.interactor = self.interactorContentList;
        _presenterContentList.statesStorage = [self storageStatesContentList];
    }
    return _presenterContentList;
}


- (ContentListRouter *)routerContentList{
    if (_routerContentList == nil) {
        _routerContentList = [[ContentListRouter alloc] init];
        _routerContentList.transitionHandler = self.viewController;
    }
    return _routerContentList;
}

- (ContentListInteractor *)interactorContentList {
    if (_interactorContentList == nil) {
        _interactorContentList = [[ContentListInteractor alloc] init];
        
        _interactorContentList.output = self.presenterContentList;
        _interactorContentList.contentAppleService = [self.servicesFactory serviceAppleSearch];
        _interactorContentList.contentGitHubService = [self.servicesFactory serviceGitHubSearch];
    }
    
    return _interactorContentList;
}

#pragma mark - Другие компоненты

- (ContentListDataDisplayManager *)dataDisplayManagerContentList{
    ContentListDataDisplayManager *dataDisplayManager = [[ContentListDataDisplayManager alloc] init];
    ContentListCellObjectsBuilder *builder = [[ContentListCellObjectsBuilder alloc] init];
    dataDisplayManager.delegate = self.viewController;
    dataDisplayManager.cellObjectsBuilder = builder;
    
    return dataDisplayManager;
}

- (StatesStorage *)storageStatesContentList{
    NSArray *defaultStates = [self defaultStatesContentList];
    StatesStorage *storage = [[StatesStorage alloc] initWithStates:defaultStates];
    
    return storage;
}

- (NSArray *)defaultStatesContentList {
    NSMutableArray *statesObjects = [[NSMutableArray alloc] init];
    NSDictionary *states = [self statesContentList];
    NSArray *types = states.allKeys;
    for (NSNumber *type in types) {
        NSString *title = states[type];
        ContentListState *state = [[ContentListState alloc] initWithTitle:title
                                                                     type:[type unsignedIntegerValue]];
        [statesObjects addObject:state];
    }
    
    return [statesObjects copy];
}

- (NSDictionary *)statesContentList {
    return @{
             @(ContentAppleType) : @"iTunes",
             @(ContentGitHubType) : @"GitHub"
             };
}

@end
