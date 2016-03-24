//
//  UCarTableViewSWCell.m
//  Hancheng
//
//  Created by Tony on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarTableViewSWCell.h"

@implementation UCarTableViewSWCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    
    dispatch_async(global, ^{
        if (self.pageType == 1) {
            self.carID = _model.id;
            self.UCarRightColorImage.alpha = 0;
        } else {
            self.carID = _model.id;
            self.sort = _model.sort;
        }
        if ([[NSString stringWithFormat:@"%@",_model.price] isEqualToString:@"0"] ) {
            dispatch_async(mainQueue, ^{
                self.UCarPriceLabel.text = @"暂无报价";
            });
        } else {
            dispatch_async(mainQueue, ^{
               self.UCarPriceLabel.text = [NSString stringWithFormat:@"%.2f万",[_model.price floatValue]];
            });
        }
        
        if ([self.sort isEqualToNumber:@0]) {
            dispatch_async(mainQueue, ^{
             self.contentView.backgroundColor = HEXCOLOR(0xfff0e9);
            });
        } else {
            dispatch_async(mainQueue, ^{
            self.contentView.backgroundColor = [UIColor whiteColor];
            });
        }
        
        dispatch_async(mainQueue, ^{
            self.UCarTitleLabel.text = _model.name;
            self.UCarTimeLabel.text = _model.datetime;
        });
        
        self.UCarPriceguideLabel.layer.cornerRadius = 9;
        self.UCarPriceguideLabel.layer.borderColor = GRAYCOLOR;
        self.UCarPriceguideLabel.layer.borderWidth = 0.8;
        
        if ([_model.guidPrice isEqualToString:@""]) {
            dispatch_async(mainQueue, ^{
                self.UCarPriceguideLabel.alpha = 0;
            });
        } else {
           
            dispatch_async(mainQueue, ^{
              self.UCarPriceguideLabel.text = [NSString stringWithFormat:@"    %@    ",_model.guidPrice];
             self.UCarPriceguideLabel.alpha = 1;
            });
        }
        NSMutableString *detailString = [NSMutableString stringWithFormat:@"【%@】",_model.carSourceSpotsName];
        [detailString appendString:[NSString stringWithFormat:@"%@/%@",_model.outsideColor,_model.insideColor]];
        if (_model.proceduresName.length > 1) {
            [detailString appendString:[NSString stringWithFormat:@" | %@",_model.proceduresName]];
        }
        
        if (_model.salesAreaName.length > 1) {
            [detailString appendString:[NSString stringWithFormat:@" | %@",_model.salesAreaName]];
        }
        
        if (_model.carPlace.length > 1) {
            [detailString appendString:[NSString stringWithFormat:@" | %@",_model.carPlace]];
        }
        dispatch_async(mainQueue, ^{
           self.UCarDetailLabel.text = detailString;
        });
        if (_model.imgs.length > 5) {
            self.UCarTitleImageView.alpha = 1;
        } else {
            self.UCarTitleImageView.alpha = 0;
        }
        
    });
}



@end
