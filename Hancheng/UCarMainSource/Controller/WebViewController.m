//
//  WebViewController.m
//  Hancheng
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    NSString *htmlStr;
}
@property (nonatomic, strong) UIWebView *webView;

@end



@implementation WebViewController

SettingBottomBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    if (self.identify.length == 0) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
         self.title = self.titleName;
        [self.webView loadRequest:req];
    } else {

       
    
       NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"about.html" withExtension:nil];
       htmlStr = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
 
        self.title = @"汉乘U车库用户服务使用协议";
       [self.webView loadHTMLString:htmlStr baseURL:nil];
       
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
