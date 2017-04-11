//
//  ContentListInteractorOutput.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentType.h"

@protocol ContentListInteractorOutput <NSObject>

/**
 @author Konstantin Zinovyev
 
 Метод сообщает презентеру о неудачном обновлении ленты определенного типа.
 */
- (void)didUpdateContentListWithError:(NSError *)error
                                 type:(ContentType)type
                           searchTerm:(NSString *)searchTerm;

/**
 @author Konstantin Zinovyev
 
 Метод сообщает презенту об удачном обновлении ленты.
 */
- (void)didUpdateContentListSuccessfullyWithType:(ContentType)type
                                    plainObjects:(NSArray *)plainObjects
                                      searchTerm:(NSString *)searchTerm;;

@end
