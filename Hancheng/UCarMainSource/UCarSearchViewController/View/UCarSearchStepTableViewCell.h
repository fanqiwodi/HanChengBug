//
//  UCarSearchStepTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarSearchStepTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) NSInteger pageState; //1选中 0 未选中
@end
