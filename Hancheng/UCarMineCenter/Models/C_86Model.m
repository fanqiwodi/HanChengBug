//
//  C_86Model.m
//  Hancheng
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "C_86Model.h"

@implementation C_86Model
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderStatus" : [C_86ModelChild class]};
}
@end

@implementation C_86ModelChild


@end