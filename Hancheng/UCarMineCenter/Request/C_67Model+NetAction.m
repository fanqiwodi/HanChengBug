//
//  C_67Model+NetAction.m
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "C_67Model+NetAction.h"

@implementation C_67Model (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithorderId:(NSNumber *)orderId
{
    NSString *url = [NSString stringWithFormat:@"/api/ucarMy/getOrderDetails?orderId=%@", orderId];
//    NSLog(@"==== %@",orderId);
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:url];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSLog(@"67 : %@",request.responseJSONObject);
        C_67Model *model = [C_67Model new];
        model = [C_67Model modelWithJSON:request.responseBody[@"data"]];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}
@end
