//
//  C_47_BuyCarModel+NetAction.m
//  Hancheng
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_47_BuyCarModel+NetAction.h"

@implementation C_47_BuyCarModel (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithC47orC48:(NSString *)C47orC48 WithHeader:(NSDictionary *)header
{
    if ([C47orC48 isEqualToString:@"C47"]) {
        GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc]initWithUrl:@"/api/ucarMy/getMyBuyOrder" header:header];
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            C_47_BuyCarModel *model = [C_47_BuyCarModel modelWithJSON:request.responseBody];
            successBlock(model);
            
        } failure:^(YTKBaseRequest *request) {
            failureBlock([request description]);
        }];
    } else if ([C47orC48 isEqualToString:@"C48"]) {
        GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc]initWithUrl:@"/api/ucarMy/getMySellOrder" header:header];
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            C_47_BuyCarModel *model = [C_47_BuyCarModel modelWithJSON:request.responseBody];
            successBlock(model);
            
        } failure:^(YTKBaseRequest *request) {
            failureBlock([request description]);
        }];
    }
}

@end
