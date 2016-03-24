//
//  UCarHaveSendViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarHaveSendViewController.h"
#import "UCarBHaveSendDetailTableViewCell.h"
#import "UCarHaveSendOrderMoreTableViewCell.h"
#import "UCarBHaveSendImageMoreTableViewCell.h"
#import "CarbandDetailModel+CarbandDetailAction.h"
#import "UCarSendInforViewController.h"
#import "UCarHaveSendConfigableViewCell.h"
#import "UCarBCarShowPageDetailTableViewController.h"
#import <SKTagView.h>
#import "UCarBCarImageCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <MWPhotoBrowser.h>
#import "UCarHaveSendChooseButtonView.h"
#import "UCarHaveSendDownChooseButtonView.h"
#import "UCarPhoneOrderView.h"
#import "AccommodaCarViewController.h"
#import "CarDetailOneTableViewCell.h"
#import "UCarPublishMainNetwork.h"
#import "BaseNavigationViewController.h"
#import "UCarShareUMViewController.h"
#import <UIImageView+WebCache.h>
static NSString *const reuseHeaderDetail = @"UCarBHaveSendDetailTableViewCell";
static NSString *const reuseOrderMore = @"UCarHaveSendOrderMoreTableViewCell";
static NSString *const reuseImageMore = @"UCarBHaveSendImageMoreTableViewCell";
static NSString *const reuseConfigCell = @"UCarHaveSendConfigableViewCell";
static NSString *const reuseCollectionView = @"UCarBCarImageCollectionViewCell";
static NSString *cellStr = @"detailCell";

@interface UCarHaveSendViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UITableView *tableViewDetail;
@property (nonatomic, strong) UICollectionView *collectionViewImage;
@property (nonatomic, strong) CarbandDetailModel *modelData;

@property (nonatomic, strong) NSMutableArray *titleArray;    // Title
@property (nonatomic, strong) NSMutableArray *infoArray;     // 内容 图片是数组 配置是字典

@property (nonatomic, strong) NSArray *imageArray;    // 图片数组
@property (nonatomic, strong) NSMutableArray *nameArray;     // 亮点名称

@property (nonatomic, strong) NSMutableArray *thumbs;
@end

@implementation UCarHaveSendViewController
{
    NSArray *_PackgaeName;
    NSArray *_PackageID;
    NSArray *_PointsName;
    NSString *_PointDiy;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = @"车源详情";
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    if (self.dismissState == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_toolbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelfView)];
    }
    if (self.pageState == PageFromStateFromWhy) {
        
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_toolbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelfView)];
     
    }
}

