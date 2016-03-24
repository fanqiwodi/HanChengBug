//
//  SelectModel.m
//  Hancheng
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SelectModel.h"


@implementation SelectModel

+ (NSDictionary *)modelContainerPropertyGenericClass {

    return @{@"data" : @"SelectModel1"};
}
@end

@implementation SelectModel1

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sourceP" : selectID_NameModel.class, @"carSourceSpotsId" : selectID_NameModel.class, @"province" : selectID_NameModel.class, @"point" : selectID_NameModel.class, @"sourceS" : selectModel_sourceS.class};
}
@end

@implementation selectID_NameModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}

@end


@implementation selectModel_sourceS

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"value" : selectModel_sourceS_son.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}


@end

@implementation selectModel_sourceS_son

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myID":@"id"};
}

@end

