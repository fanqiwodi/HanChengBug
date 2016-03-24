//
//  UCarMainSourceViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarMainSourceViewController.h"
#import "UCarMainSourceNetwork.h"
#import "UCarMainSourceA10Model.h"
#import "UCarMainSourceCarouselA57Model.h"
#import "BDKCollectionIndexView.h"
#import "SDCycleScrollView.h"
#import "UCarMainRecourceCollectionViewCell.h"
#import "UCarSearchViewController.h"
#import "CarbandViewController.h"
#import <UIImageView+WebCache.h>
#import "HeadVIew.h"
#import "C_58_infoModel+NetAction.h"
#import "NetErrorView.h"
#import "AppDelegate.h"

#import "WebViewController.h"

static NSString *const reuseCell = @"UCarMainRecourceCollectionViewCell";

@interface UCarMainSourceViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionViewMainSource;// >>>
@property (nonatomic, strong) UCarMainSourceA10Model *modelA10;          // 主页数据
@property (nonatomic, strong) UCarMainSourceCarouselA57Model *modelA57;  // 轮播数据
@property (nonatomic, strong)   BDKCollectionIndexView *indexView;         // 索引
@property (nonatomic, strong) SDCycleScrollView *cycleScroller;          // 轮播
@property (nonatomic, strong) UIButton *searchBar;                       // 搜索按钮
@property (nonatomic, strong) NetErrorView *errorView;
                                                                         // <<<
@end

@implementation UCarMainSourceViewController

#pragma mark 待完成 点击轮播某一个
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
//    UCarMainSourceCarouselA57Model_datalist *refreshModel = self.modelA57.datalist[index];
//    WebViewController *webVC = [[WebViewController alloc] init];
//    webVC.url = refreshModel.url;
//    webVC.titleName = refreshModel.name;
//    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self creatAllView];
    
}

// 进入程序 创建所有视图
- (void)creatAllView
{
    [C_58_infoModel handleWithSuccessBlock:^(id returnValue) {
        C_58_infoModel *model = [C_58_infoModel new];
        model = returnValue;
        UCARNSUSERDEFULTS(userDefaults)
        [userDefaults setObject:model.is_pay forKey:UCARIS_PAY];
        [userDefaults setObject:model.phone forKey:UCARPHONENUMBER];
        [userDefaults setObject:model.is_push forKey:UCARIS_PUSH];
        [userDefaults setObject:model.is_auth forKey:UCARIS_AUTH];
        [userDefaults setObject:model.role_id forKey:UCARROLE_ID];
    } WithFailureBlock:^(id error) {
        
        self.errorView = [[NetErrorView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, screen_width, screen_height - 49 - 10 - self.navigationController.navigationBar.frame.size.height - 20)];
        _errorView.backgroundColor = [UIColor whiteColor];
        [_errorView.button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [app.window addSubview:_errorView];

    }];
    
    if (_cycleScroller == nil) {
        
        self.cycleScroller = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80 * LAYOUT_SIZE)];
    }
    [self configNetwork];
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    [self.navigationController.view addSubview:self.searchBar];


}

- (void)back:(UIButton *)button
{
    [_errorView removeFromSuperview];
    [self creatAllView];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
       }

#pragma mark NetWorking&Layout
- (void)configNetwork
{
    WS(weakSelf)
    [UCarMainSourceNetwork GETWithA10:^(id returnValue) {
        weakSelf.modelA10 = returnValue;
        NSMutableArray *tempArray = [NSMutableArray new];
        for (NSInteger i = 0; i < weakSelf.modelA10.datalist.count; i++) {
            UCarMainSourceA10Model_DataList *model = [weakSelf.modelA10.datalist objectAtIndex:i];
            [tempArray addObject:model.name];
        }
        [weakSelf.view addSubview:weakSelf.collectionViewMainSource];
        [self initIndexView:tempArray];
        } FailureBlk:^(id error) {}];
    
    [UCarMainSourceNetwork GETWithA57:^(id returnValue) {
        self.modelA57 = returnValue;
        NSMutableArray *imageUrlArray = [NSMutableArray new];
        for (NSInteger i = 0; i < weakSelf.modelA57.datalist.count; i++) {
            UCarMainSourceCarouselA57Model_datalist *model = [weakSelf.modelA57.datalist objectAtIndex:i];
            @autoreleasepool {
                NSString *stringUrl = [NSString stringWithFormat:@"%@/%@",model.imageURL,model.img];
                [imageUrlArray addObject:stringUrl];
        }}
        
        weakSelf.cycleScroller.imageURLStringsGroup = imageUrlArray;
        weakSelf.cycleScroller.delegate = self;
        weakSelf.cycleScroller.placeholderImage = [UIImage imageNamed:@"PlaceHolderImage"];
        [weakSelf.view addSubview:weakSelf.cycleScroller];
    } FailureBlk:^(id error) {}];
}


