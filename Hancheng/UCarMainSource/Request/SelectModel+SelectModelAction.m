//
//  SelectModel+SelectModelAction.m
//  Hancheng
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SelectModel+SelectModelAction.h"
#import "YYKit.h"
@implementation SelectModel (SelectModelAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock BrandId:(NSNumber *)myID
{
    NSString *url = [NSString stringWithFormat:@"/api/ucarshow/getSerchsetList?id=%@", myID];

    NSLog(@"-%@-", url);
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:url];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        NSLog(@"-%@-", request.responseBody);
        SelectModel *model = [SelectModel modelWithJSON:request.responseBody];
        
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}
@end
