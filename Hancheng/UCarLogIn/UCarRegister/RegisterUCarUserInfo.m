//
//  RegisterUCarUserInfo.m
//  Hancheng
//
//  Created by Tony on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterUCarUserInfo.h"

@implementation RegisterUCarUserInfo


+ (void)GetChooseProvincesuccess:(CompletionBlock)successBlk faliureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:C59UCARCHOOSEPROVINCE];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempArray = [[request.responseJSONObject objectForKey:@"datalist"] mutableCopy];
        NSLog(@"%@", tempArray);
        successBlk(tempArray);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseJSONObject);
    }];
    
}

+ (void)GetChooseCityProvinceID:(NSNumber *)provinceID success:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:C60UCARCHOOSECITY WithParamDic:@{@"provinceId":provinceID}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempArray = [[request.responseJSONObject objectForKey:@"datalist"] mutableCopy];
        NSLog(@"%@",request.responseJSONObject);
        successBlk(tempArray);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseJSONObject);
    }];
}

@end
