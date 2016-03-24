//
//  UCarMainSourceNetwork.m
//  Hancheng
//
//  Created by Tony on 16/2/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarMainSourceNetwork.h"
#import "UCarPublishMainModel.h"

@implementation UCarMainSourceNetwork

+ (void)GETWithA10:(CompletionBlock)successBlk FailureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:A10UCARMAINSOURCE];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        UCarMainSourceA10Model *model = [UCarMainSourceA10Model modelWithJSON:request.responseJSONObject];
        successBlk(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseJSONObject);
    }];
}

+ (void)GETWithA57:(CompletionBlock)successBlk FailureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:A57UCARGETCAROUSEL];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        UCarMainSourceCarouselA57Model *model = [UCarMainSourceCarouselA57Model modelWithJSON:request.responseJSONObject];
        successBlk(model);
    } failure:^(YTKBaseRequest *request) {
        successBlk(request.responseJSONObject);
    }];
}

+ (void)GETWithA88:(CompletionBlock)successBlk FailureBlk:(FailureBlock)failureBlk param:(NSMutableDictionary *)param
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:A88UCARGETSEO WithParamDic:param];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *datalist = [NSArray modelArrayWithClass:[UCarPublishMainModel_data_bodys class] json:[request.responseJSONObject objectForKey:@"datalist"]];
        if (datalist) {
        successBlk(datalist);
        }
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request);
    }];
}


+ (void)GETWithA89KeyWord:(NSString *)keyword successBlk:(CompletionBlock)successblk failureBlk:(FailureBlock)failureblk
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:A89UCARGETKEYSEARCH WithParamDic:@{@"keyWord":keyword}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
        UCarMainSearchA89Model_data *model = [UCarMainSearchA89Model_data modelWithJSON:[request.responseJSONObject objectForKey:@"data"]];
        successblk(model);
    } failure:^(YTKBaseRequest *request) {
        failureblk(request);
    }];
}


+ (void)GETWithA92keyDictory:(NSDictionary *)keyDictory successblk:(CompletionBlock)successblk failure:(FailureBlock)failureblk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:A92UCARGETKEYCOUNT WithParamDic:keyDictory];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"%@",request.responseBody);
        NSNumber *count = [request.responseJSONObject objectForKey:@"totalCount"];
        successblk(count);
    } failure:^(YTKBaseRequest *request) {
        failureblk(@-1);
    }];
}

@end
