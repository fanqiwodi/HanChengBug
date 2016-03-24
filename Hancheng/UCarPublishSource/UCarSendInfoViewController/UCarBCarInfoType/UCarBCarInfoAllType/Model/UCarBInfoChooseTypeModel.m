//
//  UCarBInfoChooseTypeModel.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBInfoChooseTypeModel.h"

@implementation UCarBInfoChooseTypeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datalist" : UCarBInfoChooseTypeModel_datalist.class};
}

@end


@implementation UCarBInfoChooseTypeModel_datalist

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"value" : UCarBInfoChooseTypeModel_datalist_value.class};
}

@end


@implementation UCarBInfoChooseTypeModel_datalist_value



@end