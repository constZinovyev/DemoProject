//
//  ContentListViewController.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ContentListViewController.h"

#import "ContentListViewOutput.h"
#import "ContentListState.h"
#import "ContentListDataDisplayManager.h"
#import "FullImageAnimator.h"

@implementation ContentListViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы ContentListViewInput

- (void)configureWithStates:(NSArray *)states {
    self.tableView.delegate = self.dataDisplayManager;
    self.tableView.dataSource = self.dataDisplayManager;
    
    [self.segmentedControl removeAllSegments];
    [states enumerateObjectsUsingBlock:^(ContentListState *state, NSUInteger index, BOOL *stop) {
        [self.segmentedControl insertSegmentWithTitle:state.title
                                              atIndex:index
                                             animated:NO];
    }];
}

- (void)updateViewWithState:(ContentListState *)state {
    [self.searchBar resignFirstResponder];
    self.segmentedControl.selectedSegmentIndex = state.type;
    [self.dataDisplayManager updateTableModelWithObjects:state.objects
                                             contentType:state.type
     ];
    [self.tableView reloadData];
    [self updateOffsetTableViewWithPoint:state.contentOffset];
}

- (CGPoint)obtainCurrentOffsetTableView {
    return self.tableView.contentOffset;
}

- (void)updateOffsetTableViewWithPoint:(CGPoint)offset {
    [self.tableView setContentOffset:offset
                            animated:NO];
}

#pragma mark - Actions

- (IBAction)didChangeSelectedIndex:(id)sender {
    [self.output didTriggerChangeStateToType:self.segmentedControl.selectedSegmentIndex];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.output didTriggerClickSearchWithTerm:searchBar.text];
}

- (void)didTapOnImageView:(UIImageView *)imageView {
    [self.searchBar resignFirstResponder];
    [self.imageAnimator showFullImageFromImageView:imageView];
}

@end
