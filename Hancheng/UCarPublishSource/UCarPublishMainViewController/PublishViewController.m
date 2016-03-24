//
//  PublishViewController.m
//  Hancheng
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//


// 此页面是入库页面

#import "PublishViewController.h"
#import "HMSegmentedControl.h"
#import "UCarHaveNotSendCarView.h"
#import "UCarSendInforViewController.h"
#import "UCarTableViewSWCell.h"
#import "UCarPublishMainNetwork.h"
#import "UCarPublishMainModel.h"
#import <MJRefresh.h>
#import "UCarBPartViewController.h"
#import "UCarHaveSendViewController.h"
#import "BaseNavigationViewController.h"
#import "UCarPublishChooseLogoViewController.h"
#import "UCarHaveNotAuthShowView.h"
#import "UCarUserLicenseViewController.h"

typedef NS_ENUM(NSInteger, pageStatus){
    pageStatusUp = 1,
    pageStatusDown = 2,
} ;

typedef NS_ENUM(NSInteger, CellMoveType)
{
    cellMoveTypeDelete,
    cellMoveTypeUp,
    cellMoveTypeDown,
    cellMoveTypeUpToTop,
    cellMoveTypeDownTop,
};

static NSString *reuseCell = @"UCarTableViewSWCell";

@interface PublishViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet HMSegmentedControl *carInfoStatus; /**< 已发布/下架 */
@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;      /**< 此Scrollview加载两个ViewController */
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addButtonFrameHeight;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


@property (nonatomic, strong) UITableView *tableViewHaveSend;
@property (nonatomic, strong) UITableView *tableViewDownGood;
@property (nonatomic, strong) NSArray *dataSourceUp;
@property (nonatomic, strong) NSArray *dataSourceDown;

@end

@implementation PublishViewController
{
    NSInteger _haveUpNumber;
    NSInteger _haveDownNumber;
    NSInteger _brandID;
}

#pragma mark ViewWillAppear
- (void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:YES];
    self.title = @"入库";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];    
    self.scrollviewHeight.constant = SCREENHEIGHT - 49 - 64 - 42 *LAYOUT_SIZE;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self makeSureWeatherisAuth];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _brandID = 0;
    // Do any additional setup after loading the view from its nib.
    [self setSegmentedControl];
    self.carInfoStatus.sectionTitles = @[[NSString stringWithFormat:@"已发布(0)"], [NSString stringWithFormat:@"下架(0)"]];
    
    [self.view bringSubviewToFront:self.addButton];
    
    self.tableViewHaveSend.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableViewstareUp)];
    self.tableViewDownGood.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableViewDown)];
    
}

#pragma mark 初始化网络访问
- (void)configNetworking:(NSInteger)brandID
{
    [UCarPublishMainNetwork GETSelfGoodListStatus:pageStatusUp userId:[UserMangerDefaults UidGet] brandId:_brandID successBlk:^(id returnValue) {
        NSArray *blkArray = returnValue;
        _haveUpNumber = [[blkArray objectAtIndex:0] integerValue];
        _haveDownNumber = [[blkArray objectAtIndex:1] integerValue];
        self.carInfoStatus.sectionTitles = @[[NSString stringWithFormat:@"已发布(%ld)",_haveUpNumber], [NSString stringWithFormat:@"下架(%ld)",_haveDownNumber]];
        [self.carInfoStatus setSelectedSegmentIndex:self.carInfoStatus.selectedSegmentIndex];
        self.dataSourceUp = [[blkArray objectAtIndex:2] copy];
        if (_haveUpNumber != 0) {
        [self setTableViewFrameUp];
        }
        [self.tableViewHaveSend reloadData];
        
    } failureBlk:^(id error) {
        
    }];
    
    
    [UCarPublishMainNetwork GETSelfGoodListStatus:pageStatusDown userId:[UserMangerDefaults UidGet] brandId:_brandID successBlk:^(id returnValue) {
        NSArray *blkArray = returnValue;
        _haveUpNumber = [[blkArray objectAtIndex:0] integerValue];
        _haveDownNumber = [[blkArray objectAtIndex:1] integerValue];
        self.carInfoStatus.sectionTitles = @[[NSString stringWithFormat:@"已发布(%ld)",_haveUpNumber], [NSString stringWithFormat:@"下架(%ld)",_haveDownNumber]];
        [self.carInfoStatus setSelectedSegmentIndex:self.carInfoStatus.selectedSegmentIndex];
        self.dataSourceDown = [[blkArray objectAtIndex:2] copy];
        if (_haveDownNumber != 0 || _haveDownNumber != 0 || _haveUpNumber != 0 ) {
        [self setTableViewFrameDown];
        }
        [self.tableViewDownGood reloadData];
    } failureBlk:^(id error) {
        
    }];
    
    if (_haveUpNumber == 0) {
        [self addPlaceHolder:0];
    }
    if (_haveDownNumber == 0) {
        [self addPlaceHolder:1];
    }
  
}

