//
//  GetWithHeader.m
//  WHYNetworkTool
//
//  Created by 王宏洋 on 15/11/7.
//  Copyright © 2015年 王宏洋. All rights reserved.
//

#import "GetWithHeaderAPI.h"
#import "BaseModel.h"
#import "YYKit.h"
#import "YTKNetworkAgent.h"

@implementation GetWithHeaderAPI
{
    NSString *_url;
    MBProgressHUD *hud;
    NSDictionary *headerDictory;
    NSDictionary *_paramDic;
}

- (id)initWithUrl:(NSString *)url WithParamDic:(NSDictionary *)param
{
    if (self = [super init]) {
        _url = url;
        _paramDic = param;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        hud = [[MBProgressHUD alloc] initWithWindow:window];
        hud.removeFromSuperViewOnHide = YES;
        [window addSubview:hud];
        hud.delegate = self;
        hud.labelText = @"数据正在加载中...";
        hud.labelColor = [UIColor colorWithHexString:@"#A1A1AC"];
        hud.labelFont = [UIFont systemFontOfSize:15];
        hud.mode = MBProgressHUDModeCustomView;
        YYImage *img = [YYImage imageNamed:@"loadingGIF"];
        YYAnimatedImageView *imgV = [[YYAnimatedImageView alloc] initWithImage:img];
        imgV.height = 80;
        imgV.width = 80;
        hud.customView = imgV;
        hud.progress = 0;
        hud.color = [UIColor clearColor];
        [hud show:YES];        
    }
    return self;
}



- (id)initWithUrl:(NSString *)url
{
    if (self = [super init]) {
        _url = url;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        hud = [[MBProgressHUD alloc] initWithWindow:window];
        hud.removeFromSuperViewOnHide = YES;
        [window addSubview:hud];
        hud.delegate = self;
        hud.labelText = @"数据正在加载中...";
        hud.labelColor = [UIColor colorWithHexString:@"#A1A1AC"];
        hud.labelFont = [UIFont systemFontOfSize:15];
        hud.mode = MBProgressHUDModeCustomView;
        YYImage *img = [YYImage imageNamed:@"loadingGIF"];
        YYAnimatedImageView *imgV = [[YYAnimatedImageView alloc] initWithImage:img];
        imgV.height = 80;
        imgV.width = 80;
        hud.customView = imgV;
        hud.progress = 0;
        hud.color = [UIColor clearColor];
        [hud show:YES];
    }
    return self;
}


- (id)initWithUrl:(NSString *)url header:(NSDictionary *)headerDic
{
    self = [super init];
    if (self) {
        _url = url;
        headerDictory = headerDic;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        hud = [[MBProgressHUD alloc] initWithWindow:window];
        hud.removeFromSuperViewOnHide = YES;
        [window addSubview:hud];
        hud.labelText = @"数据正在加载中...";
        hud.labelColor = [UIColor colorWithHexString:@"#A1A1AC"];
        hud.labelFont = [UIFont systemFontOfSize:15];
        hud.mode = MBProgressHUDModeCustomView;
        hud.progress = 0;
        YYImage *img = [YYImage imageNamed:@"loadingGIF"];
        YYAnimatedImageView *imgV = [[YYAnimatedImageView alloc] initWithImage:img];
        imgV.height = 80;
        imgV.width = 80;
        hud.customView = imgV;
        hud.progress = 0;
        hud.color = [UIColor clearColor];
        [hud show:YES];

   
    }
    return self;
}

- (NSTimeInterval)requestTimeoutInterval
{
    // 超时设置
    return 15;
}


- (NSDictionary *)requestHeaderFieldValueDictionary
{
    // 获取header 暂未处理
    return [UserMangerDefaults UidGet].length != 0 ? @{@"Uid":[UserMangerDefaults UidGet]} : nil;
}

- (NSString *)requestUrl
{
    // 获取网址;
    return _url;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

- (void)requestCompleteFilter
{
    BaseModel *bsModel = [BaseModel modelWithJSON:self.responseBody];
//
//    
    NSLog(@"code:%@   msg:%@", bsModel.code,bsModel.msg);
    [super requestCompleteFilter];
    [hud hide:YES];
}
- (void)requestFailedFilter
{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"网络连接出错";

    [hud hide:YES afterDelay:0.5];
    

}






- (id)requestArgument {
    
    
    return _paramDic;
}




@end
