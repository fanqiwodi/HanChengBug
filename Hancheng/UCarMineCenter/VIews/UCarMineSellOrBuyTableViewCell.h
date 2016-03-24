//
//  UCarMineSellOrBuyTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarMineSellOrBuyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *unReadLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomline;
@property (weak, nonatomic) IBOutlet UIView *sepLine;

// 真正有用的
@property (nonatomic, assign) NSInteger lineState;
@property (nonatomic, strong) NSString *unReadString;
@end
