//
//  ContentListCellObjectsBuilder.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ContentListCellObjectsBuilder.h"
#import "ContentTableViewCell.h"
#import "ContentCellObject.h"
#import "UserPlainObject.h"

@implementation ContentListCellObjectsBuilder

- (NSArray *)buildCellObjectsFromItems:(NSArray *)items
                           contentType:(ContentType)type
                                output:(id<ContentCellActions>)output {
    NSMutableArray *cellObjects = [[NSMutableArray alloc] init];
    NSUInteger offsetOrderCell = type;
    NSString *cellIdentifier = NSStringFromClass([ContentTableViewCell class]);
    [items enumerateObjectsUsingBlock:^(UserPlainObject *user, NSUInteger index, BOOL *stop) {
        BOOL isLeftAlign = (index + offsetOrderCell) % 2 == 0;
        ContentCellObject *cellObject = [ContentCellObject cellObjectWithTitle:user.title
                                                                      subtitle:user.subtitle
                                                                      imageURL:user.image
                                                                    identifier:cellIdentifier];
        cellObject.output = output;
        cellObject.isLeftAlign = isLeftAlign;
        [cellObjects addObject:cellObject];
    }];
    return [cellObjects copy];
}

@end
