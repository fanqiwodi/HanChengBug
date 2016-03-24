//
//  RegisterAPI.h
//  WHYNetworkTool
//
//  Created by 王宏洋 on 15/11/6.
//  Copyright © 2015年 王宏洋. All rights reserved.
//

#import "YTKRequest.h"
#import "MBProgressHUD.h"
@interface RegisterAPI : YTKRequest<MBProgressHUDDelegate>
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *phone;

- (id)initWithUsername:(NSString *)username Withpassword:(NSString *)pwd Withphone:(NSString *)phone;


@end
