//
//  UCarSendInforViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarSendInforViewController.h"
#import "UCarBOrderTypeTableViewCell.h"
#import "UCarBInputTableViewCell.h"          /** Cell */
#import "UCarBTextFieldTableViewCell.h"
#import "UCarBOrderTypePriceTableViewCell.h"
#import "UCarBCarImageCollectionViewCell.h"
#import "UCarBCarSourceTypeModel.h"          /**< Model */
#import "UCarBCarInfoChooseThirdTypeMode.h"
#import "UCarBCarSourceTypeViewController.h"     /**< PUSH */
#import "UCarBCarInfoTypeViewController.h"
#import "UCarBCarSourceLocationViewController.h" /**< 车源所在地*/
#import "UCarPriceViewController.h"              /**< 报价 */
#import "UCarBCatOutsideViewController.h"        /**< 外饰颜色*/
#import "UCarBCarSellLocationViewController.h"   /**< 销售区域额*/
#import "UCarBDocumentViewController.h"          /**< 手续*/
#import "UCarBCarConfigureViewController.h"      /**< 配置*/
#import "UCarBChooseImageViewController.h"       /**< 图像*/
#import "UCarBCarFormateDateUpdateModel.h"       /**<上传Model*/
#pragma mark 编辑
#import "UCarHaveSendNetWork.h"
#import "UCarBHaveSendModelDetail.h"
typedef NS_ENUM(NSInteger, TypeState) {
    TypeStateSourceNormal = 0,         /**< 默认进入页面 */
    TypeStateSourceTypeOnlyChinaNow,   /**< 国产现车     */
    TypeStateSourceTypeBothChinaNow,
    TypeStateSourceTypeOnlyCaupdNow,   /**< 中规现车     */
    TypeStateSourceTypeBothCaupdNow,
    TypeStateSourceTypeOnlyCaupdFuture,/**< 中规期货     */
    TypeStateSourceTypeBothCaupdFuture,
    TypeStateSourceTypeOnlyUSNow,      /**< 美规现车 其他现车   */
    TypeStateSourceTypeBothUSNow,
    TypeStateSourceTypeOnlyUSFuture,   /**< 美规期货 其他期货   */
    TypeStateSourceTypeBothUSFuture,
};
static NSString *const reuseOrderCell = @"UCarBReuseOrderTypeTableViewCell";
static NSString *const reuseInputCell = @"UCarBReuseInputTableViewCell";
static NSString *const reuseInPutTextField = @"UCarBTextFieldTableViewCell";
static NSString *const reusePriceLabel = @"UCarBOrderTypePriceTableViewCell";
static NSString *const reuseCollectionViewCell = @"UCarBCarImageCollectionViewCell";
@interface UCarSendInforViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableViewUCarStock;
@property (nonatomic, strong) NSArray *allArray;                  /**< 所有状态的对应数组, datasource从中取出,根据pageTypeState */
@property (nonatomic, assign) TypeState pageTypeState;            /**< 当前页面的状态 */
@property (nonatomic, assign) NSInteger tempState;                /**< 页面上次状态, 存在的原因是为了解决重选同一个车品导致的pagetypestate+1的问题*/
@property (nonatomic, strong) NSNumber *carSourceCategoryId;      /**< 选择第一级之后 使用ID获得对应车型*/
@property (nonatomic, strong) NSNumber *goodsTemplateId;          /**< 第二个Cell返回参数 自定义车型记得删除*/
@property (nonatomic, strong) NSString *guidePrice;               /**< 指导价  自定义记得清空*/
@property (nonatomic, strong) NSString *showPriceText;            /**< 自定义价格输入框*/
@property (nonatomic, strong) NSString *nameDiy;                  /**< 上传自定义车型名称*/
@property (nonatomic, strong) NSMutableArray *infoArray;          /**< 为了搞定重用机制, 后面存在的值只能存在一个三维数组*/
@property (nonatomic, strong) UCarBCarFormateDateUpdateModel *dataModel; /**<最终上传时候的Model*/
@property (nonatomic, strong) NSNumber *goodsCategoryIdLevel1;
@property (nonatomic, strong) NSMutableArray *userURLImageArray;  /**< 图片网址数组*/
@property (nonatomic, strong) UITextView *moreInfoTextView;
@property (nonatomic, strong) NSNotificationCenter *centerNotification;
#pragma mark Edit
@property (nonatomic, strong) UCarBHaveSendModelDetail_data *modelData;
@end
@implementation UCarSendInforViewController

// 隐藏底部bar;


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title                             = @"入库";
    self.view.backgroundColor              = BACKGROUNDCOLOR;
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    /** < 页面主车源类型初始化*/
    self.pageTypeState                     = TypeStateSourceNormal;
    self.tempState                         = TypeStateSourceNormal;

    /**< 通知中心初始化*/
    [self startRegisterNotificationCenter];

    /**< TableView Setter*/
    [self.view addSubview:self.tableViewUCarStock];
    [self configLayout];
    [self updataTableView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendNewCar:)];

    if (self.pageState == 1) {
        [self configNetwork];
    }
}

// 伟大的通知中心们, 都不如用响应式~
- (void)startRegisterNotificationCenter
{
    self.centerNotification = [NSNotificationCenter defaultCenter];
    [self.centerNotification addObserver:self selector:@selector(setCarTypeName:) name:CENTERCARTYPE object:nil];             // 汽车细分最细类别
    [self.centerNotification addObserver:self selector:@selector(changeCellColor:) name:CENTERCARCOLOR object:nil];           // 颜色
    [self.centerNotification addObserver:self selector:@selector(changeSalArea:) name:CENTERSALAREA object:nil];              // 自定义销售区域
    [self.centerNotification addObserver:self selector:@selector(changeConfig:) name:CENTERCONFIG object:nil];                //自定义配置
    [self.centerNotification addObserver:self selector:@selector(changeArriveTime:) name:CENTERARRIVETIME object:nil];        // 到店时间
    [self.centerNotification addObserver:self selector:@selector(changeArriveAirport:) name:CENTERARRIVEAIRPORT object:nil];  // 到港时间
    [self.centerNotification addObserver:self selector:@selector(changeFrameNumber:) name:CENTERFRAMENUMBER object:nil];      // 车架号
    [self.centerNotification addObserver:self selector:@selector(changeDocument:) name:CENTERDOCUMENT object:nil];            // 手续
}

// 根据界面状态刷新TableView
- (void)updataTableView
{
    self.dataSource = [self.allArray objectAtIndex:self.pageTypeState];
    [self.tableViewUCarStock reloadData];
}

