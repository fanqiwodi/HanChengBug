//
//  UCarOrderDetailSection2HeaderTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarOrderDetailSection2HeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderDetailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;

@property (nonatomic, strong) NSString *orderStateString;
@end
