//
//  CarBandThirdModel.m
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarBandThirdModel.h"

@implementation CarBandThirdModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datalist" : CarBandThirdModel1.class};
}

@end

@implementation CarBandThirdModel1

-(NSComparisonResult)comparePerson:(CarBandThirdModel1 *)person{
    //默认按年龄排序
    
    NSNumber *num = [NSNumber numberWithString:person.price];
    NSNumber *num1 = [NSNumber numberWithString:self.price];
    NSComparisonResult result = [num1 compare:num];
    //如果年龄一样，就按照名字排序
    
    return result;
}


@end