#pragma mark NotificationCenter 
/**< 汽车详细类型*/
- (void)setCarTypeName:(NSNotification *)notification
{
    NSIndexPath *indexPathDetailCar = [NSIndexPath indexPathForRow:1 inSection:0];
    if ([notification.object isMemberOfClass:[UCarBCarInfoChooseThirdTypeMode_datalist class]]) {
        UCarBCarInfoChooseThirdTypeMode_datalist *model = notification.object;
        self.goodsTemplateId = model.goodsTemplateId;
        [self setReplaceStringAt:indexPathDetailCar withString:model.name];
        self.guidePrice = model.guidePrice;
        self.dataModel.goodsCategoryIdLevel2 = [notification.userInfo objectForKey:@"goodsCategoryIdLevel2"];
        self.dataModel.carSourceCategoryId = [notification.userInfo objectForKey:@"carSourceCategoryId"];
        self.dataModel.brandId = [notification.userInfo objectForKey:@"brandId"];
        self.goodsCategoryIdLevel1 = self.dataModel.goodsCategoryIdLevel1 = [notification.userInfo objectForKey:@"goodsCategoryIdLevel1"];
        switch (self.pageTypeState) {
            case TypeStateSourceTypeOnlyChinaNow: case TypeStateSourceTypeOnlyCaupdNow: case TypeStateSourceTypeOnlyCaupdFuture: case TypeStateSourceTypeOnlyUSNow: case TypeStateSourceTypeOnlyUSFuture:
                self.pageTypeState ++;
                break;
            default:
                break;
        }
        [self updataTableView];
    } else if ([notification.object isKindOfClass:[NSString class]]){
        self.dataModel.goodsCategoryIdLevel2 = [notification.userInfo objectForKey:@"goodsCategoryIdLevel2"];
        self.dataModel.carSourceCategoryId = [notification.userInfo objectForKey:@"carSourceCategoryId"];
        self.dataModel.brandId = [notification.userInfo objectForKey:@"brandId"];
        self.goodsCategoryIdLevel1 = self.dataModel.goodsCategoryIdLevel1 = [notification.userInfo objectForKey:@"goodsCategoryIdLevel1"];
        self.pageTypeState = self.tempState;
        self.goodsTemplateId = nil;
        [self setReplaceStringAt:indexPathDetailCar withString:notification.object];
        self.nameDiy = notification.object;
        [self updataTableView];
    }
    else {
        self.goodsTemplateId = nil;
        [self setReplaceStringAt:indexPathDetailCar withString:@""];
    }
}

/**< 内饰外饰颜色*/
- (void)changeCellColor:(NSNotification *)notification
{
    NSDictionary *tempDictory = notification.object;
    NSIndexPath *indexPathOutColor = [[NSIndexPath alloc] init];
    NSIndexPath *indexPathInSideColor = [[NSIndexPath alloc] init];
    for (NSInteger i = 0; i< _dataSource.count; i++) {
        NSArray *tempArray = _dataSource[i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *tempString = tempArray[j];
            if ([tempString isEqualToString:WARTHOUSE_WGYS]) {
                NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                indexPathOutColor = tempIndexPath;}
            if ([tempString isEqualToString:WARTHOUSE_NSYS]) {
                NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                indexPathInSideColor = tempIndexPath;}}}
    NSString *viewState = [tempDictory objectForKey:@"Color"];
    if ([viewState isEqualToString:@"0"]) {
    [self setReplaceStringAt:indexPathOutColor withString:[tempDictory objectForKey:@"Text"]];
        self.dataModel.outsideColorDiy = [tempDictory objectForKey:@"Text"];
        self.dataModel.outsideColor = @"";}
    if ([viewState isEqualToString:@"1"]) {
    [self setReplaceStringAt:indexPathInSideColor withString:[tempDictory objectForKey:@"Text"]];
        self.dataModel.insideColorDiy = [tempDictory objectForKey:@"Text"];
        self.dataModel.insideColor = @"";}
}

/**< 自定义销售区域*/
- (void)changeSalArea:(NSNotification *)notification
{
    NSIndexPath *salArea;
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        NSArray *tempArray = _dataSource[i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *tempsString = [tempArray objectAtIndex:j];
            if ([tempsString isEqualToString:WARTHOUSE_XSQY]) {
                salArea = [NSIndexPath indexPathForRow:j inSection:i];
                [self setReplaceStringAt:salArea withString:notification.object];}}}
    self.dataModel.salesAreaDiy = notification.object;
    self.dataModel.salesArea = nil;
}

#warning 需求变更废弃此通知
- (void)changeConfig:(NSNotification *)notification /**< 自定义配置*/
{
    NSIndexPath *salArea;
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        NSArray *tempArray = _dataSource[i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *tempsString = [tempArray objectAtIndex:j];
            if ([tempsString isEqualToString:WARTHOUSE_PZ]) {
                salArea = [NSIndexPath indexPathForRow:j inSection:i];
                [self setReplaceStringAt:salArea withString:notification.object];}}}
}

-(void)changeArriveTime:(NSNotification *)notification /** 到店时间*/
{
    NSIndexPath *salArea;
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        NSArray *tempArray = _dataSource[i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *tempsString = [tempArray objectAtIndex:j];
            if ([tempsString isEqualToString:WARTHOUSE_DDSJ]) {
                salArea = [NSIndexPath indexPathForRow:j inSection:i];
                [self setReplaceStringAt:salArea withString:notification.object];}}}
    self.dataModel.arriveShopDate = notification.object;
}

-(void)changeArriveAirport:(NSNotification *)notification /** 到港时间*/
{
    NSIndexPath *salArea;
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        NSArray *tempArray = _dataSource[i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *tempsString = [tempArray objectAtIndex:j];
            if ([tempsString isEqualToString:WARTHOUSE_DGSJ]) {
                salArea = [NSIndexPath indexPathForRow:j inSection:i];
                [self setReplaceStringAt:salArea withString:notification.object];}}}
    self.dataModel.arrivePortDate = notification.object;
}

-(void)changeFrameNumber:(NSNotification *)notification /** 车架号*/
{
    NSIndexPath *salArea;
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        NSArray *tempArray = _dataSource[i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *tempsString = [tempArray objectAtIndex:j];
            if ([tempsString isEqualToString:WARTHOUSE_CJH]) {
                salArea = [NSIndexPath indexPathForRow:j inSection:i];
                [self setReplaceStringAt:salArea withString:notification.object];}}}
    self.dataModel.frameNum = notification.object;
}

- (void)changeDocument:(NSNotification *)notification /** < 手续*/
{
    NSIndexPath *salArea;
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        NSArray *tempArray = _dataSource[i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *tempsString = [tempArray objectAtIndex:j];
            if ([tempsString isEqualToString:WARTHOUSE_SX]) {
                salArea = [NSIndexPath indexPathForRow:j inSection:i];
                [self setReplaceStringAt:salArea withString:notification.object];}}}
    self.dataModel.proceduresDiy = notification.object;
    self.dataModel.procedures = nil;
}

