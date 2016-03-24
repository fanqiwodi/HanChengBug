//
//  CarbandSecondViewController.m
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarbandSecondViewController.h"
#import "UCarTableViewSWCell.h"
#import "CarBandThirdModel+CarBandThirdModelAction.h"
#import "ReactiveCocoa.h"
#import "SelectViewController.h"
#import <MJRefresh.h>
#import "BaseNavigationViewController.h"
#import "UCarHaveSendViewController.h"

static NSString *cell2 = @"UCarTableViewSWCell";
@interface CarbandSecondViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CarBandThirdModel *model;
    NSMutableDictionary *searchDic;
    UIView *backV;
    UILabel *showL;
    UIButton *clearButton;
    SelectViewController *SVC;
}
@property (nonatomic, strong) UITableView *myTableview;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) BaseNavigationViewController *selectVC;
@property (nonatomic, strong) NSMutableDictionary *postDic;
@property (nonatomic, strong) NSDictionary *showLDic;
@property (nonatomic, assign) NSInteger page;
@end

@implementation CarbandSecondViewController
- (void)moveToView:(UIButton *)button
{
    [self presentViewController:_selectVC animated:YES completion:^{
        
    }];
}
- (void)initBottomButton
{
     WS(weakself);
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bottomButton];
    [self.bottomButton addTarget:self action:@selector(moveToView:) forControlEvents:UIControlEventTouchUpInside];

    [self.bottomButton setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [self.bottomButton setImage:[UIImage imageNamed:@"筛选点击"] forState:UIControlStateHighlighted];
    SVC = [[SelectViewController alloc] init];
    self.selectVC = [[BaseNavigationViewController alloc] initWithRootViewController:SVC];
        SVC.carBandID = self.goodsCategoryIdLevel2;

    
   
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.view.mas_bottom).with.offset(-28*REM);
        make.right.equalTo(weakself.view.mas_right).with.offset(-28*REM);
        make.width.equalTo(@(100*REM));
        make.height.equalTo(@(100*REM));
    }];
}

- (void)getNetAction
{
    searchDic = [NSMutableDictionary dictionary];
    [searchDic setValue:self.goodsCategoryIdLevel2 forKey:@"goodsCategoryIdLevel2"];
    [searchDic setValue:@"/api/ucarshow/getGoodsList" forKey:@"url"];
    [searchDic setValue:@"" forKey:@"carSourceCategoryIdLevel1"];
    [searchDic setValue:@"" forKey:@"carSourceCategoryIdLevel2"];
    [searchDic setValue:[_postDic[@"goodsTemplateId"] isEqualToNumber:@0] ? _postDic[@"goodsTemplateId"] : @"" forKey:@"goodsTemplateId"];
    [searchDic setValue:[_postDic[@"outsideColor"] length] > 0 ? _postDic[@"outsideColor"] : @"" forKey:@"outsideColor"];
    [searchDic setValue:[_postDic[@"carSourceSpotsId"] isEqualToNumber:@0] ? _postDic[@"carSourceSpotsId"] : @""  forKey:@"carSourceSpotsId"];
    [searchDic setValue:[_postDic[@"province"] isEqualToNumber:@0]  ? _postDic[@"province"] : @"" forKey:@"province"];
    [searchDic setValue:[_postDic[@"insideColor"] length] > 0 ? _postDic[@"insideColor"] : @"" forKey:@"insideColor"];
    [searchDic setValue:[_postDic[@"point"] length] > 0 ? _postDic[@"point"] : @"" forKey:@"point"];
    [searchDic setValue:@"1000" forKey:@"pageSize"];
    [CarBandThirdModel handleWithSuccessBlock:^(id returnValue) {
        model = returnValue;
        UIImageView *img = [UIImageView new];
        UILabel *label = [UILabel new];
        if (model.datalist.count == 0) {
            // 处理缺省页面
            [_myTableview addSubview:img];
            [_myTableview addSubview:label];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_myTableview.mas_centerX);
                make.centerY.equalTo(_myTableview.mas_centerY).offset(-15);
            }];
            img.image = [UIImage imageNamed:@"无检索结果"];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(img.mas_centerX);
                make.top.equalTo(img.mas_bottom).offset(10);
            }];
            label.text = @"没有检索到相关车源";
            label.textColor = CARINFORGRAY;
            label.font = [UIFont systemFontOfSize:15];
            self.bottomButton.alpha = 0;
        }

        [_myTableview.mj_header endRefreshing];
        [_myTableview reloadData];
    } WithFailureBlock:^(id error) {
        
    } Param:searchDic];
}



