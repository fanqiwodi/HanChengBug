//
//  UCarBCarColorDIYViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarColorDIYViewController.h"
#import "UCarSendInforViewController.h"


@interface UCarBCarColorDIYViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (nonatomic, strong)UIView *whiteBackView;
@end

@implementation UCarBCarColorDIYViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    self.title = self.viewState == 1 || self.viewState == 0 ? @"自定义颜色" : @"昵称";
    if (self.viewState == 1) self.title = @"自定义内饰颜色";
    if (self.viewState == 0) self.title = @"自定义外观颜色";
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat height = 86;
    if (self.viewState != 1 && self.viewState != 0) {
        height = 41;
    }
    self.inputHeight.constant = height;
    self.whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, height)];
    _whiteBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_whiteBackView];
    
    [self.whiteBackView addSubview:self.inPutTextField];
    [self configLayout];
    
    if (self.viewState == 2) {
        self.inPutTextField.placeholder = @"请输入昵称";
    }
    
    if (self.inputName.length > 0) {
        self.inPutTextField.text = self.inputName;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveColor:)];
    
}

// 保存后存入字典 通知传值  Color 判定Inside/Outside颜色 Text为内容
- (void)saveColor:(UIBarButtonItem *)button
{
    if (self.viewState == 0 || self.viewState == 1) {
        NSDictionary *objcDic = @{@"Color":[NSString stringWithFormat:@"%ld",(long)self.viewState], @"Text":self.inPutTextField.text};
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:CENTERCARCOLOR object:objcDic];
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    } else {
        // 保存姓名
        self.inputText = self.inPutTextField.text;
        if (self.inputText.length != 0) {
            PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"nickName":self.inputText} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
            WS(myself);
            [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                [myself showHint:request.responseBody[@"msg"] yOffset:-400*REM];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [myself.navigationController popViewControllerAnimated:YES];
                });
            } failure:^(YTKBaseRequest *request) {
                NSLog(@"错误");
            }];
        }
      
    }
}

#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf);
    
    [weakSelf.inPutTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.whiteBackView).offset(12);
        make.bottom.equalTo(weakSelf.whiteBackView).offset(-12);
        make.left.equalTo(weakSelf.whiteBackView).offset(12);
        make.right.equalTo(weakSelf.whiteBackView).offset(-12);
    }];
}

- (UITextField *)inPutTextField
{
    if (_inPutTextField == nil) {
        UITextField *tempTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        tempTextField.placeholder = self.viewState == 0 || self.viewState == 1 ? @"请输入自定义的颜色( 最多15个字 )" : @"请输入姓名";
        tempTextField.font = [UIFont systemFontOfSize:14];
        tempTextField.textColor = HEXCOLOR(0x333333);
        tempTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        tempTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _inPutTextField = tempTextField;
    }
    return _inPutTextField;
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
