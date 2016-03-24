//
//  G_77_Model.m
//  Hancheng
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "G_77_Model.h"

@implementation G_77_Model
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"specialList" : [G_77_Model_son class]};
}

@end


@implementation G_77_Model_son

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}
@end