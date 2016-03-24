//
//  C_68Model+NetAction.m
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "C_68Model+NetAction.h"

@implementation C_68Model (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithUid:(NSDictionary *)Uid
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:@"/api/ucarMy/getOrderTransactionAlert" header:Uid];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempArr = [NSArray modelArrayWithClass:[C_68Model class] json:request.responseBody[@"datalist"]];
        successBlock(tempArr);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}
@end
