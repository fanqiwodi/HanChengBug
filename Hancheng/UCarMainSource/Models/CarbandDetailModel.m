//
//  CarbandDetailModel.m
//  Hancheng
//
//  Created by why on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarbandDetailModel.h"

@implementation CarbandDetailModel
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"data" : CarbandDetailModel1.class};
//}
@end

@implementation CarbandDetailModel1

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}

@end