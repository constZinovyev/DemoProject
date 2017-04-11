//
//  NetworkClient.h
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

typedef void (^NetworkClientResponseBlock)(NSData *data, NSError *error);

@protocol NetworkClient <NSObject>

/**
 Метод отправляет запрос на сервер
 */
- (void)sendRequest:(NSURLRequest *)request competionBlock:(NetworkClientResponseBlock)block;

@end
