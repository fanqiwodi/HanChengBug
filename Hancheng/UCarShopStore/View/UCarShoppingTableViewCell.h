//
//  UCarShoppingTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarShoppingMainViewModel.h"
typedef void(^ChooseID) (NSNumber *chooseID, NSString *title);

@interface UCarShoppingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageIndex1; /**< 内外饰图片*/
@property (weak, nonatomic) IBOutlet UILabel *LabelIndex1;

@property (weak, nonatomic) IBOutlet UIImageView *imageIndex2; /**< 性能图片*/
@property (weak, nonatomic) IBOutlet UILabel *LabelIndex2;

@property (weak, nonatomic) IBOutlet UIImageView *imageIndex3; /**< 养护品图片*/
@property (weak, nonatomic) IBOutlet UILabel *LabelIndex3;

@property (weak, nonatomic) IBOutlet UIImageView *imageIndex4; /**< 更多*/
@property (weak, nonatomic) IBOutlet UILabel *LabelIndex4;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) ChooseID chooseTypeID;

@end

