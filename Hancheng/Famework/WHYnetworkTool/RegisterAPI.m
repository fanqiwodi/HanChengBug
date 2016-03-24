//
//  RegisterAPI.m
//  WHYNetworkTool
//
//  Created by 王宏洋 on 15/11/6.
//  Copyright © 2015年 王宏洋. All rights reserved.
//

#import "RegisterAPI.h"
#import "BaseModel.h"
@implementation RegisterAPI
{
 
    MBProgressHUD *hud;
    NSString *_url;
}

- (id)initWithUsername:(NSString *)username Withpassword:(NSString *)pwd Withphone:(NSString *)phone
{
    if (self = [super init]) {
        
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        hud = [[MBProgressHUD alloc] initWithWindow:window];
        hud.removeFromSuperViewOnHide = YES;
        [window addSubview:hud];
        hud.delegate = self;
        hud.color = [UIColor orangeColor];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.progress = 0;
        [hud show:YES];
        _url = @"/api/ucarregist/InsertMember";
        _username = username;
        _password = pwd;
        _phone = phone;
    }
    return self;
}

- (NSTimeInterval)requestTimeoutInterval
{
    // 超时设置
    return 15;
}

- (NSString *)requestUrl
{
    return _url;
}

- (id)requestArgument {
    return @{
             @"user_name": _username,
             @"password": _password,
             @"phone":_phone
             };
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (void)requestFailedFilter
{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"网络连接出错";
    [hud hide:YES afterDelay:0.5];
    
}

- (void)requestCompleteFilter
{
    BaseModel *bsModel = [BaseModel modelWithJSON:self.responseBody];
    if ([bsModel.code isEqualToNumber:@0]) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"注册成功";
        [hud hide:YES afterDelay:3];
    } else if ([bsModel.code isEqualToNumber:@1]) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = bsModel.msg;
        [hud hide:YES afterDelay:3];
    }
    
    
}

//验证返回类型
//- (id)jsonValidator {
//    return @{
//             @"userId": [NSNumber class],
//             @"nick": [NSString class],
//             @"level": [NSNumber class]
//             };
//}





@end
