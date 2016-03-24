//
//  C_58_infoModel.m
//  Hancheng
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_58_infoModel.h"


@implementation C_58_infoModel
WHYCodingImplementation



+ (instancetype)findMaskBox
{

    C_58_infoModel *bossReturn = [NSKeyedUnarchiver unarchiveObjectWithFile:RETURNPATH(@"modelc58.model")];
    return bossReturn;
}


+ (NSNumber *)findIsPay
{
    NSNumber *isPay = [C_58_infoModel findMaskBox].is_pay;
    return isPay;
}


+ (BOOL)identifyRoleOfCus
{
    NSString *roleStr = [C_58_infoModel findMaskBox].role_id;
    NSArray *tempArr = [roleStr componentsSeparatedByString:@","];
    BOOL result = NO;

    for (NSString *role in tempArr) {
        if ([role isEqualToString:@"1"] || [role isEqualToString:@"3"]) {
            result = YES;
        }
        if ([role isEqualToString:@"2"] || [role isEqualToString:@"4"]) {
            result = NO;
        }
    
    }
    
    return result;
}




@end

