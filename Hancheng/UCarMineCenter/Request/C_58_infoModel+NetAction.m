//
//  C_58_infoModel+NetAction.m
//  Hancheng
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_58_infoModel+NetAction.h"

@implementation C_58_infoModel (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:C58UCARGETMYINDEX WithParamDic:nil];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        C_58_infoModel *model = [C_58_infoModel modelWithJSON:request.responseBody[@"data"]];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock([request description]);
    }];
}
@end