#pragma mark AutoLayout
- (void)configLayout{
    WS(weakSelf);
    [weakSelf.tableViewUCarStock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);}];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 3;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ return [_dataSource[section] count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UCarBInputTableViewCell *cellTextView       = [tableView dequeueReusableCellWithIdentifier:reuseInputCell];// 备注Cell
    cellTextView.inPutTextField.text            = self.moreInfoTextView.text;
    self.moreInfoTextView                       = cellTextView.inPutTextField;
    UCarBOrderTypeTableViewCell *cellOrder      = [tableView dequeueReusableCellWithIdentifier:reuseOrderCell];// 普通cell
    UCarBTextFieldTableViewCell *cellTextField  = [tableView dequeueReusableCellWithIdentifier:reuseInPutTextField];//输入万元
    cellTextField.inputPriceTextField.text      = self.showPriceText;
    cellTextField.inputPriceTextField.delegate  = self;
    UCarBOrderTypePriceTableViewCell *cellPrice = [tableView dequeueReusableCellWithIdentifier:reusePriceLabel];
    cellOrder.titleLabel.text                   = _dataSource[indexPath.section][indexPath.row];
    cellPrice.priceLabel.text                   = [NSString stringWithFormat:@"%.2f万",[self.guidePrice floatValue]];

    cellOrder.infoLabel.text                    = self.infoArray[indexPath.section][indexPath.row];

    cellTextField.selectionStyle                = UITableViewCellSelectionStyleNone;
    cellOrder.selectionStyle                    = UITableViewCellSelectionStyleNone;
    cellTextField.selectionStyle                = UITableViewCellSelectionStyleNone;
    cellPrice.selectionStyle                    = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                return cellOrder;}
            else { return cellTextView; } }
    else { if (indexPath.section == 1) { return cellOrder; }
    else {
        if (self.pageTypeState == TypeStateSourceNormal || self.pageTypeState == TypeStateSourceTypeOnlyChinaNow || self.pageTypeState == TypeStateSourceTypeOnlyCaupdNow || self.pageTypeState == TypeStateSourceTypeOnlyUSNow || self.pageTypeState == TypeStateSourceTypeOnlyUSFuture || self.pageTypeState == TypeStateSourceTypeOnlyCaupdFuture || self.pageTypeState == TypeStateSourceTypeBothUSNow || self.pageTypeState == TypeStateSourceTypeBothUSFuture) {
            if (indexPath.row == 2) { return cellTextField; }
            else { return cellOrder; } }
        else { if (indexPath.row == 3) { return cellOrder; }
        else if (indexPath.row == 2) { return cellPrice; }
        else { return cellOrder;}}}}
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {     /**< 首行 */
        if ([self.carSourceCategoryId isEqualToNumber:@0]) {
            [self didSelectedGetCarSourceCategoryId];
        } else {
            if (self.pageState == 1) {
                UIAlertView *alertMakeSureUnuse = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"重新编辑不可重置车源" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertMakeSureUnuse show]; }
            else {
        UIAlertView *alertMakeSure = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"重置车源将会删除已经选择的信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认重置",@"取消", nil];
                [alertMakeSure show];}} return; }
    else { if ([self.carSourceCategoryId isEqualToNumber:@0]) {
            [self showHint:@"请选择车源类型"]; return;}}

    if (indexPath.section == 0 && indexPath.row == 1) {     /**< 第二行 */
    if ([self.infoArray[0][1] isEqualToString:@""]) { [self GetRowOneSectionZero]; }
    else { if (self.pageState == 1) {
            UIAlertView *alertMakeSureUnuse = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"重新编辑不可重置车型" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alertMakeSureUnuse show]; }
    else {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"重置车型将会删除已经选择的信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认重置",@"取消", nil];
    [alertView show]; }}}
    else { if ([self.infoArray[0][1] isEqualToString:@""]) {
            [self showHint:@"请选择对应车型"]; return; }}
    [self pushToChooseViewController:indexPath];
}

