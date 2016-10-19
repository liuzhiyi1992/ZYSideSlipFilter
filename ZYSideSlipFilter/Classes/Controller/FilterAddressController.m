//
//  FilterAddressController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/19.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "FilterAddressController.h"
#import "UIColor+hexColor.h"

@interface FilterAddressController ()

@end

@implementation FilterAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationItem];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"配送地址";
}

- (void)configureNavigationItem {
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(30, 0, 50, 50)];
    [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButtonItem setTintColor:[UIColor hexColor:@"AAAAAA"]];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)clickBackButton:(id)sender {
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