- (void)refreshTableViewstareUp
{
    [UCarPublishMainNetwork GETSelfGoodListStatus:pageStatusUp userId:[UserMangerDefaults UidGet] brandId:_brandID successBlk:^(id returnValue) {
        NSArray *blkArray = returnValue;
        _haveUpNumber = [[blkArray objectAtIndex:0] integerValue];
        _haveDownNumber = [[blkArray objectAtIndex:1] integerValue];
        self.carInfoStatus.sectionTitles = @[[NSString stringWithFormat:@"已发布(%ld)",_haveUpNumber], [NSString stringWithFormat:@"下架(%ld)",_haveDownNumber]];
        [self.carInfoStatus setSelectedSegmentIndex:0 animated:YES];
        self.dataSourceUp = [[blkArray objectAtIndex:2] copy];
        [self setTableViewFrameUp];
        [self.tableViewHaveSend reloadData];
        [self.tableViewHaveSend.mj_header endRefreshing];
        
    } failureBlk:^(id error) {
        [self.tableViewHaveSend.mj_header endRefreshing];
    }];
}

- (void)refreshTableViewDown
{

    [UCarPublishMainNetwork GETSelfGoodListStatus:pageStatusDown userId:[UserMangerDefaults UidGet] brandId:0 successBlk:^(id returnValue) {
        NSArray *blkArray = returnValue;
        _haveUpNumber = [[blkArray objectAtIndex:0] integerValue];
        _haveDownNumber = [[blkArray objectAtIndex:1] integerValue];
        self.carInfoStatus.sectionTitles = @[[NSString stringWithFormat:@"已发布(%ld)",_haveUpNumber], [NSString stringWithFormat:@"下架(%ld)",_haveDownNumber]];
        self.dataSourceDown = [[blkArray objectAtIndex:2] copy];
        [self setTableViewFrameDown];
        [self.tableViewDownGood reloadData];
        [self.tableViewDownGood.mj_header endRefreshing];
    } failureBlk:^(id error) {
        [self.tableViewDownGood.mj_header endRefreshing];
    }];
}