- (void)pushToChooseViewController:(NSIndexPath *)indexPath{
    NSString *selectTitle = _dataSource[indexPath.section][indexPath.row];
    if ([selectTitle isEqualToString:WARTHOUSE_BJ]) {     /**< 报价*/
        if (indexPath.row != 2) {         // 确保只有无文字输入框的可以push
        UCarPriceViewController *priceViewController = [[UCarPriceViewController alloc] initWithNibName:NSStringFromClass([UCarPriceViewController class]) bundle:nil];
            priceViewController.priceBlock = ^(NSInteger buttonState, NSString *price){
                NSString *priceLabel = [NSString string];
                self.dataModel.goodPrice = [NSNumber numberWithInteger:buttonState+1];
                self.dataModel.goodPriceCount = [NSNumber numberWithInteger:[price integerValue]];
                switch (buttonState) {
                    case 0:
                        priceLabel = [NSString stringWithFormat:@"优惠 %@ 点",price];
                        break;
                    case 1:
                        priceLabel = [NSString stringWithFormat:@"优惠 %@ 万",price];
                        break;
                    case 2:
                        priceLabel = [NSString stringWithFormat:@"加价 %@ 万",price];
                        break;
                    case 3:
                        priceLabel = [NSString stringWithFormat:@"报价 %@ 万",price];
                        break;
                    default:
                        break;
                }
                [self setReplaceStringAt:indexPath withString:priceLabel];
            };
            priceViewController.guidePriceString = self.guidePrice;
        [self.navigationController pushViewController:priceViewController animated:YES];
            return;}}
    if ([selectTitle isEqualToString:WARTHOUSE_WGYS]) {     /** <外观颜色*/
            UCarBCatOutsideViewController *outSideColorViewController = [[UCarBCatOutsideViewController alloc] init];
            outSideColorViewController.goodsTemplateId = self.goodsTemplateId;
            outSideColorViewController.viewState = outSideColorState;
            outSideColorViewController.blockColor = ^(NSString *colorStr){  /**< 普通颜色传值*/
                [self setReplaceStringAt:indexPath withString:colorStr];
                self.dataModel.outsideColor = colorStr;
                self.dataModel.outsideColorDiy = nil;
            };
            [self.navigationController pushViewController:outSideColorViewController animated:YES];
                    return;}
    if ([selectTitle isEqualToString:WARTHOUSE_NSYS]) {     /**< 内饰颜色*/
            UCarBCatOutsideViewController *inSideColorViewController = [[UCarBCatOutsideViewController alloc] init];
            inSideColorViewController.goodsTemplateId = self.goodsTemplateId;
            inSideColorViewController.viewState = insideColorState;
            inSideColorViewController.blockColor = ^(NSString *colorStr){
                [self setReplaceStringAt:indexPath withString:colorStr];
                self.dataModel.insideColor = colorStr;
                self.dataModel.insideColorDiy = nil;
            };
            [self.navigationController pushViewController:inSideColorViewController animated:YES];
            return;}
    if ([selectTitle isEqualToString:WARTHOUSE_CYSZD]) {
        UCarBCarSourceLocationViewController *carSourceLocation  = [[UCarBCarSourceLocationViewController alloc] initWithNibName:NSStringFromClass([UCarBCarSourceLocationViewController class]) bundle:nil];
        carSourceLocation.title = WARTHOUSE_CYSZD;
        carSourceLocation.tipString = [NSString stringWithFormat:@"      为更好地销售车源, 建议填写车源所在地, 如 “东区” 或 “浙江” 或 “杭州” 或 “东疆库“ ."];
        carSourceLocation.placeString = [NSString stringWithFormat:@"请输入%@",WARTHOUSE_CYSZD];
        carSourceLocation.infoLabeltext = self.infoArray[indexPath.section][indexPath.row];
        carSourceLocation.locationPlace = ^(NSString *locationString){
            [self setReplaceStringAt:indexPath withString:locationString];
            self.dataModel.carPlace = locationString;
        };
        [self.navigationController pushViewController:carSourceLocation animated:YES];
    }
    if ([selectTitle isEqualToString:WARTHOUSE_XSQY]) {
        UCarBCarSellLocationViewController *sellLocation = [[UCarBCarSellLocationViewController alloc] init];
        sellLocation.salAreaBlock = ^(NSString *locationString){
            [self setReplaceStringAt:indexPath withString:locationString];
            self.dataModel.salesAreaDiy = nil;
            self.dataModel.salesArea = locationString;
        };
        [self.navigationController pushViewController:sellLocation animated:YES];
    }
    if ([selectTitle isEqualToString:WARTHOUSE_SX]) {
        UCarBDocumentViewController *sellDocument = [[UCarBDocumentViewController alloc] init];
        sellDocument.carSourceCategoryId = [NSString stringWithFormat:@"%@",self.carSourceCategoryId];
        sellDocument.documentListBlock = ^(NSString *name, NSNumber *value){
            [self setReplaceStringAt:indexPath withString:name];
            self.dataModel.proceduresDiy = nil;
            self.dataModel.procedures = value;
        };
        [self.navigationController pushViewController:sellDocument animated:YES];
    }
    if ([selectTitle isEqualToString:WARTHOUSE_PZ]) {
        UCarBCarConfigureViewController *configViewController = [[UCarBCarConfigureViewController alloc] init];
        configViewController.blkData = ^(NSString *name, NSMutableString *pageIDs, NSMutableString *nameids, NSString *configDiy){
            [self setReplaceStringAt:indexPath withString:name];
            self.dataModel.brightPoints = [nameids copy];
            self.dataModel.brightPointsPackageId = [pageIDs copy];
            self.dataModel.brightPointsDiy = configDiy;
        };
        configViewController.goodsTemplateId =  self.goodsTemplateId;
        if (self.pageTypeState == TypeStateSourceTypeOnlyCaupdNow || self.pageTypeState == TypeStateSourceTypeBothCaupdNow || self.pageTypeState == TypeStateSourceTypeOnlyCaupdFuture || self.pageTypeState == TypeStateSourceTypeBothCaupdFuture) {
            configViewController.goodsTemplateId = nil;
        }
        [self.navigationController pushViewController:configViewController animated:YES];
    }
    if ([selectTitle isEqualToString:WARTHOUSE_DDSJ]) {
        UCarBCarSourceLocationViewController *arriveStoreTime = [[UCarBCarSourceLocationViewController alloc] init];
        arriveStoreTime.title = WARTHOUSE_DDSJ;
        arriveStoreTime.tipString = @"      请输入到店时间, 年. 月. 日\n";
        arriveStoreTime.placeString= @"请输入到店时间";
        arriveStoreTime.infoLabeltext = self.infoArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:arriveStoreTime animated:YES];
    }
    if ([selectTitle isEqualToString:WARTHOUSE_DGSJ]) {
        UCarBCarSourceLocationViewController *arriveStoreTime = [[UCarBCarSourceLocationViewController alloc] init];
        arriveStoreTime.title = WARTHOUSE_DGSJ;
        arriveStoreTime.tipString = @"      请输入到港时间, 年. 月. 日\n";
        arriveStoreTime.placeString= @"请输入到港时间";
        arriveStoreTime.infoLabeltext = self.infoArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:arriveStoreTime animated:YES];
    }
    if ([selectTitle isEqualToString:WARTHOUSE_CJH]) {
        UCarBCarSourceLocationViewController *arriveStoreTime = [[UCarBCarSourceLocationViewController alloc] init];
        arriveStoreTime.title = WARTHOUSE_CJH;
        arriveStoreTime.tipString = @"      请输入车架号, 数字或者英文字母组成\n";
        arriveStoreTime.placeString= @"请输入车架号";
        arriveStoreTime.infoLabeltext = self.infoArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:arriveStoreTime animated:YES];
    }
    if ([selectTitle isEqualToString:WARTHOUSE_IMAGE]) {     // 图像
        UCarBChooseImageViewController *ChooseImageViewController = [[UCarBChooseImageViewController alloc] init];
        if (self.pageState == 1) {
            ChooseImageViewController.imageURLArray = [self.userURLImageArray mutableCopy];
            ChooseImageViewController.imageURL = self.modelData.imageURL;
            ChooseImageViewController.imageSMURL = self.modelData.imageSMURL;
            ChooseImageViewController.pageSize = self.pageState;
            ChooseImageViewController.imageBlock = ^(NSMutableArray *imageArray, NSMutableArray *nameArray){
                self.userURLImageArray = [nameArray mutableCopy];
                NSMutableString *tempString = [NSMutableString string];
                for (NSString *urlString in _userURLImageArray) {
                    [tempString appendString:[NSString stringWithFormat:@"%@,",urlString]];}
                if (tempString.length > 1) { [tempString substringToIndex:tempString.length -1];}
                self.dataModel.imgs = [NSString stringWithFormat:@"%@",tempString]; };}
        else {
            ChooseImageViewController.imageURLArray = [self.userURLImageArray copy];
            ChooseImageViewController.pageSize = 0;
            ChooseImageViewController.imageBlock = ^(NSMutableArray *imageArray, NSMutableArray *nameArray){
                self.userURLImageArray = [nameArray mutableCopy];
                NSMutableString *tempString = [NSMutableString string];
                for (NSString *urlString in _userURLImageArray) {
                    [tempString appendString:[NSString stringWithFormat:@"%@,",urlString]];}
                if (tempString.length > 1) {
                    [tempString substringToIndex:tempString.length -1];}
                self.dataModel.imgs = [NSString stringWithFormat:@"%@",tempString];};}
        [self.navigationController pushViewController:ChooseImageViewController animated:YES];}
}

//Footer
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_dataSource[1] count] == 0) {
        if (section == 0) { return 10; }
        else { return 5; }}
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero]; return nilView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{ return 0; }
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero]; return nilView; }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   if(indexPath.section == 2 && indexPath.row == 1) { return 100; }
    else { return 45; }
}


#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.message isEqualToString:@"重置车源将会删除已经选择的信息"] && buttonIndex == 0) {
        [self didSelectedGetCarSourceCategoryId]; }
    if ([alertView.message isEqualToString:@"重置车型将会删除已经选择的信息"] && buttonIndex == 0) {
        [self GetRowOneSectionZero]; }
}

