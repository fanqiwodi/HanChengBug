//
//  ShoppingPartDetailViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingPartDetailViewController.h"
#import "ShoppingPartDetailOrderTableViewCell.h"
#import "ShoppingPartDetailTextTableViewCell.h"
#import "ShoppingPartImageViewTableViewCell.h"
#import "HMSegmentedControl.h" // 选择图片文字按钮
#import "SDCycleScrollView.h" //轮播
#import "ShoppingNetwork.h"
#import "UCarBGetGoodsPartsDetailsF29.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "ShoppingMakeSureViewController.h"


static NSString *const reuseDetailOrder = @"ShoppingPartDetailOrderTableViewCell";
static NSString *const reuseTextCell = @"ShoppingPartDetailTextTableViewCell";
static NSString *const reuseImageCell = @"ShoppingPartImageViewTableViewCell";
@interface ShoppingPartDetailViewController () <UITableViewDataSource,UITableViewDelegate, SDCycleScrollViewDelegate, UIAlertViewDelegate, UMSocialUIDelegate>

@property (nonatomic, strong) UITableView *tableViewDetail;
//@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSArray *imageSizeArray;
@property (strong, nonatomic) HMSegmentedControl *carInfoStatus;
@property (nonatomic, strong) UCarBGetGoodsPartsDetailsF29_data *dataModelSource;
@property (nonatomic, strong) UILabel *imageTitleLabel;
@property (nonatomic, strong) NSMutableArray *titleNameArray;
@end

@implementation ShoppingPartDetailViewController
{
    __weak IBOutlet UIView *phoneView;
    __weak IBOutlet UIView *lineView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"商品详情";
    self.bottomHeight.constant = 49 * LAYOUT_SIZE;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    self.phoneCallWidth.constant = 125 * LAYOUT_SIZE;
    
    if (self.is_show) {
        self.readyToBuy.alpha = phoneView.alpha = lineView.alpha = 0;
        self.bottomHeight.constant = 0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNetWork];
    [self setSegment];
}




#pragma mark BottomButtons
- (IBAction)phoneConsultingAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://4000308181" ]];
}

- (IBAction)readyTobuyConsultingAction:(id)sender {
    
    ShoppingMakeSureViewController *shopMakeSureBuy = [[ShoppingMakeSureViewController alloc] init];
    shopMakeSureBuy.partDetailID = self.partDetailID;
    shopMakeSureBuy.infoName = self.dataModelSource.name;
    shopMakeSureBuy.infoPrice = [NSString stringWithFormat:@"%@元",self.dataModelSource.shopPrice];
    [self.navigationController pushViewController:shopMakeSureBuy animated:YES];
    
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.message isEqualToString:@"400-030-8181"] && buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://4000308181" ]];
    }
}



#pragma mark NetWork
- (void)configNetWork
{
    [ShoppingNetwork GETGoodsPartsDetailsID:self.partDetailID successBlk:^(id returnValue) {
        UCarBGetGoodsPartsDetailsF29_data *model = returnValue;
        self.dataModelSource = model;
         NSArray *tempUrlArray = [self.dataModelSource.detailImgs componentsSeparatedByString:@","];
        for (NSString *tempUrl in tempUrlArray) {
            NSString *url = [NSString stringWithFormat:@"%@/%@",self.dataModelSource.imageURL, tempUrl];
            [self.imageArray addObject:url];
        }
        [self.view addSubview:self.tableViewDetail];
        [self configLayout];
    } failureBlk:^(id error) {

    }];
}

#pragma mark Layout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view);
        make.left.and.right.mas_equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.readyToBuy.mas_top);
    }];
}



#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        if (self.carInfoStatus.selectedSegmentIndex == 0) {
            return 1;
        } else {
            return self.imageArray.count;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ShoppingPartDetailOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseDetailOrder];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infoLabel.text = self.dataModelSource.name;
//        if ([self.dataModelSource.shopPrice1 isEqualToString:@""] || [self.dataModelSource.shopPrice isEqualToString:@""]) {
            cell.infoPriceLabel.text = [NSString stringWithFormat:@"%@元",self.dataModelSource.shopPrice];
//        } else {
//            cell.infoPriceLabel.text = [NSString stringWithFormat:@"%@ - %@元",self.dataModelSource.shopPrice,self.dataModelSource.shopPrice1];
//        }
        return cell;
    } else {
        if (self.carInfoStatus.selectedSegmentIndex == 0) {
            ShoppingPartDetailTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTextCell];
            if (_dataModelSource != nil) {
                cell.inforLabel.text = self.dataModelSource.describe;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            ShoppingPartImageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseImageCell];
            [cell.infoImageView sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"PlaceHolderImage"]];
