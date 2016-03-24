//
//  LiftTableViewCell.h
//  Hancheng
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiftTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *bottomL;
@property (weak, nonatomic) IBOutlet UIButton *topB;

@property (nonatomic, weak) NSString *str;


@end
