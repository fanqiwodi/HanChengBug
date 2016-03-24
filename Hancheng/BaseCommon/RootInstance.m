//
//  RootInstance.m
//  Hancheng
//
//  Created by apple on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RootInstance.h"
#import "ReactiveCocoa.h"
#import <objc/runtime.h>
@interface RootInstance()

@end
@implementation RootInstance

+ (RootInstance *)shareRootInstance
{
    static RootInstance *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RootInstance alloc] init];
        instance.rootDic = [NSMutableDictionary dictionary];
    
        });

    return instance;
    
}


- (void)setMutableValue:(id)mutableValue
{
    if (_mutableValue != mutableValue) {
        _mutableValue = mutableValue;
        unsigned int count;
     Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i < count-1; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            
            NSString *new = [strName substringWithRange:NSMakeRange(1, strName.length-1)];
            [[RootInstance shareRootInstance].rootDic setValue:mutableValue forKey:new];

            
            NSData *data = [mutableValue dataUsingEncoding:NSUTF8StringEncoding];
            NSString *myStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           [[RootInstance shareRootInstance].rootDic setValue:mutableValue forKey:myStr];
        }
        free(ivar);
        
    }
}

- (void)privateWay;
{

    
}


- (void)removeValueforKey:(NSString *)key
{
    [[RootInstance shareRootInstance].rootDic removeObjectForKey:key];
}

@end

