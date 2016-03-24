//
//  UCarBCarConfigureDetailTableViewCell.h
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarBCarConfigureDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIControl *showDetail;
@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic, strong)NSString *is_Use;

@end
