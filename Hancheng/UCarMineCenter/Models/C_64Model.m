//
//  C_64Model.m
//  Hancheng
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_64Model.h"

@implementation C_64Model
WHYCodingImplementation
+ (instancetype)findMaskBox
{
    
    C_64Model *bossReturn = [NSKeyedUnarchiver unarchiveObjectWithFile:RETURNPATH(@"c64Model.model")];
    return bossReturn;
}

+ (NSString *)findPhone
{
    NSString *phone = [C_64Model findMaskBox].phone;
    return phone;
}
@end
 