//
//  UCarMainSourceA10Model.m
//  Hancheng
//
//  Created by Tony on 16/2/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarMainSourceA10Model.h"

@implementation UCarMainSourceA10Model

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"datalist" : UCarMainSourceA10Model_DataList.class};
}
@end

@implementation UCarMainSourceA10Model_DataList

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"value" : UCarMainSourceA10Model_DataList_Value.class};
}
@end

@implementation UCarMainSourceA10Model_DataList_Value
@end