//
//  CarBandSecondModel.m
//  Hancheng
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarBandSecondModel.h"

@implementation CarBandSecondModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datalist" : CarBandSecondModel1.class};
}


@end

@implementation CarBandSecondModel1

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}

@end