#pragma mark SelectedRow0Section0
- (void)didSelectedGetCarSourceCategoryId
{
    NSString *tempString = self.infoArray[0][0];
    _infoArray = nil;
    [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:0] withString:tempString];
    UCarBCarSourceTypeViewController *sourceTypeViewController = [[UCarBCarSourceTypeViewController alloc] init];
    sourceTypeViewController.sourceTypeBlock = ^(UCarSendInfoModel_datalist *model){
        self.dataModel.carSourceCategoryId = model.carSourceCategoryId;
        self.dataModel.carSourceSpotsId = [NSString stringWithFormat:@"%@",model.carSourceSpotsId];
        [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:0] withString:[NSString stringWithFormat:@"%@-%@",model.name,model.spotsName]];
        [self.centerNotification postNotificationName:CENTERCARTYPE object:nil];
        switch ([model.carSourceSpotsId integerValue]) {
            case 1:
                self.pageTypeState = TypeStateSourceTypeOnlyChinaNow;
                break;
            case 2:
                self.pageTypeState = TypeStateSourceTypeOnlyCaupdNow;
                break;
            case 3:
                self.pageTypeState = TypeStateSourceTypeOnlyCaupdFuture;
                break;
            case 4:
                self.pageTypeState = TypeStateSourceTypeOnlyUSNow;
                break;
            case 5:
                self.pageTypeState = TypeStateSourceTypeOnlyUSFuture;
                break;
            default:
                if ([model.carSourceSpotsId integerValue] % 2 == 0) {
                    self.pageTypeState = TypeStateSourceTypeOnlyUSNow; }
                else { self.pageTypeState = TypeStateSourceTypeOnlyUSFuture; }
                break;
        }
        self.tempState = self.pageTypeState;
        [self updataTableView];
        self.carSourceCategoryId = model.carSourceCategoryId;
    };
    [self.navigationController pushViewController:sourceTypeViewController animated:YES];

}
- (void)GetRowOneSectionZero
{
    NSString *tempString1 = self.infoArray[0][1];
    NSString *tempString0 = self.infoArray[0][0];
    _infoArray = nil;
    [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:0] withString:tempString1];
    [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:0] withString:tempString0];
    self.moreInfoTextView.text = @"";
    self.showPriceText = @"";
    
    UCarBCarInfoTypeViewController *infoTypeViewController = [[UCarBCarInfoTypeViewController alloc] init];
    infoTypeViewController.carSourceCategoryId = self.carSourceCategoryId;
    if (self.carSourceCategoryId != nil) {
        [self.navigationController pushViewController:infoTypeViewController animated:YES];}
}

#pragma mark TextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{ self.showPriceText = textField.text; }

#pragma mark 发布
- (void)sendNewCar:(UIBarButtonItem *)button
{
#pragma mark 发布新车
    self.dataModel.remark = self.moreInfoTextView.text;
    self.dataModel.nameDiy = self.nameDiy;
    self.dataModel.goodsTemplateId = self.goodsTemplateId;
    self.dataModel.guidePrice = [NSNumber numberWithFloat:[self.guidePrice floatValue]];
    // 开始漫长的判断过程
    // 默认进入界面
    if (self.pageTypeState == TypeStateSourceNormal) {
        [self showHint:@"请首先选取车源类型"]; return;
    }
    if (self.pageTypeState % 2 == 1) {
        if ([self.infoArray[0][1] isEqualToString:@""]) {
            [self showHint:@"请选择对应车型"]; return; }
        if ([self.dataModel.guidePrice isEqualToNumber:@0]) {
            self.dataModel.guidePrice     = nil;
            self.dataModel.goodPrice      = [NSNumber numberWithInt:4];}
            self.dataModel.goodPriceCount = [NSNumber numberWithFloat:[self.showPriceText floatValue]];
        if ([self.showPriceText isEqualToString:@""] || self.showPriceText == nil) {
            [self showHint:@"请输入报价"]; return;}
        if ([self.infoArray[0][3] isEqualToString:@""]) {
            [self showHint:@"请输入外观颜色"]; return;}
        if ([self.infoArray[0][4] isEqualToString:@""]) {
            [self showHint:@"请输入内饰颜色"]; return;}
    }

    if (self.pageTypeState % 2 == 0) {
        if (self.pageTypeState == TypeStateSourceTypeBothUSNow || self.pageTypeState == TypeStateSourceTypeBothUSFuture) {
            if ([self.infoArray[0][1] isEqualToString:@""]) {
                [self showHint:@"请选择对应车型"]; return;}
            if ([self.dataModel.guidePrice isEqualToNumber:@0]) {
            self.dataModel.guidePrice     = nil;
            self.dataModel.goodPrice      = [NSNumber numberWithInt:4];}
            self.dataModel.goodPriceCount = [NSNumber numberWithFloat:[self.showPriceText floatValue]];
            if ([self.showPriceText isEqualToString:@""] || self.showPriceText == nil) {
                [self showHint:@"请输入报价"]; return;}
            if ([self.infoArray[0][3] isEqualToString:@""]) {
                [self showHint:@"请选择外观颜色"]; return; }
            if ([self.infoArray[0][4] isEqualToString:@""]) {
                [self showHint:@"选择内饰颜色"]; return;}}
        else {
            if ([self.infoArray[0][1] isEqualToString:@""]) {
                [self showHint:@"请选择对应车型"]; return; }
            if ([self.infoArray[0][3] isEqualToString:@""]) {
                [self showHint:@"请选择报价"]; return;}
            if ([self.infoArray[0][4] isEqualToString:@""]) {
                [self showHint:@"请选择外观颜色"]; return; }
            if ([self.infoArray[0][5] isEqualToString:@""]) {
                [self showHint:@"选择内饰颜色"]; return; } }
}
#pragma mark 重新发布
    self.modelData.remark = self.moreInfoTextView.text;
    self.modelData.nameDiy = self.nameDiy;
    self.modelData.goodsTemplateId = self.goodsTemplateId;
    self.modelData.guidePrice = [NSNumber numberWithFloat:[self.guidePrice floatValue]];
    self.modelData.arriveShopDate = self.dataModel.arriveShopDate;
    self.modelData.arrivePortDate = self.dataModel.arrivePortDate;
    self.modelData.brightPoints = self.dataModel.brightPoints;
    self.modelData.brightPointsDiy = self.dataModel.brightPointsDiy;
//    self.modelData.brightPointsId = self.dataModel.brightPoints;
    self.modelData.brightPointsPackageId = self.dataModel.brightPointsPackageId;
    self.modelData.carPlace = self.dataModel.carPlace;
    self.modelData.carSourceCategoryId = self.dataModel.carSourceCategoryId;
    self.modelData.frameNum = self.dataModel.frameNum;
    self.modelData.goodPrice = self.dataModel.goodPrice;
    self.modelData.goodPriceCount = self.dataModel.goodPriceCount;
    self.modelData.goodsTemplateId = self.dataModel.goodsTemplateId;
    self.modelData.guidePrice = self.dataModel.guidePrice;
    self.modelData.imgs = self.dataModel.imgs;
    self.modelData.insideColor = self.dataModel.insideColor;
    self.modelData.insideColorDiy = self.dataModel.insideColorDiy;
    self.modelData.name = self.infoArray[0][1];
    self.modelData.nameDiy = self.dataModel.nameDiy;
    self.modelData.outsideColor = self.dataModel.outsideColor;
    self.modelData.outsideColorDiy = self.dataModel.outsideColorDiy;
    self.modelData.procedures = self.dataModel.procedures;
    self.modelData.proceduresDiy = self.dataModel.proceduresDiy;
    self.modelData.remark = self.dataModel.remark;
    self.modelData.salesArea = self.dataModel.salesArea;
    self.modelData.salesAreaDiy = self.dataModel.salesAreaDiy;
//    self.modelData.price = self.dataModel.goodPriceCount; // 这个值传入多少 竟然显示就是多少
    if (self.pageState == 1) {
        NSDictionary *parms =  [self.modelData makeValueForKeys];
        PutWithHeaderAPI *api = [[PutWithHeaderAPI alloc] initWith:parms urlStr:B42CAREDITAGAIN header:@{@"Uid":[UserMangerDefaults UidGet]}];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSLog(@"%@ ++++ %@ ", request.responseBody[@"msg"], request.responseBody);
            NSNumber *string = request.responseBody[@"code"];
            if ([string integerValue] == 0) {
//                [self showHint:[NSString stringWithFormat:@"%@",request.responseBody[@"msg"]]];
                [self showHint:@"编辑保存成功"];
                [self.navigationController popToRootViewControllerAnimated:YES]; }
            else {
                [self showHint:[NSString stringWithFormat:@"%@",request.responseBody[@"msg"]]];};
        } failure:^(YTKBaseRequest *request) { NSLog(@"网络故障");}];}
    else {
    NSDictionary *parms =  [self.dataModel makeValueForKeys];
    PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:parms urlStr:B35CARPUBLISHINFO header:@{@"Uid":[UserMangerDefaults UidGet]}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSNumber *string = request.responseBody[@"code"];
        if ([string integerValue] == 0) {
//            [self showHint:[NSString stringWithFormat:@"%@",request.responseBody[@"msg"]]];
            [self showHint:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showHint:[NSString stringWithFormat:@"%@",request.responseBody[@"msg"]]];
        };
    } failure:^(YTKBaseRequest *request) { NSLog(@"网络故障"); }];}
}