#pragma mark 判断是否认证
- (void)makeSureWeatherisAuth
{
     GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B93GETAUTH header:@{@"Uid":[UserMangerDefaults UidGet]}];
    NSLog(@"UID : %@",[UserMangerDefaults UidGet]);
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dataDictory = [request.responseJSONObject objectForKey:@"data"];
        NSLog(@"%@,%@",dataDictory, [dataDictory objectForKey:@"isAuth"]);
        NSNumber *is_Auth = [dataDictory objectForKey:@"isAuth"];
        if ([is_Auth isEqualToNumber:@0]) {
            UCarHaveNotAuthShowView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([UCarHaveNotAuthShowView class]) owner:nil options:nil] lastObject];
            view.frame = self.view.bounds;
            view.tag = 10000;
            [view.makeSureButton addTarget:self action:@selector(pushToMakeSure:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:view];
        } else {
            // 右上角按钮
            UIView *tempView = [self.view viewWithTag:10000];
            [tempView removeFromSuperview];
            UIButton *partViewButton = [UIButton buttonWithType:UIButtonTypeSystem];
            [partViewButton addTarget:self action:@selector(showPartView:) forControlEvents:UIControlEventTouchUpInside];
            [partViewButton setBackgroundImage:[UIImage imageNamed:@"icon_into_item_menu_点击"] forState:UIControlStateNormal];
            partViewButton.frame = CGRectMake(20, 0, 30, 30);
            partViewButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
            UIBarButtonItem *rightbarButton = [[UIBarButtonItem alloc] initWithCustomView:partViewButton];
            self.navigationItem.rightBarButtonItem = rightbarButton;

            [self configNetworking:_brandID];// 已认证
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}
- (void)pushToMakeSure:(UIButton *)button
{
    UCarUserLicenseViewController *licenseVC = [[UCarUserLicenseViewController alloc]init];
    licenseVC.pageState = 1;
    licenseVC.isAuth = @"0";
    UCARNSUSERDEFULTS(userDefaults)
    licenseVC.role_id = [userDefaults objectForKey:UCARROLE_ID];
    [self.navigationController pushViewController:licenseVC animated:YES];
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableViewHaveSend]) {
    UCarHaveSendViewController *haveSendController = [[UCarHaveSendViewController alloc] init];
    haveSendController.pageState = self.carInfoStatus.selectedSegmentIndex;
    UCarPublishMainModel_data_bodys *model = [_dataSourceUp objectAtIndex:indexPath.section];
    haveSendController.carID = model.id;
    haveSendController.pageState = PageFromStateHaveUp;
    haveSendController.sort = model.sort; // 0 置顶
    [self.navigationController pushViewController:haveSendController animated:YES];
    } else {
        UCarHaveSendViewController *haveSendController = [[UCarHaveSendViewController alloc] init];
        haveSendController.pageState = self.carInfoStatus.selectedSegmentIndex;
        UCarPublishMainModel_data_bodys *model = [_dataSourceDown objectAtIndex:indexPath.section];
        haveSendController.carID = model.id;
        haveSendController.pageState = PageFromStatehaveDown;
        [self.navigationController pushViewController:haveSendController animated:YES];
    }
}


