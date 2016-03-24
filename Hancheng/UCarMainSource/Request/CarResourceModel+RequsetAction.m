//
//  CarResourceModel+RequsetAction.m
//  Hancheng
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarResourceModel+RequsetAction.h"

#import "YYKit.h"
@implementation CarResourceModel (RequsetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:@"/api/ucarshow/getBrandList"];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        CarResourceModel *model = [CarResourceModel modelWithJSON:request.responseBody];
       
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}
@end