- (void)configNetwork //编辑模式获取数据.
{
    [UCarHaveSendNetWork GETGoodsWithID:self.carID headerUid:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
        
        // 谁让后台啥值也穿, 还不传空, 坑爹啊, 哥只能一个一个返回值判断, 说好的批量呢.
        self.modelData = returnValue;
        self.carSourceCategoryId = self.modelData.carSourceCategoryId;
        self.guidePrice = [NSString stringWithFormat:@"%.2f",[self.modelData.guidePrice floatValue]];
        self.goodsTemplateId = self.modelData.goodsTemplateId;
        self.nameDiy = self.modelData.nameDiy;
        // 希望可以setValuesforKeys. 可是后台不能传nil,只能是标注的空
        self.dataModel.arriveShopDate = self.modelData.arriveShopDate;
        self.dataModel.arrivePortDate = self.modelData.arrivePortDate;
        self.dataModel.brightPoints = self.modelData.brightPointsId;
        self.dataModel.brightPointsDiy = self.modelData.brightPointsDiy;
        self.dataModel.brightPointsPackageId = self.modelData.brightPointsPackageId;
        self.dataModel.carPlace = self.modelData.carPlace;
        self.dataModel.carSourceCategoryId = self.modelData.carSourceCategoryId;
        self.dataModel.frameNum = self.modelData.frameNum;
        self.dataModel.goodPrice = self.modelData.goodPrice;
        self.dataModel.goodPriceCount = self.modelData.goodPriceCount;
        self.dataModel.goodsTemplateId = self.modelData.goodsTemplateId;
        self.dataModel.guidePrice = self.modelData.guidePrice;
        self.dataModel.imgs = self.modelData.imgs;
        self.dataModel.insideColor = self.modelData.insideColor;
        self.dataModel.insideColorDiy = self.modelData.insideColorDiy;
        self.dataModel.nameDiy = self.modelData.nameDiy;
        self.dataModel.outsideColor = self.modelData.outsideColor;
        self.dataModel.outsideColorDiy = self.modelData.outsideColorDiy;
        self.dataModel.procedures = self.modelData.procedures;
        self.dataModel.proceduresDiy = self.modelData.proceduresDiy;
        self.dataModel.remark = self.modelData.remark;
        self.dataModel.salesArea = self.modelData.salesArea;
        self.dataModel.salesAreaDiy = self.modelData.salesAreaDiy;
        NSString *changeString = [NSString stringWithFormat:@"%@%@",self.modelData.sourceName, self.modelData.spotsName];
        if ([changeString isEqualToString:@"国产现车"]) {
            if ([self.modelData.nameDiy isEqualToString:@""]) {
                self.pageTypeState = TypeStateSourceTypeBothChinaNow;
            } else {
                self.pageTypeState = TypeStateSourceTypeOnlyChinaNow;
            }
        } else if ([changeString isEqualToString:@"中规现车"]) {
            if ([self.modelData.nameDiy isEqualToString:@""]) {
                self.pageTypeState = TypeStateSourceTypeBothCaupdNow;
            } else {
                self.pageTypeState = TypeStateSourceTypeOnlyCaupdNow;
            }
        } else if ([changeString isEqualToString:@"中规期货"]) {
            if ([self.modelData.nameDiy isEqualToString:@""]) {
                self.pageTypeState = TypeStateSourceTypeBothCaupdFuture;
            } else {
                self.pageTypeState = TypeStateSourceTypeOnlyCaupdFuture;
            }
        } else if ([changeString isEqualToString:@"美规现车"]) {
            if ([self.modelData.nameDiy isEqualToString:@""]) {
                self.pageTypeState = TypeStateSourceTypeBothUSNow;
            } else {
                self.pageTypeState = TypeStateSourceTypeOnlyUSNow;
            }
        } else if ([changeString isEqualToString:@"美规期货"]) {
            if ([self.modelData.nameDiy isEqualToString:@""]) {
                self.pageTypeState = TypeStateSourceTypeBothUSFuture;
            } else {
                self.pageTypeState = TypeStateSourceTypeOnlyUSFuture;
            }
        } else {
            if ([self.modelData.spotsName isEqualToString:@"现车"]) {
                if ([self.modelData.nameDiy isEqualToString:@""]) {
                    self.pageTypeState = TypeStateSourceTypeBothUSNow;
                } else {
                    self.pageTypeState = TypeStateSourceTypeOnlyUSNow;
                }
            } else {
                if ([self.modelData.nameDiy isEqualToString:@""]) {
                    self.pageTypeState = TypeStateSourceTypeBothUSFuture;
                } else {
                    self.pageTypeState = TypeStateSourceTypeOnlyUSFuture;
                }
            }
        }
        [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:0] withString:changeString];
        if ([self.modelData.nameDiy isEqualToString:@""]) {
            [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:0] withString:self.modelData.name];
        } else {
            [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:0] withString:self.modelData.nameDiy];
        }
        // remark
        self.moreInfoTextView.text = self.modelData.remark ;
        NSString *priceString;
        switch ([self.modelData.goodPrice integerValue]) {
            case 1:
                priceString = [NSString stringWithFormat:@"优惠 %@ 点",self.modelData.goodPriceCount];
                break;
                
            case 2:
                priceString = [NSString stringWithFormat:@"优惠 %@ 万",self.modelData.goodPriceCount];
                break;
            case 3:
                priceString = [NSString stringWithFormat:@"加价 %@ 万",self.modelData.goodPriceCount];
                break;
            case 4:
                priceString = [NSString stringWithFormat:@"报价 %@ 万",self.modelData.goodPriceCount];
                break;
            default:
                break;
        }
        
        switch (self.pageTypeState) {
            case TypeStateSourceTypeOnlyChinaNow:
                self.showPriceText = [NSString stringWithFormat:@"%@",self.modelData.price];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                // Section 1
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:self.modelData.carPlace];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:[self.modelData.salesArea isEqualToString:@""]? self.modelData.salesAreaDiy : self.modelData.salesArea];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:[self.modelData.procedures isEqualToNumber:@0] ? self.modelData.proceduresDiy : self.modelData.proceduresName];
                break;
                
            case TypeStateSourceTypeBothChinaNow:
                self.guidePrice = [NSString stringWithFormat:@"%@",self.modelData.guidePrice];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:priceString];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:5 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                // Section1
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:self.modelData.carPlace];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:[self.modelData.salesArea isEqualToString:@""]? self.modelData.salesAreaDiy : self.modelData.salesArea];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:[self.modelData.procedures isEqualToNumber:@0] ? self.modelData.proceduresDiy : self.modelData.proceduresName];
                break;
                
            case TypeStateSourceTypeOnlyCaupdNow:
                self.showPriceText = [NSString stringWithFormat:@"%@",self.modelData.price];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                // Section1
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:[self.modelData.salesArea isEqualToString:@""]? self.modelData.salesAreaDiy : self.modelData.salesArea];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:self.modelData.brightPointsDiy];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:[self.modelData.procedures isEqualToNumber:@0] ? self.modelData.proceduresDiy : self.modelData.proceduresName];
                break;
                
            case TypeStateSourceTypeBothCaupdNow:
                self.guidePrice = [NSString stringWithFormat:@"%@",self.modelData.guidePrice];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:priceString];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:5 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                // Section1
                // 销售区域
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:[self.modelData.salesArea isEqualToString:@""]? self.modelData.salesAreaDiy : self.modelData.salesArea];
                // 配置自定义
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:self.modelData.brightPointsDiy];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:[self.modelData.procedures isEqualToNumber:@0] ? self.modelData.proceduresDiy : self.modelData.proceduresName];
                break;
                
            case TypeStateSourceTypeOnlyCaupdFuture:
                self.showPriceText = [NSString stringWithFormat:@"%@",self.modelData.price];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                // Section1
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:self.modelData.carPlace];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:[self.modelData.salesArea isEqualToString:@""]? self.modelData.salesAreaDiy : self.modelData.salesArea];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:self.modelData.brightPointsDiy];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:1] withString:self.modelData.arriveShopDate];
                break;
                
            case TypeStateSourceTypeBothCaupdFuture:
                self.guidePrice = [NSString stringWithFormat:@"%@",self.modelData.guidePrice];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:priceString];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:5 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                // Section1
                // 车源所在地
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:[self.modelData.salesArea isEqualToString:@""]? self.modelData.salesAreaDiy : self.modelData.salesArea];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:self.modelData.brightPointsDiy];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:self.modelData.arriveShopDate];
                break;
                
            case TypeStateSourceTypeOnlyUSNow:
                self.showPriceText = [NSString stringWithFormat:@"%@",self.modelData.price];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                
                // Section1
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:self.modelData.carPlace];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:self.modelData.frameNum];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:self.modelData.brightPointsDiy];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:1] withString:[self.modelData.procedures isEqualToNumber:@0] ? self.modelData.proceduresDiy : self.modelData.proceduresName];
                break;
                
            case TypeStateSourceTypeBothUSNow:
                self.showPriceText = [NSString stringWithFormat:@"%@",self.modelData.price];
                if ([self.modelData.outsideColor isEqualToString:@""]) {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:self.modelData.outsideColorDiy];
                } else {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:self.modelData.outsideColor];
                }
                
                if ([self.modelData.insideColor isEqualToString:@""]) {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:self.modelData.insideColorDiy];
                } else {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:self.modelData.insideColor];
                }
                // Section1
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:self.modelData.carPlace];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:self.modelData.frameNum];
                if ([self.modelData.brightPointsPackage isEqualToString:@""] || [self.modelData.brightPoints isEqualToString:@""] || [self.modelData.brightPointsDiy isEqualToString:@""]) {
                    NSString *dotOne = @",";
                    NSString *dotTwo = @",";
                    if ([self.modelData.brightPointsPackage isEqualToString:@""]) {
                        dotOne = @"";
                    }
                    if ([self.modelData.brightPoints isEqualToString:@""] || [self.modelData.brightPointsDiy isEqualToString:@""]) {
                        dotTwo = @"";
                    }
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:[NSString stringWithFormat:@"%@%@%@%@%@",self.modelData.brightPointsPackage,dotOne,self.modelData.brightPoints,dotTwo,self.modelData.brightPointsDiy]];
                } else {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:[NSString stringWithFormat:@"%@,%@,%@",self.modelData.brightPointsPackage,self.modelData.brightPoints,self.modelData.brightPointsDiy]];
                }
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:1] withString:[self.modelData.procedures isEqualToNumber:@0] ? self.modelData.proceduresDiy : self.modelData.proceduresName];
                break;
                
            case TypeStateSourceTypeOnlyUSFuture:
                self.showPriceText = [NSString stringWithFormat:@"%@",self.modelData.price];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:[self.modelData.outsideColor isEqualToString:@""] ? self.modelData.outsideColorDiy : self.modelData.outsideColor];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:[self.modelData.insideColor isEqualToString:@""] ? self.modelData.insideColorDiy : self.modelData.insideColor];
                // Section 1
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:self.modelData.frameNum];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:self.modelData.brightPointsDiy];
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:self.modelData.arrivePortDate];
                break;
                
            case TypeStateSourceTypeBothUSFuture:
                self.showPriceText = [NSString stringWithFormat:@"%@",self.modelData.price];
                if ([self.modelData.outsideColor isEqualToString:@""]) {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:self.modelData.outsideColorDiy];
                } else {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:3 inSection:0] withString:self.modelData.outsideColor];
                }
                if ([self.modelData.insideColor isEqualToString:@""]) {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:self.modelData.insideColorDiy];
                } else {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:4 inSection:0] withString:self.modelData.insideColor];
                }
                // Section
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:0 inSection:1] withString:self.modelData.frameNum];
                if ([self.modelData.brightPointsPackage isEqualToString:@""] || [self.modelData.brightPoints isEqualToString:@""] || [self.modelData.brightPointsDiy isEqualToString:@""]) {
                    NSString *dotOne = @",";
                    NSString *dotTwo = @",";
                    if ([self.modelData.brightPointsPackage isEqualToString:@""]) {
                        dotOne = @"";
                    }
                    if ([self.modelData.brightPoints isEqualToString:@""] || [self.modelData.brightPointsDiy isEqualToString:@""]) {
                        dotTwo = @"";
                    }
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:[NSString stringWithFormat:@"%@%@%@%@%@",self.modelData.brightPointsPackage,dotOne,self.modelData.brightPoints,dotTwo,self.modelData.brightPointsDiy]];
                } else {
                    [self setReplaceStringAt:[NSIndexPath indexPathForRow:1 inSection:1] withString:[NSString stringWithFormat:@"%@,%@,%@",self.modelData.brightPointsPackage,self.modelData.brightPoints,self.modelData.brightPointsDiy]];
                }
                [self setReplaceStringAt:[NSIndexPath indexPathForRow:2 inSection:1] withString:self.modelData.arrivePortDate];
                break;
            default:
                break;
        }
        /**< 计算相册图片数量 , 防止未推出情况 多次进入相册导致重复 放于此处处理*/
        NSArray *urlArray = [self.modelData.imgs componentsSeparatedByString:@","];
        self.userURLImageArray = [self.userURLImageArray mutableCopy];
        [self.userURLImageArray addObjectsFromArray:urlArray];
        for (NSInteger i = 0; i < self.userURLImageArray.count; i++) {
            NSString *tempString = [self.userURLImageArray objectAtIndex:i];
            if ([tempString isEqualToString:@""]) {
                [self.userURLImageArray removeObjectAtIndex:i];
            }
        }
        [self updataTableView];
    } failureBlk:^(id error) {
        
    }];
}

