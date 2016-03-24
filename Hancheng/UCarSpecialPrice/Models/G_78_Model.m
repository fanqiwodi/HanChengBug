//
//  G_78_Model.m
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "G_78_Model.h"

@implementation G_78_Model

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"specialList" : [G_78_Model_son class]};
}

@end


@implementation G_78_Model_son

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}

@end