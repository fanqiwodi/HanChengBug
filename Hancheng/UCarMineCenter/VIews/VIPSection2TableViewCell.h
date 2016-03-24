//
//  VIPSection2TableViewCell.h
//  Hancheng
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPSection2TableViewCell : UITableViewCell
@property (nonatomic, strong)NSArray *arr;

@property (weak, nonatomic) IBOutlet UIImageView *fImg;
@property (weak, nonatomic) IBOutlet UILabel *fLabel;

@property (weak, nonatomic) IBOutlet UIImageView *lImg;
@property (weak, nonatomic) IBOutlet UILabel *lLabel;


@end