- (void)dismissSelfView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)shareAction
{
    UCarShareUMViewController *shareView = [[UCarShareUMViewController alloc] initWithNibName:NSStringFromClass([UCarShareUMViewController class]) bundle:nil];
    shareView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    shareView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    if (self.pageState == PageFromStateFromWhy) {
        
        NSMutableString *shareString = [NSMutableString stringWithString:@""];
        [shareString appendString:self.modelData.data.name];
        for (NSInteger i = 0; i < self.titleArray.count; i++) {
            NSString *title = [self.titleArray objectAtIndex:i];
            if ([title isEqualToString:@"配置"]) {
                NSDictionary *tempDic = [self.infoArray objectAtIndex:i];
                NSString *pageName = [tempDic objectForKey:@"PackageName"];
                NSString *pointName = [tempDic objectForKey:@"PointsName"];
                NSString *Diy = [tempDic objectForKey:@"PointDiy"];
                if (pointName.length > 1) {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",pointName]];
                }
                if (pageName.length > 1) {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",pageName]];
                }
                if (Diy.length > 1) {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",Diy]];
                }
                
            } else
                if ([title isEqualToString:@"图像"]) {
                    
                } else {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",[self.infoArray objectAtIndex:i]]];
                }
            
        }
        [shareView initwithTitle:nil image:nil htmlURL:nil messageString:shareString];
        [shareView pageState:1];
        
    } else {
        
        UIImageView *shareImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"商场列表缩略图缺省"]];
        if (self.modelData.data.imgs.length > 10) {
            UCarBCarImageCollectionViewCell *cell1 = (UCarBCarImageCollectionViewCell *)[self.collectionViewImage cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            shareImageView.image = cell1.imageCollectionViewCell.image;
        }
        
        NSMutableString *shareString = [NSMutableString stringWithString:@""];
        [shareString appendString:self.modelData.data.name];
        for (NSInteger i = 0; i < self.titleArray.count; i++) {
            NSString *title = [self.titleArray objectAtIndex:i];
            if ([title isEqualToString:@"配置"]) {
                NSDictionary *tempDic = [self.infoArray objectAtIndex:i];
                NSString *pageName = [tempDic objectForKey:@"PackageName"];
                NSString *pointName = [tempDic objectForKey:@"PointsName"];
                NSString *Diy = [tempDic objectForKey:@"PointDiy"];
                if (pointName.length > 1) {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",pointName]];
                }
                if (pageName.length > 1) {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",pageName]];
                }
                if (Diy.length > 1) {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",Diy]];
                }
                
            } else
                if ([title isEqualToString:@"图像"]) {
                    
                } else {
                    [shareString appendString:[NSString stringWithFormat:@" | %@",[self.infoArray objectAtIndex:i]]];
                }
        }

        [shareString appendString:[NSString stringWithFormat:@",http://123.57.233.174/api/carSource/share/%@.html",self.carID]];

        
        [shareView initwithTitle:[NSString stringWithFormat:@"%@", self.modelData.data.name] image:shareImageView htmlURL:[NSString stringWithFormat:@"http://123.57.233.174/api/carSource/share/%@.html",self.carID] messageString:shareString];
        
    }
    [self presentViewController:shareView animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetwork];

    if (self.pageState == 1 || self.pageState == 2) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑图标"] style:UIBarButtonItemStylePlain target:self action:@selector(pushToEddie)];
    }
    
    if (self.pageState == 3) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fenxiang"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }
    
    if (self.pageState == PageFromStateHaveUp) {
        UCarHaveSendChooseButtonView *tempView = [[[NSBundle mainBundle]loadNibNamed:@"UCarHaveSendChooseButtonView" owner:nil options:nil] lastObject];
        if ([self.sort isEqualToNumber:@0]) tempView.upToTopLabel.text = @"取消置顶";
        [self.view addSubview:tempView];
        WS(weakSelf)
        __weak UCarHaveSendChooseButtonView *weakTempView = tempView;
        [weakTempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(50);
        }];
        tempView.pageState = ^(NSInteger seletedIndex){
            NSLog(@"%ld",seletedIndex);
            if (seletedIndex == 0) {
                [self shareAction];
            } else if (seletedIndex == 1) {
                if ([self.sort isEqualToNumber:@0]) {
                    [self cancleUpToTopAction];
                } else {
                [self upToTopAction];
                }
            } else if (seletedIndex == 2) {
                [self downFromTopAction];
            } else {
                [self deleteFromAction];
            }
        };
    }
    
    if (self.pageState == PageFromStatehaveDown) {
        UCarHaveSendDownChooseButtonView *tempView = [[[NSBundle mainBundle]loadNibNamed:@"UCarHaveSendDownChooseButtonView" owner:nil options:nil] lastObject];
        [self.view addSubview:tempView];
        WS(weakSelf)
        __weak UCarHaveSendDownChooseButtonView *weakDownView = tempView;
        [weakDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(50);
        }];
        tempView.pageState = ^(NSInteger seletedIndex){
            if (seletedIndex == 0) {
                [self shareAction];
            } else if (seletedIndex == 1) {
                [self upFromTopAction];
            } else {
                [self deleteFromAction];
            }
        };
    }
    
    if (self.pageState == PageFromStateFromWhy && !self.is_showBottom) {
        
        UCarPhoneOrderView *orderView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([UCarPhoneOrderView class]) owner:nil options:nil] lastObject];
        [self.view addSubview:orderView];
        WS(weakSelf)
        [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(50);
        }];
        
        orderView.pageState = ^(NSInteger seletedIndex) {
            if (seletedIndex == 0) {
                NSString * str= [NSString stringWithFormat:@"telprompt://%@",self.modelData.data.callCenter];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            } else {
                AccommodaCarViewController *accomdaVC = [[AccommodaCarViewController alloc] initWithNibName:@"AccommodaCarViewController" bundle:nil];
                accomdaVC.model = self.modelData;
                [self.navigationController pushViewController:accomdaVC animated:YES];
            }
        };
    }
    
}



- (void)pushToEddie
{
    UCarSendInforViewController *eddieSendCar = [[UCarSendInforViewController alloc] init];
    eddieSendCar.carID = self.carID;
    eddieSendCar.pageState = 1;
    [self.navigationController pushViewController:eddieSendCar animated:YES];
}

