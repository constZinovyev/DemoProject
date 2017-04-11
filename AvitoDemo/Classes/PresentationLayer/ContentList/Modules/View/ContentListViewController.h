//
//  ContentListViewController.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ContentListViewInput.h"
#import "ContentCellActions.h"

@protocol ContentListViewOutput;
@class ContentListNavigationItem;
@class ContentListDataDisplayManager;
@class FullImageAnimator;

@interface ContentListViewController : UIViewController <ContentListViewInput, UISearchBarDelegate, ContentCellActions>

@property (nonatomic, strong) id<ContentListViewOutput> output;
@property (nonatomic, strong) ContentListDataDisplayManager *dataDisplayManager;

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet FullImageAnimator *imageAnimator;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;


@end
