//
//  PutWithHeaderAPI.m
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PutWithHeaderAPI.h"

@implementation PutWithHeaderAPI
{
    NSDictionary *_dic;
    NSString *_urlStr;
    NSDictionary *_header;
    MBProgressHUD *_hud;
}

- (id)initWith:(NSDictionary *)bodyDic urlStr:(NSString *)urlstr header:(NSDictionary *)headerdic
{
    if (self = [super init]) {
        _dic = bodyDic;
        _urlStr = urlstr;
        _header =  headerdic;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        _hud = [[MBProgressHUD alloc] initWithWindow:window];
        _hud.removeFromSuperViewOnHide = YES;
        [window addSubview:_hud];
        _hud.delegate = self;
        
        _hud.labelText = @"数据正在加载中...";
        _hud.labelColor = [UIColor colorWithHexString:@"#A1A1AC"];
        _hud.labelFont = [UIFont systemFontOfSize:15];
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.progress = 0;
        YYImage *img = [YYImage imageNamed:@"loadingGIF"];
        YYAnimatedImageView *imgV = [[YYAnimatedImageView alloc] initWithImage:img];
        imgV.height = 80;
        imgV.width = 80;
        _hud.customView = imgV;
        _hud.progress = 0;
        _hud.color = [UIColor clearColor];
        [_hud show:YES];
    }
    return self;
}


- (id)initWith:(NSDictionary *)bodyDic urlStr:(NSString *)urlstr
{
    if (self = [super init]) {
        _dic = bodyDic;
        _urlStr = urlstr;
        _header =  nil;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        _hud = [[MBProgressHUD alloc] initWithWindow:window];
        _hud.removeFromSuperViewOnHide = YES;
        [window addSubview:_hud];
        _hud.delegate = self;
        _hud.labelText = @"数据正在加载中...";
        _hud.labelColor = [UIColor colorWithHexString:@"#A1A1AC"];
        _hud.labelFont = [UIFont systemFontOfSize:15];
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.progress = 0;
        YYImage *img = [YYImage imageNamed:@"loadingGIF"];
        YYAnimatedImageView *imgV = [[YYAnimatedImageView alloc] initWithImage:img];
        imgV.height = 80;
        imgV.width = 80;
        _hud.customView = imgV;
        _hud.progress = 0;
        _hud.color = [UIColor clearColor];
        [_hud show:YES];
    }
    return self;
}
- (NSTimeInterval)requestTimeoutInterval
{
    // 超时设置
    return 15;
}

- (id)requestArgument {
    
    
    return _dic;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    
    return _header;
}

- (NSString *)requestUrl
{
    return _urlStr;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPut;
}


- (void)requestCompleteFilter
{
    
    [_hud hide:YES];
}

- (void)requestFailedFilter
{
    _hud.mode = MBProgressHUDModeText;
    _hud.labelText = @"网络连接出错";
    [_hud hide:YES afterDelay:0.5];
    
}
@end
