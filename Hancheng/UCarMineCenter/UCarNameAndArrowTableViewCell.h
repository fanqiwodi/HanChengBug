//
//  UCarNameAndArrowTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarNameAndArrowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, assign) NSInteger lineState;
@end
