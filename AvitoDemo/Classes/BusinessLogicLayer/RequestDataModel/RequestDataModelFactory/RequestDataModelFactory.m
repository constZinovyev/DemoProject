//
//  RequestDataModelFactory.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "RequestDataModelFactory.h"
#import "RequestDataModel.h"

static NSString *const kRequestLimitCount = @"50";

@implementation RequestDataModelFactory

- (RequestDataModel *)requestDataModelForContentType:(ContentType)contentType
                                          searchTerm:(NSString *)term {
    NSDictionary *requestSelectorsName = [self requestSelectorNames];
    NSString *selectorName = requestSelectorsName[@(contentType)];
    if (selectorName.length == 0 || term.length == 0) {
        return nil;
    }
    RequestDataModel *model = [self performSelector:NSSelectorFromString(selectorName)
                                         withObject:term];
    return model;
}

- (RequestDataModel *)requestGitHubModelWithTerm:(NSString *)term {
    RequestDataModel *model = [[RequestDataModel alloc] init];
    model.queryParameters = @{
                              @"q":term,
                              @"per_page":kRequestLimitCount
                              };
    model.searchURL =  @"https://api.github.com/search/users";
    return model;
}

- (RequestDataModel *)requestAppleModelWithTerm:(NSString *)term {
    RequestDataModel *model = [[RequestDataModel alloc] init];
    model.queryParameters = @{
                              @"term" : term,
                              @"limit" : kRequestLimitCount
                              };
    model.searchURL = @"https://itunes.apple.com/search";
    return model;
}

#pragma mark - Приватные методы

- (NSDictionary *)requestSelectorNames {
    return @{
             @(ContentGitHubType) : NSStringFromSelector(@selector(requestGitHubModelWithTerm:)),
             @(ContentAppleType) : NSStringFromSelector(@selector(requestAppleModelWithTerm:))
             };
}

@end
