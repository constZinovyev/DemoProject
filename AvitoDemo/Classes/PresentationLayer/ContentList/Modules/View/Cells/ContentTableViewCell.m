//
//  ContentTableViewCell.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "ContentCellObject.h"
#import "UIImageView+DownloadableImage.h"

static const UILayoutPriority kMaxConstraintPriority = 999.0f;
static const UILayoutPriority kMinConstraintPriority = 1.0f;

@interface ContentTableViewCell ()

@property (nonatomic, strong) ContentCellObject *cellObject;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageTrailingConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelsLeadinConstraint;

@end

@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(didTapIconImageView)];
    [self.iconImageView addGestureRecognizer:tapGestureRecognizer];
}

- (void)configureCellWithCellObject:(ContentCellObject *)cellObject {
    
    self.titleLabel.text = cellObject.title;
    self.subtitleLabel.text = cellObject.subtitle;
    self.cellObject = cellObject;
    self.imageURL = cellObject.imageURL;
    [self configureViewWithLeftAlign:cellObject.isLeftAlign];
    [self.iconImageView ad_downloadWithSyncObject:self];
}

- (void)didTapIconImageView {
    [self.cellObject.output didTapOnImageView:self.iconImageView];
}

#pragma mark - Приватные методы

- (void)configureViewWithLeftAlign:(BOOL)isLeftAlign {
    self.imageTrailingConstraint.priority = isLeftAlign ? kMaxConstraintPriority : kMinConstraintPriority;
    self.labelsLeadinConstraint.priority = self.imageTrailingConstraint.priority;
    self.titleLabel.textAlignment = isLeftAlign ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.subtitleLabel.textAlignment = isLeftAlign ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
}

@end