#pragma mark Network
- (void)configNetwork
{
    WS(weakSelf)
    [CarbandDetailModel handleWithSuccessBlock:^(id returnValue) {
//        NSLog(@"--%@--", returnValue);
        self.modelData = [CarbandDetailModel new];
        self.modelData = returnValue;
        [self.titleArray addObject:[NSString stringWithFormat:@"外观颜色"]];
        [self.infoArray addObject:self.modelData.data.outsideColor];
        [self.titleArray addObject:[NSString stringWithFormat:@"内饰颜色"]];
        [self.infoArray addObject:self.modelData.data.insideColor];
        [self.titleArray addObject:[NSString stringWithFormat:@"车源类型"]];
        [self.infoArray addObject:self.modelData.data.carSourceSpotsName];
        // 开始漫长判断
        
        if (self.modelData.data.carPlace.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"所在地区"]];
            [self.infoArray addObject:self.modelData.data.carPlace];
        }
        
        NSLog(@"+++ ---  %@", self.modelData.data.brightPointsPackageName);
        if (self.modelData.data.brightPointsDiy.length != 0 || self.modelData.data.brightPointsName.length != 0 || self.modelData.data.brightPointsPackageName.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"配置"]];
            NSLog(@"+++ %@", self.modelData.data);
            NSDictionary *tempDictory = [NSDictionary dictionaryWithObjectsAndKeys:
                                         self.modelData.data.brightPointsPackageName, @"PackageName",
                                         self.modelData.data.brightPointsPackageId, @"PackageID",
                                         self.modelData.data.brightPointsName,@"PointsName",
                                         self.modelData.data.brightPointsDiy, @"PointDiy" ,nil];
            [self configConfig:tempDictory];
            [self.infoArray addObject:tempDictory];
        }
        
      
        
        if (self.modelData.data.arrivePortDate.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"到港时间"]];
            [self.infoArray addObject:self.modelData.data.arrivePortDate];
        }
        
        if (self.modelData.data.proceduresName.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"手续"]];
            [self.infoArray addObject:self.modelData.data.proceduresName];
        }
        
        if (self.modelData.data.salesAreaName.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"销售区域"]];
            [self.infoArray addObject:self.modelData.data.salesAreaName];
        }
        
        if (self.modelData.data.arriveShopDate.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"到店时间"]];
            [self.infoArray addObject:self.modelData.data.arriveShopDate];
        }
        
        if (self.modelData.data.imgs.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"图像"]];
            
            /**< 计算相册图片数量*/
            NSArray *urlArray = [self.modelData.data.imgs componentsSeparatedByString:@","];
            NSMutableArray *tempUrlArray = [urlArray mutableCopy];
            for (NSInteger i = 0; i < tempUrlArray.count; i++) {
                NSString *tempString = [tempUrlArray objectAtIndex:i];
                if ([tempString isEqualToString:@""]) {
                    [tempUrlArray removeObjectAtIndex:i];
                }
            }
            self.imageArray = [tempUrlArray mutableCopy];
            [self.infoArray addObject:self.imageArray];
        }
        
        if (self.modelData.data.remark.length != 0) {
            [self.titleArray addObject:[NSString stringWithFormat:@"备注"]];
            [self.infoArray addObject:self.modelData.data.remark];
        }
        
        
        [weakSelf.view addSubview:weakSelf.tableViewDetail];
        [weakSelf configLayout];
    } WithFailureBlock:^(id error) {
        
    } BrandId:self.carID];
}

#pragma mark 计算亮点和亮点包数量
- (void)configConfig:(NSDictionary *)tempDic
{

        if ([tempDic objectForKey:@"PackageName"]) {
            NSString *tempString = [tempDic objectForKey:@"PackageName"];
            _PackgaeName = [[tempString componentsSeparatedByString:@","] mutableCopy];
            if (tempString.length != 0) {
                for (NSInteger i = 0; i < _PackgaeName.count; i++) {
                    NSString *tempPackName = [_PackgaeName objectAtIndex:i];
                    [self.nameArray addObject:tempPackName];
                }
            }
       }
        if ([tempDic objectForKey:@"PackageID"]) {
            NSString *tempString = [tempDic objectForKey:@"PackageID"];
            if (tempString.length != 0) {
            _PackageID = [[tempString componentsSeparatedByString:@","] mutableCopy];   
            }
        }
        if ([tempDic objectForKey:@"PointsName"]) {
            NSString *tempString = [tempDic objectForKey:@"PointsName"];
            if (tempString.length != 0) {
                _PointsName = [tempString componentsSeparatedByString:@","];
                for (NSInteger i = 0; i < _PointsName.count; i++) {
                    NSString *tempPackName = [_PointsName objectAtIndex:i];
                    [self.nameArray addObject:tempPackName];
                }
            }
        }
        if ([tempDic objectForKey:@"PointDiy"]) {
            _PointDiy = [tempDic objectForKey:@"PointDiy"];
            if (_PointDiy.length != 0) {
                [self.nameArray addObject:_PointDiy];
            }
        }
    
}



