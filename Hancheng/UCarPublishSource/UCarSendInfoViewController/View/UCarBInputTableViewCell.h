//
//  UCarBInputTableViewCell.h
//  Hancheng
//
//  Created by Tony on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarBInputTableViewCell : UITableViewCell  <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moreInfoLabel;
@property (weak, nonatomic) IBOutlet UITextView *inPutTextField;

@end
