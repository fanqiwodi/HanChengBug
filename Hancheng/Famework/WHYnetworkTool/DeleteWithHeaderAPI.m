//
//  DeleteWithHeaderAPI.m
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DeleteWithHeaderAPI.h"

@implementation DeleteWithHeaderAPI
{
    NSDictionary *_dic;
    NSString *_urlstr;
    MBProgressHUD *hud;
    NSDictionary *headerDictory;
}


- (id)initDeleteWith:(NSDictionary *)bodyDic header:(NSDictionary *)headerDic urlStr:(NSString *)urlstr
{
    if (self = [super init]) {
        _dic = bodyDic;
        _urlstr = urlstr;
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
    return headerDictory;
}

- (NSString *)requestUrl
{
    return _urlstr;
}

- (id)requestArgument {
    
    
    return _dic;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodDelete;
}

- (void)requestFailedFilter
{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"网络连接出错";
    [hud hide:YES afterDelay:0.5];
    
}
- (void)requestCompleteFilter
{
    [hud hide:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"fractionCompleted"])
    {
        hud.progress = 1;
        [hud hide:YES afterDelay:2];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

- (NSDictionary *)responseDic {
    
    NSData *data = [self responseData];
    
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:data.length];
    [progress addObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) options:NSKeyValueObservingOptionInitial context:nil];
    
    return  [self responseBody];
    
}


@end