//            imageURL = [NSURL URLWithString:[self.imageArray objectAtIndex:indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSArray *imageNameArray = [self.dataModelSource.detailImg componentsSeparatedByString:@","];
        NSMutableArray *imageURLS = [NSMutableArray array];
        for (NSString *urlString in imageNameArray) {
            NSString *url = [NSString stringWithFormat:@"%@/%@",self.dataModelSource.imageURL,urlString];
            [imageURLS addObject:url];
        }
        SDCycleScrollView *sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 226 *LAYOUT_SIZE) imageURLStringsGroup:imageURLS];
        sdCycleScrollView.autoScroll = NO;
        sdCycleScrollView.showPageControl = NO;
        sdCycleScrollView.placeholderImage = [UIImage imageNamed:@"PlaceHolderImage"];
        sdCycleScrollView.delegate = self;
        [sdCycleScrollView addSubview:self.imageTitleLabel];
        WS(weakSelf)
        [weakSelf.imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
            make.right.and.bottom.mas_equalTo(sdCycleScrollView).offset(-12);
        }];
        
        for (NSInteger i = 0 ; i < imageNameArray.count; i++) {
            NSString *title = [NSString stringWithFormat:@"  %ld/%ld  ",i + 1,imageNameArray.count];
            [self.titleNameArray addObject:title];
        }
        

        return sdCycleScrollView;
    }else {
        return _carInfoStatus;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 226 *LAYOUT_SIZE;
    }else {
        return 46 *LAYOUT_SIZE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 88;
    } else {
        if (self.carInfoStatus.selectedSegmentIndex == 0) {
            NSDictionary *attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [self.dataModelSource.describe boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil];
            if (rect.size.height < SCREENHEIGHT - 95 * LAYOUT_SIZE - 64) {
                return SCREENHEIGHT - 49 * LAYOUT_SIZE - 46 *LAYOUT_SIZE - 64;
            } else {
            return rect.size.height + 60;
            }
        } else {
            return 250;
        }
    }
}


#pragma mark SegmengControl Action
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"%ld",(long)segmentedControl.selectedSegmentIndex);
    if (segmentedControl.selectedSegmentIndex == 1) {
    [self.tableViewDetail reloadSection:1 withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
    [self.tableViewDetail reloadSection:1 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark SDCyleScrollView
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didShowItemAtIndex:(NSInteger)index
{
    self.imageTitleLabel.text = [self.titleNameArray objectAtIndex:index];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}

#pragma mark SET/GET
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        _imageArray = tempArray;
    }
    return _imageArray;
}

- (NSArray *)imageSizeArray
{
    if (_imageSizeArray == nil) {
        NSArray *tempArray = [NSArray array];
        _imageSizeArray = tempArray;
    }
    return _imageSizeArray;
}


- (UCarBGetGoodsPartsDetailsF29_data *)dataModelSource
{
    if (_dataModelSource == nil) {
        UCarBGetGoodsPartsDetailsF29_data *tempData = [[UCarBGetGoodsPartsDetailsF29_data alloc] init];
        _dataModelSource = tempData;
    }
    return _dataModelSource;
}

- (UITableView *)tableViewDetail
{
    if (_tableViewDetail == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
//        tempTableView.pagingEnabled = YES;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingPartDetailOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseDetailOrder];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingPartDetailTextTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseTextCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingPartImageViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseImageCell];
        _tableViewDetail = tempTableView;
    }
    return _tableViewDetail;
}

- (void)setSegment
{
    self.carInfoStatus = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 46*LAYOUT_SIZE)];
    self.carInfoStatus.sectionTitles = @[@"文字描述", @"图片介绍"];
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
    
    
    // Segment 中间竖线
    self.carInfoStatus.verticalDividerEnabled = YES;
    self.carInfoStatus.verticalDividerColor = BACKGROUNDCOLOR;
    self.carInfoStatus.verticalDividerWidth = 2;
}

- (UILabel *)imageTitleLabel
{
    if (_imageTitleLabel == nil) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        tempLabel.textColor = HEXCOLOR(0xffffff);
//        tempLabel.text =@"asdopksado";
        tempLabel.font = Font(17);
        tempLabel.backgroundColor = HEXACOLOR(0x000000, 0.5);
        tempLabel.layer.cornerRadius = 13;
        tempLabel.layer.masksToBounds = YES;
        tempLabel.textAlignment = NSTextAlignmentLeft;
        _imageTitleLabel = tempLabel;
    }
    return _imageTitleLabel;
}

- (NSMutableArray *)titleNameArray
{
    if (_titleNameArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        _titleNameArray = tempArray;
    }
    return _titleNameArray;
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
