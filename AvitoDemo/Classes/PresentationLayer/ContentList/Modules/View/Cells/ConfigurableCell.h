//
//  ConfigurableCell.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//
@protocol CellObject;

@protocol ConfigurableCell <NSObject>

/**
 Метод обновляет ячейку используя cell object
 */
- (void)configureCellWithCellObject:(id)cellObject;

@end
