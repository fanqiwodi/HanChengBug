//
//  MessageTableViewCell.h
//  Hancheng
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *backView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *kindL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (nonatomic, strong)NSDictionary *dic;

@end
