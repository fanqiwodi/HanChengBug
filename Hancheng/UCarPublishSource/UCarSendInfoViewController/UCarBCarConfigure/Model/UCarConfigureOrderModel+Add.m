//
//  UCarConfigureOrderModel+Add.m
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarConfigureOrderModel+Add.h"

@implementation UCarConfigureOrderModel (Add)

+(void)GETBrightPackageListAllbrightPackageId:(NSString *)brightPackageId success:(CompletionBlock)successBlk failure:(FailureBlock)falureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B49CARLIGHTSPOTDETAIL WithParamDic:@{@"brightPackageId":brightPackageId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"%@", request.responseBody);
        NSArray *tempArray = [NSArray modelArrayWithClass:[UCarConfigureOrderModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        NSMutableArray *datasource = [NSMutableArray array];
        for (UCarConfigureOrderModel_datalist *model in tempArray) {
            [datasource addObject:model];
        }
        successBlk(datasource);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

@end
