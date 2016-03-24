//
//  UserMangerDefaults.h
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
@interface UserMangerDefaults : NSObject
@property (nonatomic, strong)NSString *my;
@property (nonatomic, strong)RACSignal *sig;

- (instancetype)shareInstache;
+ (NSString *)UidGet;
+ (BOOL)is_Login;
+ (NSString *)md5:(NSString *)input;
+ (BOOL)checkPassword;
+ (void)saveUserName:(NSString *)userName password:(NSString*)password; /**< 未经MD5加密*/
+ (void)GetUserPageState:(NSDictionary *)userInfoDictory;

@end
