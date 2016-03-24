//
//  CarbandDetailModel+CarbandDetailAction.m
//  Hancheng
//
//  Created by why on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarbandDetailModel+CarbandDetailAction.h"
#import "YYKit.h"
@implementation CarbandDetailModel (CarbandDetailAction)
+(void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock BrandId:(NSNumber *)myID
{
    NSString *url = [NSString stringWithFormat:@"/api/ucarshow/getGoods?id=%@", myID];
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:url];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        NSLog(@"    %@    ", request.responseBody);
        CarbandDetailModel *model = [CarbandDetailModel modelWithJSON:request.responseBody];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}
@end
