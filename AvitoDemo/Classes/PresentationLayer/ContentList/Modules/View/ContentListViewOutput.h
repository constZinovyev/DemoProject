//
//  ContentListViewOutput.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 04/04/2017.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentType.h"

@protocol ContentListViewOutput <NSObject>

/**
 @author Konstantin Zinovyev

 Метод сообщает презентеру о том, что view готова к работе
 */
- (void)didTriggerViewReadyEvent;

/**
 Метод сообщает презентеру о том, что был изменен тип контента
 */
- (void)didTriggerChangeStateToType:(ContentType)type;


/**
 Метод сообщает презентеру о новом поисковом запросе
 */
- (void)didTriggerClickSearchWithTerm:(NSString *)term;

@end
