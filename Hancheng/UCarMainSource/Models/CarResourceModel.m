//
//  CarResourceModel.m
//  Hancheng
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarResourceModel.h"


@implementation CarResourceModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datalist" : CarResourceModelChlid1.class};
}
@end

@implementation CarResourceModelChlid1

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"value" : CarResourceModelChlid2.class};
}

@end

@implementation CarResourceModelChlid2

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}

@end