- (void)initTableView
{
   
        self.myTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64) style:UITableViewStylePlain];
        _myTableview.dataSource = self;
        _myTableview.delegate = self;
        _myTableview.backgroundView.backgroundColor = [UIColor colorWithHexString:@"F2F1F4"];
        [_myTableview registerNib:[UINib nibWithNibName:@"UCarTableViewSWCell" bundle:nil] forCellReuseIdentifier:@"UCarTableViewSWCell"];
        _myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_myTableview];
    _myTableview.backgroundColor = BACKGROUNDCOLOR;
       _myTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self getNetAction];
       }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return model.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UCarTableViewSWCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2 forIndexPath:indexPath];
    cell.pageType = 1; // 重用cell 此处为1
    cell.model = [model.datalist objectAtIndex:indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UCarHaveSendViewController *detailVC = [[UCarHaveSendViewController alloc] init];
    CarBandThirdModel1 *model2 = model.datalist[indexPath.section];
    detailVC.carID = model2.id;
    detailVC.pageState = PageFromStateFromWhy;
    
    [self.navigationController pushViewController:detailVC animated:YES];
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveSelectCondition:) name:@"selectCondition" object:nil];

    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F1F4"];
    // Do any additional setup after loading the view.
    self.myTableview.backgroundColor = BACKGROUNDCOLOR;
    //设置刷新
    
    

    
}

- (void)initNotiView
{
    
    backV = [UIView new];
    
    backV.backgroundColor = [UIColor colorWithHexString:@"F2F1F4"];
    [self.view addSubview:backV];
    WS(myself);
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myself.view.mas_top);
        make.left.equalTo(myself.view.mas_left);
        make.right.equalTo(myself.view.mas_right);
        make.height.equalTo(@(88*REM));
    }];
    
    clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backV addSubview:clearButton];
    [clearButton setTitle:@"清除筛选条件" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor colorWithHexString:@"33a1ed"] forState:UIControlStateNormal];
    clearButton.layer.cornerRadius = 12;
    clearButton.layer.borderColor = [UIColor colorWithHexString:@"33a1ed"].CGColor;
    clearButton.layer.borderWidth = 1;
    clearButton.clipsToBounds = YES;
    clearButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(200*REM));
        make.height.equalTo(@24);
        make.centerY.equalTo(backV.mas_centerY);
        make.right.equalTo(backV.mas_right).offset(-28*REM);
    }];

    @weakify(self);
    clearButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        NSString *value = @"清除";
        showL.text = @"筛选条件:";
        SVC.statuStr = value;
        SVC.title = self.title;
        [self getNetAction];
        
        
        [backV mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.view.mas_top).offset(- 1.1 * H(backV));
            
        }];
        
        return [RACSignal empty];
    }];
    
     showL = [UILabel new];
    showL.font = [UIFont systemFontOfSize:14];
    [backV addSubview:showL];
    [showL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backV.mas_centerY);
        make.right.equalTo(clearButton.mas_left).offset(-80*REM);
        make.left.equalTo(backV.mas_left).offset(25*REM);
    }];
    
    showL.textColor = [UIColor colorWithHexString:@"999999"];
    WS(weakSelf)
    [weakSelf.myTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(backV.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
        
    }];
    
}

- (void)receiveSelectCondition:(NSNotification *)noti
{
  
    WS(myself);
    _postDic = noti.object[@"condition"];
   

        [RACObserve(self, postDic)subscribeNext:^(NSDictionary *dic) {
            if ([[dic allKeys] count] != 0) {
                
                [myself getDataAgain];
                [myself initNotiView];
            }
            
            
        }];
    
    
  
    
   self.showLDic = noti.object[@"showLabel"];

   RACSignal *mySig = [RACSignal combineLatest:@[RACObserve(self, showLDic)] reduce:^id(NSDictionary *dic){
        return @([[dic allValues] count] > 0);
    }];
    

    RAC(backV, alpha) = mySig;
    [mySig subscribeNext:^(id x) {
        backV.alpha = 1;
        
    }];
    
    [[RACSignal combineLatest:@[RACObserve(self, showLDic)] reduce:^id(NSDictionary *dic){
        
        if ([dic allValues] != nil) {
            return [dic allValues];
        } else
        return nil;
    }] subscribeNext:^(NSArray *arr) {
       
        NSString *str = [arr componentsJoinedByString:@","];
        showL.text = [NSString stringWithFormat:@"筛选条件:%@", str];
        
    }];
    
   
    
}

- (void)getDataAgain
{
    [_postDic setValue:@"1000" forKey:@"pageSize"];
   [CarBandThirdModel hanleAfterSelectBlock:^(id returnValue) {
       model = returnValue;
       [_myTableview reloadData];
   } WithFailureBlock:^(id error) {
       NSLog(@"错误");
   } Param:_postDic];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _myTableview.delegate = nil;

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectCondition" object:nil];
}

- (void)viewWillLayoutSubviews
{
 
    if (backV.frame.origin.y <= 0) {
        
        for (UIView *v in self.view.subviews) {
            if ([v isEqual:backV]) {
                
                [backV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.mas_top).offset(10);

                    make.left.mas_equalTo(self.view);
                    make.right.mas_equalTo(self.view);


                    make.height.equalTo(@(88*REM));
                }];
            }
        }
    }

}

// 隐藏底部bar;
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNetAction];
    [self initTableView];
    [self initBottomButton];
    

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
