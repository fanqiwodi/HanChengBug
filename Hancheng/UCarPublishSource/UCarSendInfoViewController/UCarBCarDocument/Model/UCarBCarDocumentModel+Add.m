//
//  UCarBCarDocumentModel+Add.m
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarDocumentModel+Add.h"

@implementation UCarBCarDocumentModel (Add)


+ (void)GETDocumentListwithcarSourceCategoryId:(NSString *)carSourceCategoryId success:(CompletionBlock)successBlock failure:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B27CARDOCUMENTLIST WithParamDic:@{@"carSourceCategoryId":carSourceCategoryId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempArray = [NSArray modelArrayWithClass:[UCarBCarDocumentModel_dataList class] json:[request.responseBody objectForKey:@"datalist"]];
        NSMutableArray *dataSource = [NSMutableArray array];
        for (UCarBCarDocumentModel_dataList *model in tempArray) {
            [dataSource addObject:model];
        }
        successBlock(dataSource);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


@end
