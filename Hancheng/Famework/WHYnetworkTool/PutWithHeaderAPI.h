//
//  PutWithHeaderAPI.h
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YTKRequest.h"
#import "MBProgressHUD.h"
@interface PutWithHeaderAPI : YTKRequest<MBProgressHUDDelegate>
- (id)initWith:(NSDictionary *)bodyDic urlStr:(NSString *)urlstr header:(NSDictionary *)headerdic;
- (id)initWith:(NSDictionary *)bodyDic urlStr:(NSString *)urlstr;
@end
