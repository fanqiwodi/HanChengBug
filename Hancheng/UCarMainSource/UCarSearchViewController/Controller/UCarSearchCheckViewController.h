//
//  UCarSearchCheckViewController.h
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ BlockParams) (NSMutableDictionary *params, NSMutableArray *nameArray);
@interface UCarSearchCheckViewController : UIViewController

@property (nonatomic, strong) NSString *keyWord;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, copy) BlockParams blockParams;

- (void)setClearAction;

@end