#pragma mark TableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableViewHaveSend]) {
        if (_dataSourceUp) {
            return _dataSourceUp.count;
        } else {
            return 0;
        }
    } else {
        if (_dataSourceDown) {
            return _dataSourceDown.count;
        } else {
            return 0;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarTableViewSWCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    if ([tableView isEqual:self.tableViewHaveSend]) {
        dispatch_async(global, ^{
            UCarPublishMainModel_data_bodys *model = [_dataSourceUp objectAtIndex:indexPath.section];
            dispatch_async(mainQueue, ^{
                [cell setRightUtilityButtons:[self rightButtonsUp:model.sort] WithButtonWidth:80];
            });
            cell.model = model;
        });
    } else {
        [cell setRightUtilityButtons:[self rightButtonsDown] WithButtonWidth:80];
        dispatch_async(global, ^{
            UCarPublishMainModel_data_bodys *model = [_dataSourceDown objectAtIndex:indexPath.section];
            cell.model = model;
        });
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}


#pragma mark 删除/上下架子
- (void)moveTableViewWithRules:(NSNumber *)carID moveType:(CellMoveType)moveType
{
    /**< 首先确定第几行*/
    NSInteger sectionNumber = 0;
    

    switch (self.carInfoStatus.selectedSegmentIndex) {
        case 0:
            for (NSInteger i = 0; i < self.dataSourceUp.count; i++) {
                UCarPublishMainModel_data_bodys *model = [self.dataSourceUp objectAtIndex:i];
                if ([model.id isEqualToNumber:carID]) {
                    sectionNumber = i;
                }
            }
            
            if (moveType == cellMoveTypeDelete) {
                // 删除
                [UCarPublishMainNetwork DELETECarGoods:carID userId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
                    NSDictionary *blkDic = returnValue;
                    NSNumber *codeID = [blkDic objectForKey:@"code"];
                    if ([codeID isEqualToNumber:@0]) {
                        [self showHint:@"删除成功"];
                        NSMutableArray *tempArray =  [self.dataSourceUp mutableCopy];
                        [tempArray removeObjectAtIndex:sectionNumber];
                        self.dataSourceUp =  [tempArray copy];
                        [self.tableViewHaveSend deleteSection:sectionNumber withRowAnimation:UITableViewRowAnimationLeft];
                        [self configNetworking:_brandID];
                    } else {
                        NSString *msg = [blkDic objectForKey:@"msg"];
                        [self showHint:msg];
                    }
                } failure:^(id error) {
                    
                }];
                
               
            } else if (moveType == cellMoveTypeDown) {
                // 下架
                [UCarPublishMainNetwork PUTCarUpDownMarket:carID upDownState:@2 UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
                    NSDictionary *blkDic = returnValue;
                    NSNumber *codeId = [blkDic objectForKey:@"code"];
                    if ([codeId isEqualToNumber:@0]) {
                        [self showHint:@"下架成功"];
                        NSMutableArray *tempArray =  [self.dataSourceUp mutableCopy];
                        if (tempArray != nil) {
                         [tempArray removeObjectAtIndex:sectionNumber];
                        }
                        self.dataSourceUp =  [tempArray copy];
                        [self.tableViewHaveSend deleteSection:sectionNumber withRowAnimation:UITableViewRowAnimationRight];
                        [self configNetworking:_brandID];
                    } else {
                        NSString *msg = [blkDic objectForKey:@"msg"];
                        [self showHint:msg];
                    }
                    
                } failureBlk:^(id error) {
                    
                }];
                
                
            } else if (moveType == cellMoveTypeUpToTop) {
                
                [UCarPublishMainNetwork PUTCarUpToTopOrBottom:carID flag:@"1" UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
                    NSDictionary *blkDic = returnValue;
                    NSNumber *codeID =  [blkDic objectForKey:@"code"];
                    if ([codeID isEqualToNumber:@0]) {
                        [self showHint:@"置顶成功"];
                        [self configNetworking:_brandID];
                    } else {
                        NSString *msg = [blkDic objectForKey:@"msg"];
                        [self showHint:msg];
                    }
                } faliureBlk:^(id error) {
                    
                }];
            
            } else if (moveType == cellMoveTypeDownTop) {
                [UCarPublishMainNetwork PUTCarUpToTopOrBottom:carID flag:@"0" UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
                    NSDictionary *blkDic = returnValue;
                    NSNumber *codeID = [blkDic objectForKey:@"code"];
                    if ([codeID isEqualToNumber:@0]) {
                        [self showHint:@"取消置顶"];
                        [self configNetworking:_brandID];
                    } else {
                        NSString *msg = [blkDic objectForKey:@"msg"];
                        [self showHint:msg];
                    }
                } faliureBlk:^(id error) {
                    
                }];
            }
            [self configNetworking:_brandID];
            break;
            
            
            
            
        case 1:
            for (NSInteger i = 0; i < self.dataSourceDown.count; i++) {
                UCarPublishMainModel_data_bodys *model = [self.dataSourceDown objectAtIndex:i];
                if ([model.id isEqualToNumber:carID]) {
                    sectionNumber = i;
                }
            }
            
            if (moveType == cellMoveTypeDelete) {
                [UCarPublishMainNetwork DELETECarGoods:carID userId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
                    NSDictionary *blkDic = returnValue;
                    NSNumber *codeID = [blkDic objectForKey:@"code"];
                    if ([codeID isEqualToNumber:@0]) {
                        [self showHint:@"删除成功"];
                        
                        NSMutableArray *tempArray =  [self.dataSourceDown mutableCopy];
                        [tempArray removeObjectAtIndex:sectionNumber];
                        self.dataSourceDown =  [tempArray copy];
                        [self.tableViewDownGood deleteSection:sectionNumber withRowAnimation:UITableViewRowAnimationLeft];
                        [self configNetworking:_brandID];
                    } else {
                        NSString *msg = [blkDic objectForKey:@"msg"];
                        [self showHint:msg];
                    }
                } failure:^(id error) {
                    
                }];
            
            } else if (moveType == cellMoveTypeUp) { // 上架
                
                [UCarPublishMainNetwork PUTCarUpDownMarket:carID upDownState:@1 UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
                    NSDictionary *blkDic = returnValue;
                    NSNumber *codeId = [blkDic objectForKey:@"code"];
                    if ([codeId isEqualToNumber:@0]) {
                        [self showHint:@"上架成功"];
                        NSMutableArray *tempArray =  [self.dataSourceDown mutableCopy];
                        [tempArray removeObjectAtIndex:sectionNumber];
                        self.dataSourceDown =  [tempArray copy];
                        [self.tableViewDownGood deleteSection:sectionNumber withRowAnimation:UITableViewRowAnimationLeft];
                        [self configNetworking:_brandID];
                    } else {
                        NSString *msg = [blkDic objectForKey:@"msg"];
                        [self showHint:msg];
                    }
                    
                } failureBlk:^(id error) {
                    
                }];
            }
            break;
        default:
            NSLog(@"self.carInfoStatus.selectedSegmentIndex: %ld",self.carInfoStatus.selectedSegmentIndex);
            break;
    }
}


