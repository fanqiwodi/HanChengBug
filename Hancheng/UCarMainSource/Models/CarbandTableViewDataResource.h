//
//  CarbandTableViewDataResource.h
//  Hancheng
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarBandSecondModel.h"
typedef void(^returncell) (id cell, id indexPath);
@interface CarbandTableViewDataResource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (id)initWithIdentifStr:(NSString *)str carBandModel:(CarBandSecondModel *)model callBackBlock:(returncell)block;

@end