#pragma mark Layout
- (void)configLayout
{
    WS(weakSelf);
    CGFloat height = -50;
    if (self.is_showBottom) {
        height = 0;
    }
    [weakSelf.tableViewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view).offset(height);
    }];
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return self.titleArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.pageState == 1 || self.pageState == 2) {
            UCarBHaveSendDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseHeaderDetail];
            cell.numberCodeLabel.text = [NSString stringWithFormat:@"编号:%@",self.modelData.data.productCode];
            cell.carNameLabel.text = [NSString stringWithFormat:@"%@", self.modelData.data.name];
            if (![self.modelData.data.guidPrice isEqualToString:@""]) {
                cell.guidePriceLabel.text = [NSString stringWithFormat:@"%@",self.modelData.data.guidPrice];
                cell.guidePriceLabel.alpha = 1;
                cell.distanceTop.constant = 12.5;
            } else {
                cell.guidePriceLabel.text = @" ";
                cell.distanceTop.constant = -2;
                cell.guidePriceLabel.alpha = 0;
            }
            cell.sendTimeLabel.text  = [NSString stringWithFormat:@"发布时间:%@", self.modelData.data.datetime];
            cell.priceLabel.text = [NSString stringWithFormat:@"%.2f万",[self.modelData.data.price floatValue]];
            
            cell.pageState = self.pageState - 1;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (self.pageState == 3) {
            CarDetailOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CarbandDetailModel1 *model1 = (CarbandDetailModel1 *)self.modelData.data;
            if (self.fromVC.length != 0) {
                [cell setStatus:@"u特价"];
            }
            [cell setModel:model1];
            return cell;
        }
        
    } else  {
        UCarHaveSendOrderMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseOrderMore];
        if (![[self.titleArray objectAtIndex:indexPath.row] isEqualToString:@"配置"] && ![[self.titleArray objectAtIndex:indexPath.row] isEqualToString:@"图像"]) {
            cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
            cell.infoLabel.text = [self.infoArray objectAtIndex:indexPath.row];
            if ([cell.titleLabel.text isEqualToString:@"备注"]) {
                cell.infoLabel.numberOfLines = 0;
            }
        } else {
            if ([[self.titleArray objectAtIndex:indexPath.row] isEqualToString:@"配置"]) {
                UCarHaveSendConfigableViewCell *cellConfig = [tableView dequeueReusableCellWithIdentifier:reuseConfigCell];
                [self configureCell:cellConfig atIndexPath:indexPath];
                __weak SKTagView *weakView = cellConfig.tagView;
                weakView.didTapTagAtIndex = ^(NSUInteger index){
                    UCarBCarShowPageDetailTableViewController *detailVC = [[UCarBCarShowPageDetailTableViewController alloc] init];
                    detailVC.brightPackageId = [_PackageID objectAtIndex:index];
                    detailVC.title = [_PackgaeName objectAtIndex:index];
                    [self.navigationController pushViewController:detailVC animated:YES];
                };
                cellConfig.selectionStyle = UITableViewCellSelectionStyleNone;
                return cellConfig;
            }
            
            if ([[self.titleArray objectAtIndex:indexPath.row] isEqualToString:@"图像"]) {
                UCarBHaveSendImageMoreTableViewCell *cellImage = [tableView dequeueReusableCellWithIdentifier:reuseImageMore];
                [cellImage.backWhiteView addSubview:self.collectionViewImage];
                WS(weakSelf)
                [weakSelf.collectionViewImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(cellImage.backWhiteView);
                }];
                cellImage.selectionStyle = UITableViewCellSelectionStyleNone;
                return cellImage;
            }
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (self.pageState) {
            case 1:
                  return 116;
                break;
            case 2:
                return 116;
                break;
            case 3:
                return 160;
                break;
            default:
                break;
        }
        
        
    } else {
        if ([[self.titleArray objectAtIndex:indexPath.row] isEqualToString:@"配置"]) {
            UCarHaveSendConfigableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseConfigCell];
            [self configureCell: cell atIndexPath: indexPath];
            return [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height + 1 ;
        } else if ([[self.titleArray objectAtIndex:indexPath.row] isEqualToString:@"图像"]) {
            CGFloat collectionImageCellWidth  = SCREENWIDTH - 92 * LAYOUT_SIZE - 8 - 25;
            if (self.imageArray.count <= 4) {
                return collectionImageCellWidth / 4 + 16;
            } else {
                return collectionImageCellWidth / 2 + 16;
            }
        }
        else if ([[self.titleArray objectAtIndex:indexPath.row] isEqualToString:@"备注"]) {
           NSString *markString = [self.infoArray objectAtIndex:indexPath.row];
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [markString boundingRectWithSize:CGSizeMake( SCREENWIDTH - 112,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            return rect.size.height + 16;
        }
        else {
        return 45;
        }}
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark CollectionViewDataSrouce
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBCarImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCollectionView forIndexPath:indexPath];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",self.modelData.data.imageSMURL,[self.imageArray objectAtIndex:indexPath.item]];
    [cell.imageCollectionViewCell sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"PlaceHolderImage"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectImg:indexPath];
}


