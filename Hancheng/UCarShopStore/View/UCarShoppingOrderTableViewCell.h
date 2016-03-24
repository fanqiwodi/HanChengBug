//
//  UCarShoppingOrderTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarShoppingMainViewSectionF25.h"
#import "UIImageView+WebCache.h"

@interface UCarShoppingOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodTimeLabel;

@property (nonatomic, strong) UCarShoppingMainViewSectionF25_datalist *model;

@end
