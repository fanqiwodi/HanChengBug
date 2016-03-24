//
//  CarbandViewController.m
//  Hancheng
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarbandViewController.h"
#import "CarbandTableViewDataResource.h"
#import "CarBandSecondModel+CarBandAction.h"
#import "CarBandSecondModel.h"

#import "CarbandSecondViewController.h"
@interface CarbandViewController ()
{
    CarBandSecondModel *bandModel;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) CarbandTableViewDataResource *dataResource;

@end

@implementation CarbandViewController

- (void)networkAction
{
    [CarBandSecondModel handleWithSuccessBlock:^(id returnValue) {
        
        bandModel = returnValue;
       
        self.dataResource = [[CarbandTableViewDataResource alloc]initWithIdentifStr:@"why" carBandModel:bandModel callBackBlock:^(id body, id indexPath) {
            NSIndexPath *p = indexPath;
           CarBandSecondModel1 *model1 = [[body objectAtIndex:p.section]objectAtIndex:p.row];
            NSLog(@"-%@-", model1.myID);
            CarbandSecondViewController *secondVC = [[CarbandSecondViewController alloc] init];
    
            secondVC.goodsCategoryIdLevel2 = model1.myID;
            secondVC.title = model1.name;
            [self.navigationController pushViewController:secondVC animated:YES];

        }];
        [self initView];
    } WithFailureBlock:^(id error) {
        
    } BrandId:self.model.id];
}

- (void)initView
{
  
  
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self.dataResource;
    self.myTableView.dataSource = self.dataResource;
    [self.myTableView setTableFooterView:[UIView new]];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"why"];
    self.myTableView.separatorColor = [UIColor colorWithHexString:LINECOLOR];
    [self.view addSubview:self.myTableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self networkAction];
    // Do any additional setup after loading the view.
}


// 隐藏底部bar;
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
