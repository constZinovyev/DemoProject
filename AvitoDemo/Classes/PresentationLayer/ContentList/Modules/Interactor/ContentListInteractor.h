//
//  ContentListInteractor.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListInteractorInput.h"

@protocol ContentListInteractorOutput;
@protocol ContentService;

@interface ContentListInteractor : NSObject <ContentListInteractorInput>

@property (nonatomic, weak) id<ContentListInteractorOutput> output;
@property (nonatomic, strong) id<ContentService> contentGitHubService;
@property (nonatomic, strong) id<ContentService> contentAppleService;

@end
