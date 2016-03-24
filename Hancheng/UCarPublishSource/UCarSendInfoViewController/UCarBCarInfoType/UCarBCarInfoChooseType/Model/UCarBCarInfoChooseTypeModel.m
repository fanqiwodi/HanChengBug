//
//  UCarBCarInfoChooseTypeModel.m
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseTypeModel.h"

@implementation UCarBCarInfoChooseTypeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datalist" : UCarBCarInfoChooseTypeModel_datalist.class};
}

@end

@implementation UCarBCarInfoChooseTypeModel_datalist

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"value" : UCarBCarInfoChooseTypeModel_datalist_value.class};
}

@end

@implementation UCarBCarInfoChooseTypeModel_datalist_value


@end