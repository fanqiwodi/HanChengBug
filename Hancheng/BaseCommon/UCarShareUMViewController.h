//
//  UCarShareUMViewController.h
//  Hancheng
//
//  Created by Tony on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarShareUMViewController : UIViewController

- (void)initwithTitle:(NSString *)title image:(UIImageView *)imageView htmlURL:(NSString *)url messageString:(NSString *)messageString;
- (void)pageState:(NSInteger)pageText;
@end
