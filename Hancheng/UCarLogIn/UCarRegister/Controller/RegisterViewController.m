//
//  RegisterViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterSetpTwoViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonCarSourceCenterY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonDealersCenterY;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthSourceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCarSourceWidh;

@property (weak, nonatomic) IBOutlet UILabel *imCarBussiness;
@property (weak, nonatomic) IBOutlet UILabel *imCarSource;




@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"注册1/3";
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
    
        self.imCarBussiness.layer.cornerRadius = self.imCarSource.layer.cornerRadius = 18;
        self.imCarSource.backgroundColor = self.imCarBussiness.backgroundColor = HEXCOLOR(0xff5000);
        self.imCarBussiness.layer.masksToBounds = self.imCarSource.layer.masksToBounds = YES;
        
    if (SCREENWIDTH == 320) {
        self.buttonCarSourceCenterY.constant = -80;
        self.buttonDealersCenterY .constant = 80;
        self.widthCarSourceWidh.constant = self.widthSourceHeight.constant = 100;
    }

    if (SCREENWIDTH > 375) {
        self.buttonCarSourceCenterY.constant = -135;
        self.buttonDealersCenterY .constant = 135;
        self.widthCarSourceWidh.constant = self.widthSourceHeight.constant = 145;
    }
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

#pragma mark 经销商
- (IBAction)buttonDealersAction:(id)sender {
    RegisterSetpTwoViewController *secondStep = [[RegisterSetpTwoViewController alloc] initWithNibName:NSStringFromClass([RegisterSetpTwoViewController class]) bundle:nil];
    secondStep.userIdentity = userIdentitySellOwer;
    [self.navigationController pushViewController:secondStep animated:YES];
}

#pragma mark 车源商
- (IBAction)buttonCarSourceAction:(id)sender {
    RegisterSetpTwoViewController *secondStep = [[RegisterSetpTwoViewController alloc] initWithNibName:NSStringFromClass([RegisterSetpTwoViewController class]) bundle:nil];
    secondStep.userIdentity = userIdentityCarSource;
    [self.navigationController pushViewController:secondStep animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
