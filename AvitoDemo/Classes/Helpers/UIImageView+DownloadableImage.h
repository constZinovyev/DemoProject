//
//  UIImageView+DownloadableImage.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyncObjectContainer.h"

@interface UIImageView (DownloadableImage)

/**
 Иниицирует загрузку изображения в imageView

 @param syncObject объект по которому проверяем необходимость обновления изображения
 */
- (void)ad_downloadWithSyncObject:(id<SyncObjectContainer>)syncObject;

@end
