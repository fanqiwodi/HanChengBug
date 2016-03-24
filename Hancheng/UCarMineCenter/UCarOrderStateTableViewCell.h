//
//  UCarOrderStateTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarOrderStateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderDetailCarState;
@property (weak, nonatomic) IBOutlet UILabel *orderDetailTimeLabel;

@property (nonatomic, assign) NSInteger pageState; // 0第一个不是当前 1过程中不是当前 2第一个为当前 3过程中为当前 4底部 5只有一个当前 6底部为当前


//这个类写复杂了, 原因是以为这个进度条是动态的, 会走一半之类的. 没想到只有顶部是红色. NND
@end