#pragma mark MWPhotoBrower
- (void)selectImg:(NSIndexPath *)index
{
    self.thumbs = [NSMutableArray new];
    for (NSString *str in self.imageArray) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.modelData.data.imageURL,str]]];
        [self.thumbs addObject:photo];
    }
    MWPhotoBrowser *photoBrowers = [[MWPhotoBrowser alloc] initWithDelegate:self];
    photoBrowers.displayActionButton = NO;
    photoBrowers.displayNavArrows = NO;
    photoBrowers.displaySelectionButtons = NO;
    photoBrowers.alwaysShowControls = NO;
    photoBrowers.zoomPhotosToFill = YES;
    photoBrowers.enableGrid = NO;
    photoBrowers.startOnGrid = NO;
    photoBrowers.enableSwipeToDismiss = YES;
    photoBrowers.autoPlayOnAppear = YES;
    [photoBrowers setCurrentPhotoIndex:index.item];
    [self.navigationController pushViewController:photoBrowers animated:YES];
}
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _thumbs.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}


- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}


#pragma mark Set/Get
-(UITableView *)tableViewDetail
{
    if (_tableViewDetail == nil) {
        UITableView *tempView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempView.backgroundColor = BACKGROUNDCOLOR;
        tempView.delegate = self;
        tempView.dataSource = self;
        [tempView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBHaveSendDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseHeaderDetail];
        [tempView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarHaveSendOrderMoreTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseOrderMore];
        [tempView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBHaveSendImageMoreTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseImageMore];
        [tempView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarHaveSendConfigableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseConfigCell];
        [tempView registerNib:[UINib nibWithNibName:@"CarDetailOneTableViewCell" bundle:nil] forCellReuseIdentifier:cellStr];
        _tableViewDetail = tempView;
    }
    return _tableViewDetail;
}

- (CarbandDetailModel *)modelData
{
    if (_modelData == nil) {
        CarbandDetailModel *tempData = [[CarbandDetailModel alloc] init];
        _modelData = tempData;
    }
    return _modelData;
}

- (NSMutableArray *)infoArray
{
    if (_infoArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        _infoArray = tempArray;
    }
    return _infoArray;
}

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        _titleArray = tempArray;
    }
    return _titleArray;
}

- (NSMutableArray *)nameArray
{
    if (_nameArray == nil) {
        NSMutableArray *tempArr = [NSMutableArray new];
        _nameArray = tempArr;
    }
    return _nameArray;
}

- (NSArray *)imageArray
{
    if (_imageArray == nil) {
        NSArray *tempArray = [NSArray new];
        _imageArray = tempArray;
    }
    return _imageArray;
}

- (UICollectionView *)collectionViewImage
{
    if (_collectionViewImage == nil) {
        UICollectionViewFlowLayout *tempFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        tempFlowLayout.minimumInteritemSpacing = 5;
        tempFlowLayout.minimumLineSpacing = 5;
        CGFloat collectionImageCellWidth  = SCREENWIDTH - 92 * LAYOUT_SIZE - 8 - 25;
        tempFlowLayout.itemSize = CGSizeMake(collectionImageCellWidth / 4, collectionImageCellWidth / 4);
        UICollectionView *tempCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:tempFlowLayout];
        tempCollectionView.backgroundColor = [UIColor whiteColor];
        [tempCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseCollectionView];
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        tempCollectionView.scrollEnabled = NO;
        _collectionViewImage = tempCollectionView;
    }
    return _collectionViewImage;
}

