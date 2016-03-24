//
//  PostWithHeaer.h
//  WHYNetworkTool
//
//  Created by 王宏洋 on 15/11/7.
//  Copyright © 2015年 王宏洋. All rights reserved.
//

#import "YTKRequest.h"
#import "MBProgressHUD.h"
@interface PostWithHeaderAPI : YTKRequest<MBProgressHUDDelegate>
- (id)initWith:(NSDictionary *)bodyDic urlStr:(NSString *)urlstr;
- (id)initWith:(NSDictionary *)bodyDic urlStr:(NSString *)urlstr header:(NSDictionary *)headerdic;
//可根据需要直接处理成需要的数据类型
- (NSDictionary *)responseDic;

@end
