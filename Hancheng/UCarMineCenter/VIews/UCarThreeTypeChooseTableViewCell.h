//
//  UCarThreeTypeChooseTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarThreeTypeChooseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *MyCarSourceButton;
@property (weak, nonatomic) IBOutlet UIButton *MyInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *BussinessTip;
@property (nonatomic, assign) NSInteger showMessageDot; // 我的消息小点 1表示显示
@property (nonatomic, assign) NSInteger showBussinessDot; // 交易提醒小点 1表示显示

@end
