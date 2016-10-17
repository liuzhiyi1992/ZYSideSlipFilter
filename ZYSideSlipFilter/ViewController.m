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
#import "CommonItemModel.h"

@interface ViewController ()
@property (strong, nonatomic) ZYSideSlipFilterController *filterController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterController = [[ZYSideSlipFilterController alloc] initWithSponsor:self commitBlock:^(NSArray *dataList) {
        NSLog(@"commit");
    }];
    _filterController.animationDuration = .3f;
    _filterController.dataList = [self packageDataList];
}

- (IBAction)clickFilterButton:(id)sender {
//    [ZYSideSlipFilterController showSideSlipFilterWithSponsor:self commitBlock:^(NSDictionary *commitDict) {
//        NSLog(@"");
//    }];
    [_filterController show];
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
    [self createItemModelWithTitle:@"first" itemId:@"0000" selected:NO];
    model.dataDict = @{@"title":keywork,
                       @"content":@[[self createItemModelWithTitle:@"first" itemId:@"0000" selected:NO],
                                    [self createItemModelWithTitle:@"second" itemId:@"0001" selected:NO],
                                    [self createItemModelWithTitle:@"third" itemId:@"0002" selected:NO],
                                    [self createItemModelWithTitle:@"fourth" itemId:@"0003" selected:NO],
                                    [self createItemModelWithTitle:@"fifth" itemId:@"0004" selected:NO],
                                    [self createItemModelWithTitle:@"sixth" itemId:@"0005" selected:NO],
                                    [self createItemModelWithTitle:@"seventh" itemId:@"0006" selected:NO],
                                    [self createItemModelWithTitle:@"eighth" itemId:@"0007" selected:NO],
                                    [self createItemModelWithTitle:@"ninth" itemId:@"0008" selected:NO],
                                    [self createItemModelWithTitle:@"tenth" itemId:@"0009" selected:NO]
                                    ]};
    return model;
}

- (CommonItemModel *)createItemModelWithTitle:(NSString *)itemTitle
                                       itemId:(NSString *)itemId
                                     selected:(BOOL)selected {
    CommonItemModel *model = [[CommonItemModel alloc] init];
    model.itemId = itemId;
    model.itemName = itemTitle;
    model.selected = selected;
    return model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
