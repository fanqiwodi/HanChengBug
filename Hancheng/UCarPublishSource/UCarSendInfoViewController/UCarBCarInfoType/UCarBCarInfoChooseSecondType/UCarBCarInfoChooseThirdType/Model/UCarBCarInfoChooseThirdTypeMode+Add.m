//
//  UCarBCarInfoChooseThirdTypeMode+Add.m
//  Hancheng
//
//  Created by Tony on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseThirdTypeMode+Add.h"

@implementation UCarBCarInfoChooseThirdTypeMode (Add)


+ (void)GETUCarBCarInfoChooseThirdTypeGoodsCategoryIdLevel2:(NSString *)goodsCategoryIdLevel2 carSourceCategoryId:(NSString *)carSourceCategoryId header:(NSString *)uid successGET:(CompletionBlock)successBlock failureGET:(FailureBlock)faileBlock
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B23CARINFOTHIRDTYPE WithParamDic:@{@"goodsCategoryIdLevel2":goodsCategoryIdLevel2,@"carSourceCategoryId":carSourceCategoryId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarInfoChooseThirdTypeMode_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        successBlock(dataSource);
    } failure:^(YTKBaseRequest *request) {
        faileBlock(0);
    }];
}

@end
