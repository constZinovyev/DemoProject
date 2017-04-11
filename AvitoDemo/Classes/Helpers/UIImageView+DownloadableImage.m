//
//  UIView+UIImageView+DownloadableImage.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 09.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "UIImageView+DownloadableImage.h"
#import "ImageDownloader.h"

@implementation UIImageView (DownloadableImage)

- (void)ad_downloadWithSyncObject:(id<SyncObjectContainer>)syncObject {
    self.image = nil;
    NSString *imageURL = syncObject.imageURL;
    __weak typeof(self)weakSelf = self;
    [[ImageDownloader sharedInstance] downloadImageWithURL:imageURL competionBlock:^(UIImage *image, NSError *error) {
           __strong typeof(self)strongSelf = weakSelf;
            if (image && !error && [syncObject.imageURL isEqualToString:imageURL]) {
                strongSelf.image = image;
            }
    }];
}

@end
