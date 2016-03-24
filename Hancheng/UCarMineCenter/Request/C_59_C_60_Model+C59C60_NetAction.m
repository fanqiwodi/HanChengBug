//
//  C_59_C_60_Model+C59C60_NetAction.m
//  Hancheng
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_59_C_60_Model+C59C60_NetAction.h"

@implementation C_59_C_60_Model (C59C60_NetAction)
+ (void)handleC59WithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:@"/api/ucarMy/getChoseProvince"];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *modelArr = [NSArray modelArrayWithClass:[C_59_C_60_Model class] json:request.responseBody[@"datalist"]];
        successBlock(modelArr);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}

+ (void)handleC60WithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithNumber:(NSNumber *)provinceId
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc]initWithUrl:[NSString stringWithFormat:@"/api/ucarMy/getChoseCity?provinceId=%@", provinceId]];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *modelArr = [NSArray modelArrayWithClass:[C_59_C_60_Model class] json:request.responseBody[@"datalist"]];
        successBlock(modelArr);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}
@end
