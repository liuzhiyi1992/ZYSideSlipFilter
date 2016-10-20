//
//  AddressTableViewCell.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/20.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressModel;
@interface AddressTableViewCell : UITableViewCell
+ (NSString *)cellReuseIdentifier;
+ (AddressTableViewCell *)createCell;
- (void)updateCellWithAddressModel:(AddressModel *)model isSelected:(BOOL)isSelected;
@end
