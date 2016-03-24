
//
//  UcarBCarConfigureModel+Add.m
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UcarBCarConfigureModel+Add.h"

@implementation UcarBCarConfigureModel (Add)


+ (void)GETBrightPackageListGoodsTemplateID:(NSString *)goodsTemplateId success:(CompletionBlock)successBlk failure:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B33CARLIGHTSPOTBAG WithParamDic:@{@"goodsTemplateId":goodsTemplateId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempArray = [NSArray modelArrayWithClass:[UcarBCarConfigureModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        NSMutableArray *dataSource = [NSMutableArray array];
        for (UcarBCarConfigureModel_datalist *model in tempArray) {
            [dataSource addObject:model];
        }
        successBlk(dataSource);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

+ (void)GETBrightPointsListGoodsTempLateID:(NSString *)goodsTemplateId success:(CompletionBlock)successBlk failure:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B30CARLIGHTSPOT WithParamDic:@{@"goodsTemplateId":goodsTemplateId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempArray = [NSArray modelArrayWithClass:[UcarBCarConfigureModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        NSMutableArray *dataSource = [NSMutableArray array];
        for (UcarBCarConfigureModel_datalist *model in tempArray) {
            [dataSource addObject:model];
        }
        successBlk(dataSource);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


@end
