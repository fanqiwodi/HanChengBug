//
//  DeleteWithHeaderAPI.h
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "YTKRequest.h"

@interface DeleteWithHeaderAPI : YTKRequest<MBProgressHUDDelegate>

- (id)initDeleteWith:(NSDictionary *)bodyDic header:(NSDictionary *)headerDic urlStr:(NSString *)urlstr;

@end
