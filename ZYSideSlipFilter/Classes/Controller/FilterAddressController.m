//
//  FilterAddressController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/19.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "FilterAddressController.h"
#import "UIColor+hexColor.h"
#import "AddressTableViewCell.h"
#import "AddressModel.h"

@interface FilterAddressController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) AddressTableViewCell *templateCell;
@property (copy, nonatomic) NSString *selectedAddressId;
@end

@implementation FilterAddressController
- (instancetype)initWithDataList:(NSArray *)dataList selectedAddressId:(NSString *)selectedAddressId {
    self = [super init];
    if (self) {
        _dataList = dataList;
        _selectedAddressId = selectedAddressId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationItem];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"配送地址";
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self goBack];
}

- (void)goBack {
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DataSource Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressTableViewCell cellReuseIdentifier]];
    if (!cell) {
        cell = [AddressTableViewCell createCell];
    }
    AddressModel *model = [_dataList objectAtIndex:indexPath.row];
    [cell updateCellWithAddressModel:model isSelected:[_selectedAddressId isEqualToString:model.addressId]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressModel *model = [_dataList objectAtIndex:indexPath.row];
    [self.templateCell updateCellWithAddressModel:model isSelected:[_selectedAddressId isEqualToString:model.addressId]];
    //calculate
    NSLayoutConstraint *calculateCellConstraint = [NSLayoutConstraint constraintWithItem:_templateCell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:self.view.bounds.size.width];
    [_templateCell.contentView addConstraint:calculateCellConstraint];
    CGSize cellSize = [_templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [_templateCell.contentView removeConstraint:calculateCellConstraint];
    return cellSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate addressControllerDidSelectedAddress:[_dataList objectAtIndex:indexPath.row]];
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AddressTableViewCell *)templateCell {
    if (!_templateCell) {
        _templateCell = [AddressTableViewCell createCell];
    }
    return _templateCell;
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
