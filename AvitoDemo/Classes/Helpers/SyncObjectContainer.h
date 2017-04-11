//
//  SyncObjectContainer.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

/**
 Содержит ссылку на изображение, которое должно находится в контейнере.
 Если ссылка скаченного изображения не соответствует данной, то обновление изображения не требуется
 */
@protocol SyncObjectContainer <NSObject>

@property (nonatomic, strong) NSString *imageURL;

@end
