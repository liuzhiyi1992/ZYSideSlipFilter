//
//  SideSlipBaseTableViewCell.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYSideSlipFilterRegionModel.h"

@class SideSlipBaseTableViewCell;
@protocol SideSlipBaseTableViewCellDelegate <NSObject>
- (void)sideSlipTableViewCellNeedsReload:(NSIndexPath *)indexPath;
@end

@interface SideSlipBaseTableViewCell : UITableViewCell
@property (weak, nonatomic) id<SideSlipBaseTableViewCellDelegate> delegate;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath;
- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel **)model;
@end

