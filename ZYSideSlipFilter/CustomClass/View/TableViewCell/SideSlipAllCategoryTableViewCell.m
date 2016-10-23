//
//  SideSlipAllCategoryTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipAllCategoryTableViewCell.h"
#import "FilterAllCategoryViewController.h"

@interface SideSlipAllCategoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;
@end

@implementation SideSlipAllCategoryTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SideSlipAllCategoryTableViewCell";
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    SideSlipAllCategoryTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"SideSlipAllCategoryTableViewCell" owner:nil options:nil][0];
    return cell;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model
                  indexPath:(NSIndexPath *)indexPath {
}

- (IBAction)clickBackgroundButton:(id)sender {
    FilterAllCategoryViewController *controller = [[FilterAllCategoryViewController alloc] init];
    if ([self.delegate respondsToSelector:@selector(sideSlipTableViewCellNeedsPushViewController:animated:)]) {
        [self.delegate sideSlipTableViewCellNeedsPushViewController:controller animated:YES];
    }
}
@end
