//
//  RefreshModel+RefreshAction.m
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RefreshModel+RefreshAction.h"
#import "YYKit.h"
@implementation RefreshModel (RefreshAction)

+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc]initWithUrl:@"/api/ucarshow/getCarousel"];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        RefreshModel *model = [RefreshModel modelWithJSON:request.responseBody];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}


@end
