//
//  ContentTableViewCell.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurableCell.h"
#import "SyncObjectContainer.h"

@class ContentCellObject;

@interface ContentTableViewCell : UITableViewCell <ConfigurableCell, SyncObjectContainer>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) NSString *imageURL;

@end
