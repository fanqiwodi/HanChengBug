//
//  Right1TableViewCell.h
//  Hancheng
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Right1TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (assign, nonatomic) BOOL isClick;

@property (nonatomic, strong) NSString *str;

@property (nonatomic, assign) BOOL multiSelect;

@end
