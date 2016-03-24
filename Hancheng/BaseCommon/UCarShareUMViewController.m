//
//  UCarShareUMViewController.m
//  Hancheng
//
//  Created by Tony on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarShareUMViewController.h"
#import "UMSocial.h"
#import "UMSocialDataService.h"
#import "UMSocialWechatHandler.h"
@interface UCarShareUMViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIControl *backView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation UCarShareUMViewController
{
    NSString *_titleString;
    UIImageView *_shareImageView;
    NSString *_HtmlURL;
    NSString *_messageString;
    
    NSInteger pageState;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.cancelButton.layer.borderWidth = 1;
    self.cancelButton.layer.borderColor = HEXCOLOR(0x999999).CGColor;
    self.cancelButton.layer.cornerRadius  = 20;
    self.cancelButton.layer.masksToBounds = YES;
}

- (void)initwithTitle:(NSString *)title image:(UIImageView *)imageView htmlURL:(NSString *)url messageString:(NSString *)messageString
{
    _titleString = title;
    _shareImageView = imageView;
    _HtmlURL = url;
    _messageString = messageString;
    pageState = 0;
}
- (void)pageState:(NSInteger)pageText
{
    pageState = 1;
}

- (IBAction)cancelButtonAction:(id)sender {
    [UIView animateWithDuration:0.1 animations:^{
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
    [self dismissViewControllerAnimated:YES completion:nil];
    }];

}

#pragma mark 微信好友分享
- (IBAction)shareWeChat:(id)sender {
    WS(weakSelf);
    weakSelf.backView.alpha = 0;
    [UMSocialWechatHandler setWXAppId:@"wx70c895eb6780230c" appSecret:@"9a663a066f0fdd7712f897fd5e214f35" url:_HtmlURL];
    
    if (pageState == 1) {
      [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:_messageString image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！"); 
            }
        }];
    } else {
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.title = @"U车库";
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:_titleString image:_shareImageView.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            
        }
    }];
    }
    
}
- (IBAction)shareWechatFrend:(id)sender {
    WS(weakSelf);
    weakSelf.backView.alpha = 0;
    [UMSocialWechatHandler setWXAppId:@"wx70c895eb6780230c" appSecret:@"9a663a066f0fdd7712f897fd5e214f35" url:_HtmlURL];
    if (pageState == 1) {
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:_messageString image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];

    } else {
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    
    [UMSocialData defaultData].extConfig.title = _titleString;
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:_titleString image:_shareImageView.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    }
}
- (IBAction)shareMessage:(id)sender {
    WS(weakSelf);
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSms] content:_messageString image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            weakSelf.backView.alpha = 0;
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } else {
            weakSelf.backView.alpha = 0;
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [UIView animateWithDuration:0.1 animations:^{
        self.backView.alpha = 0.4;
        self.backView.backgroundColor = [UIColor blackColor];
    }];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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
