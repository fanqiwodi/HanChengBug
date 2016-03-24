//
//  UCarShoppingMoreInfoTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarShoppingMainViewModel.h"

typedef void(^ChooseID) (NSNumber *chooseID, NSString *title);
@interface UCarShoppingMoreInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *personMadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *personMadeSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *carCuringLabel;
@property (weak, nonatomic) IBOutlet UILabel *carCuringSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPerformanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPerformanceSecondLabel;

@property (nonatomic, copy) ChooseID chooseIDAndName;
@property (nonatomic, strong) NSArray *dataSource;

@end
