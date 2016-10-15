//
//  ViewController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ViewController.h"
#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterItemModel.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clickFilterButton:(id)sender {
//    [ZYSideSlipFilterController showSideSlipFilterWithSponsor:self commitBlock:^(NSDictionary *commitDict) {
//        NSLog(@"");
//    }];
    ZYSideSlipFilterController *filterController =[[ZYSideSlipFilterController alloc] initWithSponsor:self commitBlock:^(NSDictionary *commitDict) {
        NSLog(@"");
    }];
    filterController.animationDuration = .3f;
    filterController.dataList = [self packageDataList];
    [filterController show];
}

#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self commonFilterItemModelWithKeywork:@"品牌"]];
    [dataArray addObject:[self commonFilterItemModelWithKeywork:@"种类"]];
    [dataArray addObject:[self commonFilterItemModelWithKeywork:@"特性"]];
    [dataArray addObject:[self commonFilterItemModelWithKeywork:@"适用场景"]];
    return dataArray;
}

- (ZYSideSlipFilterItemModel *)commonFilterItemModelWithKeywork:(NSString *)keywork {
    ZYSideSlipFilterItemModel *model = [[ZYSideSlipFilterItemModel alloc] init];
    model.containerCellClass = @"SideSlipCommonTableViewCell";
    model.dataDict = @{@"title":keywork, @"content":@[@{@"itemTitle":@"first", @"itemId":@"0000"},
                                                         @{@"itemTitle":@"second", @"itemId":@"0001"},
                                                         @{@"itemTitle":@"third", @"itemId":@"0002"},
                                                         @{@"itemTitle":@"fourth", @"itemId":@"0003"},
                                                         @{@"itemTitle":@"fifth", @"itemId":@"0004"},
                                                         @{@"itemTitle":@"sixth", @"itemId":@"0005"},
                                                         @{@"itemTitle":@"seventh", @"itemId":@"0006"}]};
    return model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
