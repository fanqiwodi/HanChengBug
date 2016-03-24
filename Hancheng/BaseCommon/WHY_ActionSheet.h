//
//  WHY_ActionSheet.h
//  Hancheng
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kSelectionCellHeight 58
#define KSelectionViewMaxHeight 320

typedef NS_ENUM(NSInteger, WHYSelectionKind) {
    KindOfLikeTable = 0,
    KindOfLikeCollection // 还没有时间加，
};

@protocol WHYSelectionItemsProtocol <NSObject>

@required
- (void)addItemWithLabelText:(NSString *)labelText imageName:(NSString *)imageName shouldDismiss:(BOOL)shouldDismiss;

@end


@interface WHYSelectionView : UIView

+ (void)showWithItemsBlock:(void (^)(id <WHYSelectionItemsProtocol> items))itemsBlock selectedBlock:(void (^)(NSInteger selectedTag))selectedBlock setKind:(WHYSelectionKind)kind;

@end
