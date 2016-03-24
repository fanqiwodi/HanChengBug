//
//  UCarBInfoChooseTypeModel+UCarBInfoChooseTypeModeAdd.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBInfoChooseTypeModel+UCarBInfoChooseTypeModeAdd.h"

@implementation UCarBInfoChooseTypeModel (UCarBInfoChooseTypeModeAdd)

+ (void)GETUCarBInfoChooseType:(CompletionBlock)successBlock failure:(FailureBlock)failBlock carSourceCategoryId:(NSString *)carSourceCategoryId userID:(NSString *)uid
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B20CARINFORQUERY WithParamDic:@{@"carSourceCategoryId":carSourceCategoryId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *tempArray = [NSArray modelArrayWithClass:[UCarBInfoChooseTypeModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        
        successBlock(tempArray);
    } failure:^(YTKBaseRequest *request) {
        failBlock(request.responseBody);
    }];
}


@end
