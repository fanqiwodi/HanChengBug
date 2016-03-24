//
//  UCarBCarCustomCarInfoTypeViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarCustomCarInfoTypeViewController.h"
#import "UCarSendInforViewController.h"

@interface UCarBCarCustomCarInfoTypeViewController ()

@end

@implementation UCarBCarCustomCarInfoTypeViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"自定义车型";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [super viewWillAppear:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndBack:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)saveAndBack:(UIBarButtonItem *)button
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSDictionary *postDic = @{@"goodsCategoryIdLevel2":self.goodsCategoryIdLevel2,@"carSourceCategoryId":self.carSourceCategoryId,@"brandId":self.brandID,@"goodsCategoryIdLevel1":self.goodsCategoryIdLevel1};
    [center postNotificationName:CENTERCARTYPE object:self.customTestField.text userInfo:postDic];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
