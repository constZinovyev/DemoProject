//
//  ContentListPresenter.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListViewOutput.h"
#import "ContentListInteractorOutput.h"

@protocol ContentListViewInput;
@protocol ContentListInteractorInput;
@protocol ContentListRouterInput;
@class StatesStorage;

@interface ContentListPresenter : NSObject <ContentListViewOutput, ContentListInteractorOutput>

@property (nonatomic, weak) id<ContentListViewInput> view;
@property (nonatomic, strong) id<ContentListInteractorInput> interactor;
@property (nonatomic, strong) id<ContentListRouterInput> router;

@property (nonatomic, strong) StatesStorage *statesStorage;

@end
