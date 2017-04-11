//
//  CellObject.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 06.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

@protocol CellObject <NSObject>

/**
 Идентификатор ячейки, которая соответсвует данному cell object'у
 */
@property (nonatomic, strong, readonly) NSString *cellIdentifier;

@end
