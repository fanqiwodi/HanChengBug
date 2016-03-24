//
//  UploadimgAPI.h
//  WHYNetworkTool
//
//  Created by 王宏洋 on 15/11/7.
//  Copyright © 2015年 王宏洋. All rights reserved.
//

#import "YTKRequest.h"
#import "MBProgressHUD.h"
#import "BaseModel.h"
@interface UploadimgAPI : YTKRequest<MBProgressHUDDelegate>

- (id)initWithImage:(UIImage *)image withFileName:(NSString *)name;
- (id)initWithImage:(UIImage *)image withFileName:(NSString *)name withNumber:(NSInteger)imageIndex;

@property(nonatomic, strong, readonly)NSString *result;

@end
