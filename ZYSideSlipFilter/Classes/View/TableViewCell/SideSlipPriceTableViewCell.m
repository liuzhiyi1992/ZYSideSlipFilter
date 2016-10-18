//
//  SideSlipPriceTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipPriceTableViewCell.h"

@implementation SideSlipPriceTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SideSlipPriceTableViewCell";
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    SideSlipPriceTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"SideSlipPriceTableViewCell" owner:nil options:nil][0];
    return cell;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