#pragma mark Setter Getter
- (NSArray *)allArray
{
    if (_allArray == nil) {
        // 这么写纯粹因为我对逻辑不了解, 这样看着清楚点, 此处可优化.
        NSArray *normal             = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],@[],
                                      @[@"图像",@"备注"]];
        NSArray *arrOnlyChinaNow    = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车源所在地",@"销售区域",@"手续"],
                                      @[@"图像",@"备注"]];
        NSArray *arrBothChinaNow    = @[@[@"车源类型",@"对应车型",@"厂商指导价",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车源所在地",@"销售区域",@"手续"],
                                      @[@"图像",@"备注"]];
        NSArray *arrOnlyCaupdFuture = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车源所在地",@"销售区域",@"配置",@"手续"],
                                      @[@"图像",@"备注"]];
        NSArray *arrBothCaupdFuture = @[@[@"车源类型",@"对应车型",@"厂商指导价",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车源所在地",@"销售区域",@"配置",@"手续"],
                                      @[@"图像",@"备注"]];
        NSArray *arrOnlyCaupdNow    = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"销售区域",@"配置",@"到店时间"],
                                      @[@"图像",@"备注"]];
        NSArray *arrBothCaupdNow    = @[@[@"车源类型",@"对应车型",@"厂商指导价",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"销售区域",@"配置",@"到店时间"],
                                      @[@"图像",@"备注"]];
        NSArray *arrOnlyUSNow       = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车源所在地",@"车架号",@"配置",@"手续"],
                                      @[@"图像",@"备注"]];
        NSArray *arrBothUSNow       = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车源所在地",@"车架号",@"配置",@"手续"],
                                      @[@"图像",@"备注"]];
        NSArray *arrOnlyUSFuture    = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车架号",@"配置",@"到港时间"],
                                      @[@"图像",@"备注"]];
        NSArray *arrBothUSFuture    = @[@[@"车源类型",@"对应车型",@"报价",@"外观颜色",@"内饰颜色"],
                                      @[@"车架号",@"配置",@"到港时间"],
                                      @[@"图像",@"备注"]];
        NSArray *allTempArray = @[normal,arrOnlyChinaNow, arrBothChinaNow,arrOnlyCaupdFuture,arrBothCaupdFuture,arrOnlyCaupdNow,arrBothCaupdNow,arrOnlyUSNow, arrBothUSNow, arrOnlyUSFuture, arrBothUSFuture];
        _allArray = allTempArray; }
    return _allArray;
}


