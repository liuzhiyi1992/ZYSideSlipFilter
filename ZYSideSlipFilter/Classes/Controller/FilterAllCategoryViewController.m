//
//  FilterAllCategoryViewController.m
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/18.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "FilterAllCategoryViewController.h"
#import "UIColor+hexColor.h"

#define IOS_VERSION_10_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)? (YES):(NO))

@interface FilterAllCategoryViewController ()
@end

@implementation FilterAllCategoryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationItem];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"全部分类";
}

- (void)configureNavigationItem {
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(30, 0, 40, 40)];
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
@end