#pragma mark SWCellDelegate
- (void)swipeableTableViewCell:(UCarTableViewSWCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{

    switch (self.carInfoStatus.selectedSegmentIndex) {
        case 0:
            if (index == 0) {
            if ([cell.sort isEqualToNumber:@0]) {
            // 如果是置顶状态
                [self moveTableViewWithRules:cell.carID moveType:cellMoveTypeDownTop];
            } else {
            // 如果非置顶状态
                [self moveTableViewWithRules:cell.carID moveType:cellMoveTypeUpToTop];
            }
            }
            
            if (index == 1) {
                 [self moveTableViewWithRules:cell.carID moveType:cellMoveTypeDown];
            }
            
            if (index == 2) {
                [self moveTableViewWithRules:cell.carID moveType:cellMoveTypeDelete];
            }
 
            break;
        
        case 1:
            
            if (index == 0) {
                
                [self moveTableViewWithRules:cell.carID moveType:cellMoveTypeUp];
            }
            
            if (index == 1) {
                
                [self moveTableViewWithRules:cell.carID moveType:cellMoveTypeDelete];
                
            }
            break;
        default:
            break;
    }
    
    
    
}

// 一次只滑动出一个Cell
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    return YES;
}

- (void)swipeableTableViewCell:(UCarTableViewSWCell *)cell scrollingToState:(SWCellState)state
{

    cell.UCarRightColorImage.image = [UIImage imageNamed:@"iconfont_shuxian_red"];
    if (state == kCellStateCenter) {
        NSLog(@"center");
        cell.UCarRightColorImage.image = [UIImage imageNamed:@"iconfont_shuxian_gray"];
    }
}


#pragma mark Cell侧滑
- (NSArray *)rightButtonsUp:(NSNumber *)sort   /**<置顶标识 0-置顶； 非0不置顶*/
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    NSArray *nameArray = @[@[@"取消置顶",@"下架",@"删除"],@[@"置顶",@"下架",@"删除"]];
    NSArray *titleNameArray = [NSArray array];
    if ([sort isEqualToNumber:@0]) {
        titleNameArray = [nameArray objectAtIndex:0];
    } else {
        titleNameArray = [nameArray objectAtIndex:1];
    }
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:HEXCOLOR(0x8f8f97)
                                                title:titleNameArray[0]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:HEXCOLOR(0xff9101)
                                                title:titleNameArray[1]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:HEXCOLOR(0xff5000)
                                                title:titleNameArray[2]];
    return rightUtilityButtons;
}
- (NSArray *)rightButtonsDown
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:HEXCOLOR(0xff9101)
                                                title:@"上架"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:HEXCOLOR(0xff5000)
                                                title:@"删除"];
    return rightUtilityButtons;
}




#pragma mark SETSegmentControl
- (void)setSegmentedControl
{
    self.carInfoStatus.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.carInfoStatus.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.carInfoStatus.selectionIndicatorColor = CARINFORRED;   
    self.carInfoStatus.selectionIndicatorHeight = 1.0f;
    [self.carInfoStatus setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        if (selected == YES) {
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: CARINFORRED,
                                                                                                        NSFontAttributeName:Font(14)}];
            return attString;
        } else {
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: CARINFORGRAY,
                                                                                                          NSFontAttributeName:Font(14)}];
            return attString;
        }    }];
    
    
    [self.carInfoStatus addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    /*
     // Segment 中间竖线
     self.carInfoStatus.verticalDividerEnabled = YES;
     self.carInfoStatus.verticalDividerColor = [UIColor blackColor];
     self.carInfoStatus.verticalDividerWidth = 1.0f * REM;
     */
    
    self.baseScrollView.contentSize = CGSizeMake(SCREENWIDTH *2, 0);
    self.baseScrollView.scrollEnabled = NO;
}

