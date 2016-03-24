//
//  UCarShoppingMainViewModel.m
//  Hancheng
//
//  Created by Tony on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarShoppingMainViewModel.h"

@implementation UCarShoppingMainViewModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" :UCarShoppingMainViewModel_data.class};
}


@end


@implementation UCarShoppingMainViewModel_data


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"hotGoodsParts" :UCarShoppingMainViewModel_data_hotGoodsParts.class,
             @"parentGoodsPartsCategory":UCarShoppingMainViewModel_data_parentGoodsPartsCategory.class};
}

@end


@implementation UCarShoppingMainViewModel_data_hotGoodsParts



@end

@implementation UCarShoppingMainViewModel_data_parentGoodsPartsCategory



@end