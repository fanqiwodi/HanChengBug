//
//  GetWithHeader.h
//  WHYNetworkTool
//
//  Created by 王宏洋 on 15/11/7.
//  Copyright © 2015年 王宏洋. All rights reserved.
//

#import "YTKRequest.h"

@interface GetWithHeaderAPI : YTKRequest<MBProgressHUDDelegate>
- (id)initWithUrl:(NSString *)url;

- (id)initWithUrl:(NSString *)url header:(NSDictionary *)headerDic;

- (id)initWithUrl:(NSString *)url WithParamDic:(NSDictionary *)param;

@end
