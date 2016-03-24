//
//  ShoppingNetwork.m
//  Hancheng
//
//  Created by Tony on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingNetwork.h"

#import "UCarShoppingMainViewModel.h" // 主页Model
#import "UCarShoppingMainViewSectionF25.h" //分页热门数据
#import "UCarBGetGoodsPartsDetailsF29.h"   // 配件详情
#import "UCarBGetGoodsPartsListF74.h"      // F74/75配件列表

@implementation ShoppingNetwork

+ (void)GetShopMainViewData:(CompletionBlock)successBlock failure:(FailureBlock)failureBlock
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:F21CARSHOPPINGCENTER];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        UCarShoppingMainViewModel_data *data = [UCarShoppingMainViewModel_data modelWithDictionary:[request.responseBody objectForKey:@"data"]];
        NSLog(@"++ %@, %@",data.parentGoodsPartsCategory, data.hotGoodsParts);
        NSArray *dataSourceSectionOne = [data.parentGoodsPartsCategory mutableCopy];
        NSArray *dataSourceSectionTwo = [data.hotGoodsParts mutableCopy];
        
        NSMutableArray *blockArray = [NSMutableArray arrayWithObjects:@[dataSourceSectionOne],@[dataSourceSectionTwo], nil];
        successBlock(blockArray);
    } failure:^(YTKBaseRequest *request) {
        
        failureBlock(request.responseBody);
    }];
}


+ (void)GetShopMainViewSectionData:(CompletionBlock)successBlock failure:(FailureBlock)failureBlock pageSize:(NSInteger)pageSize
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:F25CARSHOPPINGSECTIONCENTER WithParamDic:@{@"pageSize":@"10",@"startNum":[NSString stringWithFormat:@"%ld",(long)pageSize]}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarShoppingMainViewSectionF25_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (UCarShoppingMainViewSectionF25_datalist *model in dataSource) {
            [tempArray addObject:model];
        }
        successBlock(tempArray);
        
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request.responseBody);
    }];
}



+ (void)GETGoodsPartsDetailsID:(NSNumber *)partID successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    // F29
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:F29UCARGOODSPARTSDETAILS WithParamDic:@{@"id":partID}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        UCarBGetGoodsPartsDetailsF29_data *model =  [UCarBGetGoodsPartsDetailsF29_data modelWithDictionary:[request.responseBody objectForKey:@"data"]];
        successBlk(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
}


+ (void)GETGoodsPartsCategoryChildParentID:(NSNumber *)parentID successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:F73GETGOODSPARTSCATEGORYCHILD WithParamDic:@{@"parentId":parentID}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *BlkDic = request.responseBody;
        successBlk(BlkDic);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
}


+ (void)GETUCarMarkerGoodSPartsListParams:(NSDictionary *)params successBlk:(CompletionBlock)successBlk faliureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:F74GETGOODSPARTSLIST WithParamDic:params];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempData = [NSArray modelArrayWithClass:[UCarBGetGoodsPartsListF74_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        successBlk(tempData);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
}



+ (void)GETGoodsPartsListAllParams:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:F75GETGOODSPARTSLISTALL WithParamDic:params];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempData = [NSArray modelArrayWithClass:[UCarBGetGoodsPartsListF74_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        NSLog(@"++++ \n %@---- %@",tempData, request.responseBody);
        successBlk(tempData);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
}



+ (void)POSTUCarMarketAddOrdersPartsParams:(NSDictionary *)params HeaderUid:(NSString *)Uid successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:params urlStr:F82UCARADDORDERSPARTS header:@{@"Uid":Uid}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *blkDic = request.responseBody;
        successBlk(blkDic);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
}




@end
