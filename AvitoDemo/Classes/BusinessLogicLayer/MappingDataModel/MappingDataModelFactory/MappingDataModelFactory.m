//
//  MappingDataModelFactory.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "MappingDataModelFactory.h"
#import "MappingDataModel.h"
#import "UserPlainObject.h"

@implementation MappingDataModelFactory

- (MappingDataModel *)mappingDataModelForContentType:(ContentType)contentType {
    NSDictionary *mappingSelectorsName = [self mappingSelectorNames];
    NSString *selectorName = mappingSelectorsName[@(contentType)];
    if (selectorName.length == 0) {
        return nil;
    }
    MappingDataModel *model = [self performSelector:NSSelectorFromString(selectorName)];
    model.objectType = contentType;
    return model;
}

- (MappingDataModel *)mappingGitHubModel {
    MappingDataModel *model = [[MappingDataModel alloc] init];
    model.attributeMapping = @{
                               NSStringFromSelector(@selector(image)) : @"avatar_url",
                               NSStringFromSelector(@selector(title)) : @"login",
                               NSStringFromSelector(@selector(subtitle)) : @"html_url"
                               };
    model.resultKey = @"items";
    model.objectType = ContentGitHubType;
    return model;
}

- (MappingDataModel *)mappingAppleModel {
    MappingDataModel *model = [[MappingDataModel alloc] init];
    model.attributeMapping = @{
                               NSStringFromSelector(@selector(image)) : @"artworkUrl60",
                               NSStringFromSelector(@selector(title)) : @"artistName",
                               NSStringFromSelector(@selector(subtitle)) : @"trackName"
                               };
    model.resultKey = @"results";
    model.objectType = ContentAppleType;
    return model;
}

#pragma mark - Приватные методы

- (NSDictionary *)mappingSelectorNames {
    return @{
             @(ContentGitHubType) : NSStringFromSelector(@selector(mappingGitHubModel)),
             @(ContentAppleType) : NSStringFromSelector(@selector(mappingAppleModel))
             };
}


@end
