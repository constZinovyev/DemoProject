//
//  ContentType.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

/**
 Типы возможного контента

 - ContentAppleType: Контент из поиска по iTunes
 - ContentGitHubType:  Контент из поиска по Github
 */
typedef NS_ENUM(NSUInteger, ContentType){
    ContentAppleType = 0,
    ContentGitHubType = 1
    
};
