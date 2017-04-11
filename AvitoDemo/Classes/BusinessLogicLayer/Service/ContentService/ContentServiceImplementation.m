//
//  ContentServiceImplementation.m
//  AvitoDemo
//
//  Created by Konstantin Zinovyev on 05.04.17.
//  Copyright © 2017 Konstantin Zinovyev. All rights reserved.
//

#import "ContentServiceImplementation.h"

#import "RequestConfigurator.h"
#import "NetworkClient.h"
#import "ResponseDeserialization.h"
#import "ResponseValidator.h"
#import "ResponseMapper.h"

#import "MappingDataModelFactory.h"
#import "RequestDataModelFactory.h"
#import "RequestDataModel.h"
#import "MappingDataModel.h"

@implementation ContentServiceImplementation

- (void)loadContentWithType:(ContentType)type
                 searchTerm:(NSString *)searchTerm
             competionBlock:(ContentServiceCompletionBlockWithError)block {
    MappingDataModel *mappingModel = [self.mappingModelFactory mappingDataModelForContentType:type];
    RequestDataModel *requestModel = [self.requestModelFactory requestDataModelForContentType:type
                                                                                   searchTerm:searchTerm];
    NSURLRequest *request = [self.requestConfigurator obtainRequestWithDataModel:requestModel];
    [self.networkClient sendRequest:request competionBlock:^(NSData *data, NSError *error) {
        NSArray *objects;
        NSError *resultError = error;
        if (!resultError) {
            NSDictionary *response = [self.responseDeserialization deserializeServerResponse:data];
            resultError = [self.responseValidator validateResponse:response
                                                    mappingDataModel:mappingModel];
            if (!resultError) {
                objects = [self.responseMapper mapResponse:response
                                          mappingDataModel:mappingModel];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(objects, resultError);
            }
        });
    }];
}

@end
