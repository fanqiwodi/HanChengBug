//
//  IsPayViewController.m
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IsPayViewController.h"
#import "HeadVIew.h"
#import "G_77_Model_isPay.h"
#import "CarResourceCollectionViewCell.h"
#import "IsPayChildViewController.h"
#import "UCarMainRecourceCollectionViewCell.h"

static NSString *const reuseCell = @"UCarMainRecourceCollectionViewCell";

@interface IsPayViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    G_77_Model_isPay *model;
}
@property (nonatomic, strong) UICollectionView *myCollectiov;
@end

@implementation IsPayViewController

- (void)getNetData
{
    NSLog(@"%@", [UserMangerDefaults UidGet]);
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:@"/api/ucarSpecial/getSpecialGoods?startNum=0&pageSize=20" header:@{@"Uid":[UserMangerDefaults UidGet]}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        model = [G_77_Model_isPay modelWithJSON:request.responseBody[@"data"]];
        
        [_myCollectiov reloadData];
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"错误%lu", [request responseStatusCode]);
    }];
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"U特价";
        [self initCollection];
        [self getNetData];

    }
    return self;
}

- (void)initCollection
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.itemSize = CGSizeMake(screen_width/4-0.9, screen_width/4-0.9);
    if (IOS_VERSION > 9) {
        flowlayout.sectionHeadersPinToVisibleBounds = YES;
    }
    flowlayout.minimumLineSpacing = 1;
    flowlayout.minimumInteritemSpacing = 1;
    flowlayout.headerReferenceSize = CGSizeMake(W(self.view), 48*REM);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.myCollectiov =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-115) collectionViewLayout:flowlayout];
    self.myCollectiov.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
    self.myCollectiov.delegate = self;
    self.myCollectiov.dataSource = self;
    self.myCollectiov.scrollsToTop = YES;
    [self.myCollectiov registerNib:[UINib nibWithNibName:NSStringFromClass([UCarMainRecourceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseCell];
    
    [self.myCollectiov registerClass:[HeadVIew class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.myCollectiov];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HeadVIew *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
        
        G_77_Model_isPay_son1 *model1 = [model.specialList objectAtIndex:indexPath.section];
        headerView.letterL.text = model1.name;
        reusableView = headerView;
    }
    return reusableView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return model.specialList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    G_77_Model_isPay_son1 *model1 = [model.specialList objectAtIndex:section];
     NSInteger number = model1.value.count % 4;
    if (number == 0) {
        return model1.value.count;
    } else {
        return model1.value.count + 4 - number;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UCarMainRecourceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCell forIndexPath:indexPath];

    cell.backgroundColor = [UIColor whiteColor];
   
    
    if (model.specialList.count > indexPath.section) {
          G_77_Model_isPay_son1 *son = model.specialList[indexPath.section];
        if (son.value.count > indexPath.row) {
             G_77_Model_isPay_son2 *son2 = son.value[indexPath.item];
            
            cell.carLogoString =[NSString stringWithFormat:@"%@/%@",son2.imageURL,son2.logo];
            cell.carNameString = son2.name;
        }else {
            cell.carLogoString = @"";
            cell.carNameString = @"";
            cell.isHotString = @"0";
        }
    }
    
    
    
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (model.specialList.count > indexPath.section) {
        G_77_Model_isPay_son1 *son = model.specialList[indexPath.section];
        if (son.value.count > indexPath.row) {
            G_77_Model_isPay_son2 *son2 = son.value[indexPath.item];
           
           IsPayChildViewController *isPayChildVC = [[IsPayChildViewController alloc] init];
            isPayChildVC.brandId = son2.brandId;
            isPayChildVC.titleName = son2.name;
   [self.navigationController pushViewController:isPayChildVC animated:YES];
        }
    }
    
 
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(a)];
}

- (void)a
{
    
}

// 每次页面出现的时候，把父VC从navigation上移除

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    for (UIViewController *VC in self.navigationController.childViewControllers) {
        if ([NSStringFromClass([VC class])isEqualToString:@"UPircesViewController"]) {
            [VC removeFromParentViewController];
        }
    }
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
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
