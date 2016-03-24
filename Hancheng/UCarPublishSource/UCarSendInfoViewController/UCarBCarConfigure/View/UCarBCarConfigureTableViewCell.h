//
//  UCarBCarConfigureTableViewCell.h
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarBCarConfigureTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@property (nonatomic, strong)NSString *is_Use;

@end
