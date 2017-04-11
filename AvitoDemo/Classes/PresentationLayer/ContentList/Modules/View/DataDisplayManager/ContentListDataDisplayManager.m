//
//  ContentListDataDisplayManager.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ContentListDataDisplayManager.h"
#import "CellObject.h"
#import "ConfigurableCell.h"
#import "ContentListCellObjectsBuilder.h"

@interface ContentListDataDisplayManager ()

@property (nonatomic, strong) NSArray *cellObjects;

@end

@implementation ContentListDataDisplayManager

- (void)updateTableModelWithObjects:(NSArray *)objects
                        contentType:(ContentType)type {
    NSArray *cellObjects = [self.cellObjectsBuilder buildCellObjectsFromItems:objects
                                                                  contentType:type
                                                                       output:self];
    self.cellObjects = cellObjects;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<CellObject> cellObject = self.cellObjects[indexPath.row];
    NSString *identifier = [cellObject cellIdentifier];
    UITableViewCell<ConfigurableCell> *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell configureCellWithCellObject:cellObject];
    return cell;
}

#pragma mark - ContentCellActions

- (void)didTapOnImageView:(UIImageView *)imageView {
    [self.delegate didTapOnImageView:imageView];
}

@end
