//
//  UserMangerDefaults.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UserMangerDefaults.h"
#import <CommonCrypto/CommonDigest.h>
#import "UCarRegisterNetwork.h"
#import <libkern/OSAtomic.h>

@interface UserMangerDefaults ()
@end

@implementation UserMangerDefaults


+ (NSString *)UidGet
{
    UCARNSUSERDEFULTS(userDefaults)
    NSString *uid = [userDefaults objectForKey:GETUID];
    if (uid == nil) {
        uid = @"1";
    }
    return uid;
}

+ (BOOL)is_Login
{
    UCARNSUSERDEFULTS(userDefaults)
    BOOL is_log = [userDefaults boolForKey:IS_LOGIN];
    return is_log;
}


+ (NSString *)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

+ (void)saveUserName:(NSString *)userName password:(NSString*)password
{
    UCARNSUSERDEFULTS(userDefaults)
    [userDefaults setObject:userName forKey:USERNAME];
    [userDefaults setObject:password forKey:PASSWORD];
    
}

+ (instancetype)shareInstache
{
   static UserMangerDefaults *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[UserMangerDefaults alloc] init];
    });
    return user;
}

+ (void)GetUserPageState:(NSDictionary *)userInfoDictory
{

}

+ (BOOL)checkPassword
{
    
    dispatch_group_t myGroup = dispatch_group_create();
    dispatch_group_async(myGroup, dispatch_get_main_queue(), ^{
        [UserMangerDefaults shareInstache].sig = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            UCARNSUSERDEFULTS(userDefaults)
            NSString *password = [userDefaults objectForKey:PASSWORD];
            NSString *userName = [userDefaults objectForKey:USERNAME];
            NSDictionary *params = @{@"userName":@"why",@"passWord":@"why",@"sysType":@1};
            
            
            [UCarRegisterNetwork POSTAddMemberLogin:params successBlk:^(id returnValue) {
                NSDictionary *resultDic = returnValue;
                
                NSNumber *codeNumber = [resultDic objectForKey:@"code"];
                if ([codeNumber isEqualToNumber:@0]) {
                    UCARNSUSERDEFULTS(userDefaults);
                    [userDefaults setBool:YES forKey:IS_LOGIN];
                    NSString *uid = [[resultDic objectForKey:@"data"] objectForKey:@"uid"];
                    [userDefaults setObject:uid forKey:GETUID];
                    ;
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:CENTERLOGIN object:nil];
                    
                    
                } else {
                    
                    
                    [subscriber sendNext:@"why"];
                    [subscriber sendCompleted];
                    
                    
                }
            } failuBlk:^(id error) {
                
            }];
            return nil;
        }];
    });

   dispatch_group_notify(myGroup, dispatch_get_main_queue(), ^{
      
       [[UserMangerDefaults shareInstache].sig subscribeNext:^(id x) {
           NSLog(@"---%@    ", x);
         
       }];
      

   });
   
    
    
    return YES;
}


        

@end
