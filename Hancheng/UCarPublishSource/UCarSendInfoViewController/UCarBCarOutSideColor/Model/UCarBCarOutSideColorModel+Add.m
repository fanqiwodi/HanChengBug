//
//  UCarBCarOutSideColorModel+Add.m
//  Hancheng
//
//  Created by Tony on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarOutSideColorModel+Add.h"
#import "UCarBCarOutSideColorModel.h"

@implementation UCarBCarOutSideColorModel (Add)

+ (void)GETOutSideColorListgoodsTemplateId:(NSString *)goodsTemplateId uid:(NSString *)header successBlock:(CompletionBlock)successBloce failure:(FailureBlock)failBlock
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B51CAROUTSIDECOLOR WithParamDic:@{@"goodsTemplateId":goodsTemplateId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarOutSideColorModel_outColorDataList class] json:[request.responseBody objectForKey:@"datalist"]];
        NSMutableArray *colorArr = [NSMutableArray array];
        for (UCarBCarOutSideColorModel_outColorDataList *model in dataSource) {
            [colorArr addObject:model.outColor];
        }
        successBloce(colorArr);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

+ (void)GETInSideColorListgoodsTemplateId:(NSString *)goodsTemplateId uid:(NSString *)header successBlock:(CompletionBlock)successBloce failure:(FailureBlock)failBlock
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B50CARINSIDECOLOR WithParamDic:@{@"goodsTemplateId":goodsTemplateId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarOutSideColorModel_outColorDataList class] json:[request.responseBody objectForKey:@"datalist"]];
        NSMutableArray *colorArr = [NSMutableArray array];
        for (UCarBCarOutSideColorModel_outColorDataList *model in dataSource) {
            [colorArr addObject:model.inColor];
        }
        successBloce(colorArr);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


@end
