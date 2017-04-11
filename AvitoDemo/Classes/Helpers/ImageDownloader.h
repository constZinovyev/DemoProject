//
//  ImageDownloader.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

typedef void (^ImageDownloadeCompletionBlock)(UIImage *image, NSError *error);

/**
 Отвечает за загрузку изображений
 */
@interface ImageDownloader : NSObject

+ (instancetype)sharedInstance;

/**
 Загружает изображение по ссылке
 */
- (void)downloadImageWithURL:(NSString *)imageURL competionBlock:(ImageDownloadeCompletionBlock)block;

@end
