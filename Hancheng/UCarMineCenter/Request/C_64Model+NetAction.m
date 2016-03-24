//
//  C_64Model+NetAction.m
//  Hancheng
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_64Model+NetAction.h"

@implementation C_64Model (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithUid:(NSString *)Uid
{
    
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:@"/api/ucarMy/getPersonalData" header:@{@"Uid":Uid}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        C_64Model *model = [C_64Model modelWithJSON:request.responseBody[@"data"]];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock([request description]);
    }];
}
@end
