//
//  UCarBHaveSendModelDetail.m
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBHaveSendModelDetail.h"

@implementation UCarBHaveSendModelDetail

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" :UCarBHaveSendModelDetail_data.class};
}

@end

@implementation UCarBHaveSendModelDetail_data

- (NSDictionary *)makeValueForKeys
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:30];
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        NSString *new = [strName substringWithRange:NSMakeRange(1, strName.length-1)];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [dic setValue:value forKey:new];
    }
    free(ivar);
    
    return dic;
}

@end