- (NSMutableArray *)infoArray
{
    if (_infoArray == nil) {
        NSMutableArray *nsMutableSectionOneArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
        NSMutableArray *nsMutableSectionTwoArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
        NSMutableArray *nsMutableSectionThreeArr = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
        NSMutableArray *tempMutebleArray = [NSMutableArray arrayWithObjects:nsMutableSectionOneArr, nsMutableSectionTwoArr, nsMutableSectionThreeArr, nil];
        _infoArray = tempMutebleArray;}
    return _infoArray;
}

- (NSString *)showPriceText
{
    if (_showPriceText == nil) {
        NSString *tempStr = [NSString string];
        _showPriceText = tempStr; }
    return _showPriceText;
}

// 替换数组中某个元素方法
- (void)setReplaceStringAt:(NSIndexPath *)indexPath withString:(NSString *)string{
    NSMutableArray *tempSectionArray = [self.infoArray objectAtIndex:indexPath.section];
    [tempSectionArray replaceObjectAtIndex:indexPath.row withObject:string];
    [self.infoArray replaceObjectAtIndex:indexPath.section withObject:tempSectionArray];
    [self.tableViewUCarStock reloadData];}

- (UITableView *)tableViewUCarStock{
    if (_tableViewUCarStock == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBOrderTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseOrderCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBInputTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseInputCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBTextFieldTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseInPutTextField];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBOrderTypePriceTableViewCell class]) bundle:nil] forCellReuseIdentifier:reusePriceLabel];
        _tableViewUCarStock = tempTableView;}
    return _tableViewUCarStock;
}
- (UCarBCarFormateDateUpdateModel *)dataModel{
    if (_dataModel == nil) {
        UCarBCarFormateDateUpdateModel *tempModel = [[UCarBCarFormateDateUpdateModel alloc] init];
        _dataModel = tempModel;}
    return _dataModel;
}
- (UCarBHaveSendModelDetail_data *)modelData
{
    if (_modelData == nil) {
        UCarBHaveSendModelDetail_data *tempData = [[UCarBHaveSendModelDetail_data alloc] init];
        _modelData = tempData;}
    return _modelData;
}
- (NSNumber *)carSourceCategoryId
{
    if (_carSourceCategoryId == nil) {
        NSNumber *tempnumber = @0;
        _carSourceCategoryId = tempnumber;}
    return _carSourceCategoryId;
}
- (NSMutableArray *)userURLImageArray
{
    if (_userURLImageArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _userURLImageArray = tempArray;}
    return _userURLImageArray;
}
- (void)dealloc{ [_centerNotification removeObserver:self];    /**< 移除通知中心*/  }
- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning];}

/**
 *  恭喜, 你读完了.
 */

@end
