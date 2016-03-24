//
//  BuyorSellOrderTableViewCell.h
//  Hancheng
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyorSellOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderL;
@property (weak, nonatomic) IBOutlet UILabel *tagL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *dealAndDeposit;

@end
