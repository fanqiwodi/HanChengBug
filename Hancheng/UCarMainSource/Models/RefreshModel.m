//
//  RefreshModel.m
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RefreshModel.h"

@implementation RefreshModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datalist" : RefreshModel1.class};
}
@end

@implementation RefreshModel1

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}


@end