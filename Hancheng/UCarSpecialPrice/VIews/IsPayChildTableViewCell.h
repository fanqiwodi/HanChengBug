//
//  IsPayChildTableViewCell.h
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G_78_Model.h"
#import "G_77_Model.h"
@interface IsPayChildTableViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *img;

@property (strong, nonatomic)  UILabel *name;
@property (strong, nonatomic)  UILabel *shorName;
@property (strong, nonatomic)  UILabel *guide_low;
@property (strong, nonatomic)  UILabel *lowPirce;

@property (strong, nonatomic)  UIImageView *gradual;

@property (strong, nonatomic)  UIImageView *lockImgbd;

@property (nonatomic, strong)G_78_Model_son *model;

@property (nonatomic, strong)G_77_Model_son *modelG77;

@end
