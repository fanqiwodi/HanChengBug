//
//  UCarBInfoChooseTableViewCell.h
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarBCarInfoChooseTypeModel+UCarBCarInfoChooseTypeModel.h" /**< Model */
#import "SelectModel+SelectModelAction.h"
@interface UCarBInfoChooseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;
@property (nonatomic, strong)UCarBCarInfoChooseTypeModel_datalist_value *model;

@property (nonatomic, strong)selectID_NameModel *ohterModel;
@end
