//
//  PosterViewController.m
//  Hancheng
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PosterViewController.h"
#import "ReactiveCocoa.h"
@interface PosterViewController ()
@property (weak, nonatomic) IBOutlet YYTextView *inputView;
@property (nonatomic, strong)NSString *contentStr;
@end

@implementation PosterViewController

SettingBottomBar

- (void)initTextView
{
   
    self.inputView.placeholderText = @"您对U车库的任何意见和疑惑都可以告诉我们，客服会在第一时间内给你回复!";
    self.inputView.placeholderTextColor = [UIColor colorWithHexString:@"C5C4C5"];
    self.inputView.textContainerInset = UIEdgeInsetsMake(35*REM, 22*REM, 35*REM, 22*REM);
    @weakify(self);
    [RACObserve(self.inputView, text)subscribeNext:^(NSString *text) {
        @strongify(self);
        text.length > 0 ? (self.contentStr = text) : nil ;
    }];

}

- (void)initNaivButton
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitAction:)];


}

- (void)submitAction:(UIBarButtonItem *)item
{
    [self.inputView resignFirstResponder];
  
    if (self.contentStr.length == 0 || self.contentStr == nil) {
       
        [self showHint:@"请填写内容" yOffset:-400*REM];
        
    }
    if (self.contentStr.length > 0) {
        WS(myself);
        PostWithHeaderAPI *API = [[PostWithHeaderAPI alloc] initWith:@{@"content":self.contentStr} urlStr:@"/api/ucarMy/addVomitSlot" header:@{@"Uid":[UserMangerDefaults UidGet]}];
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            [myself showHint:request.responseBody[@"msg"] yOffset:-400*REM];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [myself.navigationController popToRootViewControllerAnimated:YES];
            });
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"错误");
        }];
    }
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    // Do any additional setup after loading the view from its nib.
    [self initTextView];
    [self initNaivButton];
   self.title = @"吐槽U车库";
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
