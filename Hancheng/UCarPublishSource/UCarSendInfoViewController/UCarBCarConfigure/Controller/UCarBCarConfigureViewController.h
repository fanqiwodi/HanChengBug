//
//  UCarBCarConfigureViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockData) (NSString *name, NSMutableString *namePageIDs, NSMutableString *nameIDs, NSString *configDiyString);

@interface UCarBCarConfigureViewController : UIViewController

@property (nonatomic, copy) BlockData blkData;
@property (nonatomic, strong) NSNumber *goodsTemplateId;


@end
