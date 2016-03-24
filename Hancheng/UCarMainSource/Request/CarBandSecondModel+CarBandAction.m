//
//  CarBandSecondModel+CarBandAction.m
//  Hancheng
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarBandSecondModel+CarBandAction.h"
#import "CarBandSecondModel.h"
#import "YYKit.h"
@implementation CarBandSecondModel (CarBandAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock BrandId:(NSNumber *)myID;
{
    NSString *url = [NSString stringWithFormat:@"/api/ucarshow/getGoodsCategoryList?brandId=%@", myID];
    
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:url];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        CarBandSecondModel *model = [CarBandSecondModel modelWithJSON:request.responseBody];

        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
    
}
@end
