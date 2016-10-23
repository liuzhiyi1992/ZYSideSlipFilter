//
//  SideSlipSpaceTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/19.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipSpaceTableViewCell.h"
#import "UIColor+hexColor.h"

@implementation SideSlipSpaceTableViewCell
+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    SideSlipSpaceTableViewCell *cell = [[SideSlipSpaceTableViewCell alloc] initWithFrame:CGRectZero];
    [cell setBackgroundColor:[UIColor hexColor:@"f1f1f1"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

+ (NSString *)cellReuseIdentifier {
    return @"SideSlipSpaceTableViewCell";
}

+ (CGFloat)cellHeight {
    return 8.f;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model indexPath:(NSIndexPath *)indexPath {
    
}
@end
