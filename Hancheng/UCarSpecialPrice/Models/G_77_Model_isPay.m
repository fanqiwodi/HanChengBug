//
//  G_77_Model_isPay.m
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "G_77_Model_isPay.h"

@implementation G_77_Model_isPay

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"specialList" : [G_77_Model_isPay_son1 class]};
}


@end

@implementation G_77_Model_isPay_son1

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"value" : [G_77_Model_isPay_son2 class]};
}

@end

@implementation G_77_Model_isPay_son2



@end