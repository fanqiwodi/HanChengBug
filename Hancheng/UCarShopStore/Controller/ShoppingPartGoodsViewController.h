//
//  ShoppingPartGoodsViewController.h
//  Hancheng
//
//  Created by Tony on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlkChoosesID) (NSNumber *chooseID, NSString *title);
typedef void(^Blcok) (id body, NSString *title);
@interface ShoppingPartGoodsViewController : UIViewController

@property (nonatomic, strong) NSNumber *partID;
@property (nonatomic, strong) NSString *statuStr;
@property (nonatomic, strong) NSNumber *selectID;
@property (nonatomic, copy) BlkChoosesID chooseIDAndName;
@property (nonatomic, copy) Blcok block;
@end
