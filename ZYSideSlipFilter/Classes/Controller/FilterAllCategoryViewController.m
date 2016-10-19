//
//  FilterAllCategoryViewController.m
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/18.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "FilterAllCategoryViewController.h"
#import "UIColor+hexColor.h"

@interface FilterAllCategoryViewController ()

@end

@implementation FilterAllCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationItem];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"全部分类";
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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