#pragma mark 侧边索引栏
- (void)indexViewValueChanged:(BDKCollectionIndexView *)index
{
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:index.currentIndex];
    [self.collectionViewMainSource scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

- (void)initIndexView:(NSArray *)indexArray
{
    self.indexView = [BDKCollectionIndexView indexViewWithFrame:CGRectZero indexTitles:@[]];
    _indexView.translatesAutoresizingMaskIntoConstraints = NO;   // auto layout
    [_indexView addTarget:self action:@selector(indexViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    _indexView.indexTitles = indexArray;
    _indexView.titleColor = [UIColor colorWithHexString:@"ccced1"];
    [self.view addSubview:_indexView];
    WS(weakself);
    
    [self.view bringSubviewToFront:self.indexView];
    [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).with.offset(-5);
        make.top.mas_equalTo(80 * LAYOUT_SIZE);
        make.width.equalTo(@20);
        make.height.equalTo(weakself.view.mas_height).with.offset(-80 * LAYOUT_SIZE);
    }];
    
    _indexView.alpha = 0.01;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _indexView.alpha = 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateKeyframesWithDuration:0.5 delay:1 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        _indexView.alpha = 0.01;
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark Collection View data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    UCarMainSourceA10Model_DataList *model = [self.modelA10.datalist objectAtIndex:section];
    NSInteger number = model.value.count % 4;
    if (number == 0) {
        return model.value.count;
    } else {
       return model.value.count +  4 - number;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        UCarMainRecourceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCell forIndexPath:indexPath];
            if (self.modelA10.datalist.count > indexPath.section) {
               UCarMainSourceA10Model_DataList *dataModel = [self.modelA10.datalist objectAtIndex:indexPath.section];
                if (dataModel.value.count > indexPath.row) {
                UCarMainSourceA10Model_DataList_Value *valueModel = [dataModel.value objectAtIndex:indexPath.row];
                
                cell.isHotString = valueModel.isHot;
                cell.carLogoString =[NSString stringWithFormat:@"%@/%@",valueModel.imageURL,valueModel.logo];
                cell.carNameString = valueModel.name;
                }else {
                    cell.carLogoString = @"";
                    cell.carNameString = @"";
                    cell.isHotString = @"0";
                }
            }

        return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HeadVIew *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
        
        UCarMainSourceA10Model_DataList *dataModel = [self.modelA10.datalist objectAtIndex:indexPath.section];
        headerView.letterL.text = dataModel.name;
        reusableView = headerView;
    }
    return reusableView;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.modelA10.datalist.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.modelA10.datalist.count > indexPath.section) {
        UCarMainSourceA10Model_DataList *dataModel = [self.modelA10.datalist objectAtIndex:indexPath.section];
        if (dataModel.value.count > indexPath.row) {
    UCarMainSourceA10Model_DataList_Value *valueModel = [dataModel.value objectAtIndex:indexPath.row];
    CarbandViewController *carbandVC = [[CarbandViewController alloc] init];
    carbandVC.model = valueModel;
    carbandVC.title = valueModel.name;
    [self.navigationController pushViewController:carbandVC animated:YES];
    }}
}

#pragma mark search Button
- (UIButton *)searchBar{
    if (!_searchBar) {
        UIButton *searchBar = [UIButton buttonWithType:UIButtonTypeSystem];
        searchBar.frame = CGRectMake(25 * LAYOUT_SIZE, 26, SCREENWIDTH - 50 *LAYOUT_SIZE, 32);
        searchBar.alpha = 1.;
        searchBar.backgroundColor = [UIColor whiteColor];
        [searchBar setTitle:@"可输入车型、颜色、价格、配置..." forState:UIControlStateNormal];
        searchBar.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [searchBar setImage:[UIImage imageNamed:@"ico_search"] forState:UIControlStateNormal];
        [searchBar setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 30)];
        searchBar.tintColor = HEXCOLOR(0x888888);
        [searchBar setTitleColor:HEXCOLOR(0x888888) forState:UIControlStateNormal];
        searchBar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        searchBar.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [searchBar addTarget:self action:@selector(showSearchView) forControlEvents:UIControlEventTouchUpInside];
        searchBar.layer.cornerRadius = 15.0;
        _searchBar = searchBar;}
    return _searchBar;
}
- (void)searchAutoLayout
{
    WS(weakSelf)
    [weakSelf.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.navigationController.view).offset(26);
        make.height.mas_equalTo(@32);
        make.left.mas_equalTo(weakSelf.view.mas_leftMargin);
        make.right.mas_equalTo(weakSelf.view.mas_rightMargin);
    }];
}

- (void)showSearchView
{
    UCarSearchViewController *searchViewController = [[UCarSearchViewController alloc] initWithNibName:NSStringFromClass([UCarSearchViewController class]) bundle:nil];
    searchViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    searchViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:searchViewController animated:YES completion:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar removeFromSuperview];
    
    if (_errorView != nil) {
        [_errorView removeFromSuperview];
    }
}

#pragma mark SET/GET
- (UCarMainSourceA10Model *)modelA10
{
    if (_modelA10 == nil) {
        UCarMainSourceA10Model *tempModel10 = [UCarMainSourceA10Model new];
        _modelA10 = tempModel10;
    }
    return _modelA10;
}

- (UCarMainSourceCarouselA57Model *)modelA57
{
    if (_modelA57 == nil) {
        UCarMainSourceCarouselA57Model *tempModelA57 = [UCarMainSourceCarouselA57Model new];
        _modelA57 = tempModelA57;
    }
    return _modelA57;
}



- (UICollectionView *)collectionViewMainSource
{
    if (_collectionViewMainSource == nil) {
        UICollectionViewFlowLayout *tempFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        tempFlowLayout.itemSize = CGSizeMake(screen_width/4-0.9, screen_width/4-0.9);
        if (IOS_VERSION >= 9) {
//            tempFlowLayout.sectionHeadersPinToVisibleBounds = YES;
        }
        tempFlowLayout.minimumLineSpacing = 1;
        tempFlowLayout.minimumInteritemSpacing = 1;
        tempFlowLayout.headerReferenceSize = CGSizeMake(W(self.view), 48*REM);
        tempFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *tempCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 154*REM, SCREENWIDTH, SCREENHEIGHT - 180) collectionViewLayout:tempFlowLayout];
        tempCollectionView.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        tempCollectionView.scrollsToTop = YES;
        [tempCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarMainRecourceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseCell];
        [tempCollectionView registerClass:[HeadVIew class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        _collectionViewMainSource = tempCollectionView;
    }
    return _collectionViewMainSource;
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