- (void)configureCell: (UCarHaveSendConfigableViewCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    cell.tagView.preferredMaxLayoutWidth = SCREENWIDTH - 8 - 92 *LAYOUT_SIZE;
    cell.tagView.padding = UIEdgeInsetsMake(12, -5, 12, 5);
    cell.tagView.interitemSpacing = 5;
    cell.tagView.lineSpacing = 5;
    [cell.tagView removeAllTags];
    //Add Tags
    [self.nameArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:obj];
        tag.padding = UIEdgeInsetsMake(3, 8, 3, 8);
        tag.fontSize = 15;
        tag.cornerRadius = 12;
        if (idx < _PackageID.count) {
            tag.textColor = HEXCOLOR(0xff5000);
            tag.bgColor = BACKGROUNDCOLOR;
            tag.borderColor = HEXCOLOR(0xff5000);
            tag.enable = YES;
        } else if (idx < _PackageID.count + _PointsName.count) {
            tag.textColor = HEXCOLOR(0x333333);
            tag.bgColor = BACKGROUNDCOLOR;
            tag.borderColor = BACKGROUNDCOLOR;
            tag.enable = NO;
        } else {
            tag.textColor = HEXCOLOR(0x333333);
            tag.bgColor = [UIColor whiteColor];
            tag.borderColor = [UIColor whiteColor];
            tag.padding = UIEdgeInsetsMake(3, 5, 3, 8);
            tag.enable = NO;
        }
        [cell.tagView addTag:tag];

    }];
}

#pragma mark 上架下架删除
/**
 *  置顶
 */
- (void)upToTopAction
{
    [UCarPublishMainNetwork PUTCarUpToTopOrBottom:self.carID flag:@"1" UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
        NSDictionary *blkDic = returnValue;
        NSNumber *codeID =  [blkDic objectForKey:@"code"];
        if ([codeID isEqualToNumber:@0]) {
            //                        [self.tableViewHaveSend moveSection:sectionNumber toSection:0];
            [self showHint:@"置顶成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msg = [blkDic objectForKey:@"msg"];
            [self showHint:msg];
        }
    } faliureBlk:^(id error) {
        
    }];
}
/**
 *  取消置顶
 */
- (void)cancleUpToTopAction
{
    [UCarPublishMainNetwork PUTCarUpToTopOrBottom:self.carID flag:@"0" UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
        NSDictionary *blkDic = returnValue;
        NSNumber *codeID =  [blkDic objectForKey:@"code"];
        if ([codeID isEqualToNumber:@0]) {
            //                        [self.tableViewHaveSend moveSection:sectionNumber toSection:0];
            [self showHint:@"置顶成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msg = [blkDic objectForKey:@"msg"];
            [self showHint:msg];
        }
    } faliureBlk:^(id error) {
        
    }];
}

/**
 *  上架
 */
- (void)upFromTopAction
{
    [UCarPublishMainNetwork PUTCarUpDownMarket:self.carID upDownState:@1 UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
        NSDictionary *blkDic = returnValue;
        NSNumber *codeId = [blkDic objectForKey:@"code"];
        if ([codeId isEqualToNumber:@0]) {
            [self showHint:@"上架成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msg = [blkDic objectForKey:@"msg"];
            [self showHint:msg];
        }
        
    } failureBlk:^(id error) {
        
    }];

}
/**
 *  下架
 */
- (void)downFromTopAction
{
    [UCarPublishMainNetwork PUTCarUpDownMarket:self.carID upDownState:@2 UserId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
        NSDictionary *blkDic = returnValue;
        NSNumber *codeId = [blkDic objectForKey:@"code"];
        if ([codeId isEqualToNumber:@0]) {
            [self showHint:@"下架成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msg = [blkDic objectForKey:@"msg"];
            [self showHint:msg];
        }
        
    } failureBlk:^(id error) {
        
    }];

}
/**
 *  删除
 */
- (void)deleteFromAction
{
    [UCarPublishMainNetwork DELETECarGoods:self.carID userId:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
        NSDictionary *blkDic = returnValue;
        NSNumber *codeID = [blkDic objectForKey:@"code"];
        if ([codeID isEqualToNumber:@0]) {
            [self showHint:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msg = [blkDic objectForKey:@"msg"];
            [self showHint:msg];
        }
    } failure:^(id error) {
        
    }];
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
