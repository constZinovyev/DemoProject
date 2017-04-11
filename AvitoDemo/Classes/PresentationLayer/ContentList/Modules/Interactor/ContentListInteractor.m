//
//  ContentListInteractor.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListInteractor.h"

#import "ContentListInteractorOutput.h"
#import "ContentService.h"

@implementation ContentListInteractor

#pragma mark - Методы ContentListInteractorInput

- (void)updateContentListWithType:(ContentType)type searchTerm:(NSString *)searchTerm {
    NSDictionary *services = [self servicesDictionary];
    id<ContentService> service = services[@(type)];
    if (service == nil) {
        return;
    }
    [service loadContentWithType:type
                      searchTerm:searchTerm
                  competionBlock:^(NSArray *objects, NSError *error) {
                      if (error) {
                        [self.output didUpdateContentListWithError:error
                                                              type:type
                                                        searchTerm:searchTerm];
                          return;
                      }
                      [self.output didUpdateContentListSuccessfullyWithType:type
                                                               plainObjects:objects
                                                                 searchTerm:searchTerm];
    }];
}

#pragma mark - Приватные методы

- (NSDictionary *)servicesDictionary {
    return @{
            @(ContentAppleType) : self.contentAppleService,
             @(ContentGitHubType) : self.contentGitHubService
             };
}

@end
