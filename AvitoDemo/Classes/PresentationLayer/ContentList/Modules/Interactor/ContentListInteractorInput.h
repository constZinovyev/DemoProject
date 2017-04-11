//
//  ContentListInteractorInput.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentType.h"

@protocol ContentListInteractorInput <NSObject>

/**
 @author Konstantin Zinovyev
 
 Метод запрашивает контент определенного типа, используя поисковой запрос
 */
- (void)updateContentListWithType:(ContentType)type
                       searchTerm:(NSString *)searchTerm;

@end
