//
//  UCarBCarInfoTypeModel+UCarBCarInfo.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoTypeModel+UCarBCarInfo.h"

@implementation UCarBCarInfoTypeModel (UCarBCarInfo)

+ (void)GETUCarBCarInfoType:(CompletionBlock)successBlock Failure:(FailureBlock)failBlock headerDictory:(NSDictionary *)headerDictory carSourceCategoryId:(NSString *)carSourceCategoryId
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B52USERCOMMONTTYPE WithParamDic:@{@"carSourceCategoryId":carSourceCategoryId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarInfoTypeModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        successBlock(dataSource);
    } failure:^(YTKBaseRequest *request) {
        failBlock(request.responseBody);
    }];
    
}

+ (void)GETUCarGetSearchBrand:(NSString *)uid successblk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B87UCARGETSEARCHTYPE header:@{@"Uid":uid}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarInfoTypeModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        successBlk(dataSource);
    } failure:^(YTKBaseRequest *request) {
    }];
}


@end
