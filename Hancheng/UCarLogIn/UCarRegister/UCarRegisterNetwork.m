//
//  UCarRegisterNetwork.m
//  Hancheng
//
//  Created by Tony on 16/1/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarRegisterNetwork.h"

@implementation UCarRegisterNetwork

// * 短信验证
+ (void)POSTAddRegisterMember:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk
{
    PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:params urlStr:D31CARREGISTERPHONENUMBER];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if (request.responseBody) {
            NSNumber *code = [request.responseBody objectForKey:@"code"];
            NSLog(@"%@",request.responseBody);
            successBlk(code);
        }
    } failure:^(YTKBaseRequest *request) {
        failBlk(request.responseBody);
    }];
}

// *  选择角色后分类注册
+ (void)POSTAddMemberChooseType:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk
{
    PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:params urlStr:D32CARREGISTERCHOOSTTYPE];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *blkDic = request.responseBody;
            successBlk(blkDic);
    } failure:^(YTKBaseRequest *request) {
        failBlk(request.responseBody);
    }];
}

// * 用户查询API
+ (void)POSTAddMemberLogin:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk
{
    PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:params urlStr:E18CARLOGINCHECK];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {

            NSDictionary *blkDic = request.responseBody;
            successBlk(blkDic);

    } failure:^(YTKBaseRequest *request) {
        failBlk(request.responseBody);
    }];
}

// * 找回密码
+ (void)PUTediMemberPassword:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk
{
    PutWithHeaderAPI *api = [[PutWithHeaderAPI alloc] initWith:params urlStr:E72CARFINDPASSWORD];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *resultDic = request.responseBody;
        successBlk(resultDic);
    } failure:^(YTKBaseRequest *request) {
        failBlk(request);
    }];
    
}
















@end
