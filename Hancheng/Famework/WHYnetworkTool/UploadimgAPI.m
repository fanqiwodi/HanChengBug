//
//  UploadimgAPI.m
//  WHYNetworkTool
//
//  Created by 王宏洋 on 15/11/7.
//  Copyright © 2015年 王宏洋. All rights reserved.
//

#import "UploadimgAPI.h"




@implementation UploadimgAPI


{
    UIImage *_image;
    NSString *_url;
    NSString *_fileName;
    
    MBProgressHUD *hud;
}

- (id)initWithImage:(UIImage *)image withFileName:(NSString *)name
{
    if (self = [super init]) {
        _image = image;
        _url = @"/api/ucarupload/uploadImage";
        _fileName = name;
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
        [hud show:YES];       }
    return self;
}

- (id)initWithImage:(UIImage *)image withFileName:(NSString *)name withNumber:(NSInteger)imageIndex
{
    if (self = [super init]) {
        _image = image;
        _url = @"/api/ucarupload/uploadImage";
        _fileName = name;
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

- (NSTimeInterval)requestTimeoutInterval
{
    // 超时设置
    return 15;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl
{
    return _url;
}

// 监听进度条
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"fractionCompleted"])
//    {
//        hud.progress = 1;
//        [hud hide:YES];
//    }
//    else
//    {
//        [super observeValueForKeyPath:keyPath ofObject:object
//                               change:change context:context];
//    }
//}
//
// 提交表单
- (AFConstructingBlock)constructingBodyBlock
{
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.6f);
        NSString *name = _fileName;
        NSString *formKey = [[NSDate date] stringWithISOFormat];
        NSString *type = @"jpg/png";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}
//
- (void)requestFailedFilter
{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"网络连接出错";
    [hud hide:YES afterDelay:0.5];
    
}

- (void)requestCompleteFilter
{
    BaseModel *bsModel = [BaseModel modelWithJSON:self.responseBody];
    NSLog(@"code:%@   msg:%@", bsModel.code, bsModel.msg);
    hud.progress = 1;
    [hud hide:YES afterDelay:0.5];
//    NSProgress *progress = [NSProgress progressWithTotalUnitCount:[self totalBytesWritten]/1024];
//    [progress addObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) options:NSKeyValueObservingOptionInitial context:nil];
   
}

- (NSString *)result
{

    NSDictionary *data = [self.responseBody objectForKey:@"data"];
    NSString *urlString = [[data objectForKey:@"imageSMURL"] stringByAppendingString:[data objectForKey:@"imgs"]];
    NSString *formateString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return formateString;
}


@end


