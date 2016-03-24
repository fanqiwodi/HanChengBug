//
//  UCarSearchMainTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/objc.h>
@interface UCarSearchMainTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@property (nonatomic, assign) NSInteger pageState; // 1 选中 0 未选中

@end