// 需要删除或者更改成viewcontroller
- (void)setTableViewFrameUp
{
    self.tableViewHaveSend.frame = CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT - 49 - 64 - 42 *LAYOUT_SIZE);
    [_baseScrollView addSubview:_tableViewHaveSend];
}

- (void)setTableViewFrameDown
{
    self.tableViewDownGood.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - 49 - 64 - 42 *LAYOUT_SIZE);
    [_baseScrollView addSubview:_tableViewDownGood];
}

#pragma mark SegmengControl Action
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    [self.baseScrollView setContentOffset:CGPointMake(WIDTH *segmentedControl.selectedSegmentIndex, 0) animated:YES];
}

#pragma mark ViewPlaceHolder
- (void)addPlaceHolder:(NSInteger)index
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UCarHaveNotSendCarView" owner:nil options:nil];
    UCarHaveNotSendCarView *tempView = [nib lastObject];
    tempView.frame = CGRectMake(0, 0, 176 *LAYOUT_SIZE, 176 *LAYOUT_SIZE);
    tempView.center = CGPointMake(SCREENWIDTH / 2 + SCREENWIDTH * index, self.view.center.y - 132 *LAYOUT_SIZE);
    [self.baseScrollView addSubview:tempView];
}

#pragma mark RightBarButton
- (void)showPartView:(UIButton *)button
{
    UCarBPartViewController *partView  = [[UCarBPartViewController alloc] initWithNibName:NSStringFromClass([UCarBPartViewController class]) bundle:nil];
    partView.segmentIndex = self.carInfoStatus.selectedSegmentIndex;
    partView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    partView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    partView.selectIndex = ^(NSInteger seletedIndex) {
        // 0 筛选 1 刷新
        if (seletedIndex == 0) {
            UCarPublishChooseLogoViewController *chooseLogoView = [[UCarPublishChooseLogoViewController alloc] init];
            chooseLogoView.backBrandID = ^(NSNumber *backBrandID) {
                _brandID = [backBrandID integerValue];
            };
            [self.navigationController pushViewController:chooseLogoView animated:YES];
        } else if (seletedIndex == 1) {
            GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B17USERCARINFOREFREASH header:@{@"Uid":[UserMangerDefaults UidGet]}];
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                [self configNetworking:_brandID];
                [self showHint:@"批量刷新成功"];
            } failure:^(YTKBaseRequest *request) {
                [self showHint:@"批量刷新失败"];
            }];
        }
    };
    [self presentViewController:partView animated:YES completion:nil];
}

#pragma mark Setter / Getter
- (UIButton *)addButton
{
    [_addButton setTitle:@"" forState:UIControlStateNormal];
    [_addButton setImageEdgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    self.addButtonFrameHeight.constant = 58 *LAYOUT_SIZE;
    [_addButton addTarget:self action:@selector(addSendCarAction:) forControlEvents:UIControlEventTouchUpInside];
    return _addButton;
}

- (void)addSendCarAction:(UIButton *)addSenCarButton
{
    UCarSendInforViewController *sendInfoViewController = [[UCarSendInforViewController alloc] init];
    [self.navigationController pushViewController:sendInfoViewController animated:YES];
}


- (UITableView *)tableViewDownGood
{
    if (_tableViewDownGood == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellEditingStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarTableViewSWCell class]) bundle:nil] forCellReuseIdentifier:reuseCell];
        _tableViewDownGood = tempTableView;
    }
    return _tableViewDownGood;
}

- (UITableView *)tableViewHaveSend
{
    if (_tableViewHaveSend == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellEditingStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarTableViewSWCell class]) bundle:nil] forCellReuseIdentifier:reuseCell];
        _tableViewHaveSend = tempTableView;
    }
    return _tableViewHaveSend;

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
