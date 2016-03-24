//
//  UCarBDocumentViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DocumentInfo) (NSString *documentName, NSNumber *valueID);
@interface UCarBDocumentViewController : UIViewController

@property (nonatomic, strong)NSString *carSourceCategoryId;
@property (nonatomic, copy) DocumentInfo documentListBlock;

@end
