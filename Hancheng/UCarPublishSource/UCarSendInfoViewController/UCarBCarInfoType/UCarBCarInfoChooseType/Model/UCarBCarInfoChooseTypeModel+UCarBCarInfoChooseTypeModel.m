//
//  UCarBCarInfoChooseTypeModel+UCarBCarInfoChooseTypeModel.m
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseTypeModel+UCarBCarInfoChooseTypeModel.h"

@implementation UCarBCarInfoChooseTypeModel (UCarBCarInfoChooseTypeModel)

+ (void)GETCommonCarTypeChoose:(CompletionBlock)successBlock Failure:(FailureBlock)failBlock Header:(NSString *)header carSourceCategoryId:(NSString *)carSourceCategoryId
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B53CARCOMMONTYPE WithParamDic:@{@"carSourceCategoryId":carSourceCategoryId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarInfoChooseTypeModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        successBlock(dataSource);
    } failure:^(YTKBaseRequest *request) {
        NSString *fail = @"0";
        failBlock(fail);
    }];
}
@end
