//
//  ResponseDeserialization.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

@protocol ResponseDeserialization <NSObject>

/**
 Десериализует данные
 */
- (NSDictionary *)deserializeServerResponse:(NSData *)responseData;

@end
