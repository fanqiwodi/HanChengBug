//
//  UCarSearchBothViewController.m
//  Hancheng
//
//  Created by Tony on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSearchBothViewController.h"
#import "UCarSearchMainTableViewCell.h"
#import "UCarSearchStepTableViewCell.h"
#import "UCarSearchConfigMutableSeletedTableViewCell.h"
#import "UCarSearchHeaderView.h"

static NSString *const reuseMainCell = @"UCarSearchMainTableViewCell";
static NSString *const reuseStepCell = @"UCarSearchStepTableViewCell";
static NSString *const reuseMutableCell = @"UCarSearchConfigMutableSeletedTableViewCell";


@interface UCarSearchBothViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;

@property (nonatomic, strong) NSArray *imageNameFlag1Array;
@property (nonatomic, strong) NSArray *imageNameFlag0Array;
@property (nonatomic, strong) UITableView *tableViewMain;
@property (nonatomic, strong) UITableView *tableViewStep;

@end

@implementation UCarSearchBothViewController
{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.bottomHeight.constant = 49;
    self.buttonWidth.constant = 96;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UCarSearchMainTableViewCell *cellMain = [tableView dequeueReusableCellWithIdentifier:reuseMainCell];
    UCarSearchStepTableViewCell *cellStep = [tableView dequeueReusableCellWithIdentifier:reuseStepCell];
    UCarSearchConfigMutableSeletedTableViewCell *cellConfig = [tableView dequeueReusableCellWithIdentifier:reuseMutableCell];
    return cellConfig;
}

#pragma mark ButtonAction
- (IBAction)dismissAction:(id)sender {
}
- (IBAction)clearButtonAction:(id)sender {
}
- (IBAction)sureButtonAction:(id)sender {
}


#pragma mark SET/GET
- (NSMutableDictionary *)params
{
    if (_params == nil) {
        NSMutableDictionary *tempDic = [NSMutableDictionary new];
        _params = tempDic;
    }
    return _params;
}

- (NSMutableArray *)nameArray
{
    if (_nameArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _nameArray = tempArray;
    }
    return _nameArray;
}

- (UITableView *)tableViewMain
{
    if (_tableViewMain == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarSearchMainTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseMainCell];
        _tableViewMain = tempTableView;
    }
    return _tableViewMain;
}

- (UITableView *)tableViewStep
{
    if (_tableViewStep == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = [UIColor whiteColor];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarSearchStepTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseStepCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarSearchConfigMutableSeletedTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseMutableCell];
        _tableViewStep = tempTableView;
    }
    return _tableViewStep;
}
- (NSArray *)imageNameFlag1Array
{
    if (_imageNameFlag1Array == nil) {
        NSArray *tempArray = @[@"icon_filter_car_mode_g",@"icon_filter_color_g",@"icon_filter_color_g",@"icon_filter_car_src_g",@"icon_filter_location_g",@"icon_filter_high_light_g",@"icon_filter_price_g"];
        _imageNameFlag1Array = tempArray;
    }
    return _imageNameFlag1Array;
}
- (NSArray *)imageNameFlag0Array
{
    if (_imageNameFlag0Array == nil) {
        NSArray *tempArray = @[@"icon_filter_car_mode_g",@"icon_filter_color_g",@"icon_filter_color_g",@"icon_filter_car_src_g",@"icon_filter_location_g",@"icon_filter_price_g"];
        _imageNameFlag0Array = tempArray;
    }
    return _imageNameFlag0Array;
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
