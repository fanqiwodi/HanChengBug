//
//  UCarHaveSendConfigableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarHaveSendViewController.h"
#import <SKTagView.h>

@class SKTagView;
@interface UCarHaveSendConfigableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet SKTagView *tagView;

@end
