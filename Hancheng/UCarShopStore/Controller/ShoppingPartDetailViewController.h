//
//  ShoppingPartDetailViewController.h
//  Hancheng
//
//  Created by Tony on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingPartDetailViewController : UIViewController

@property (nonatomic, strong) NSNumber *partDetailID;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (strong, nonatomic) IBOutlet UIControl *phoneConsulting;
@property (strong, nonatomic) IBOutlet UIControl *readyToBuy;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneCallWidth;

@property (nonatomic, assign) BOOL is_show;

@end
