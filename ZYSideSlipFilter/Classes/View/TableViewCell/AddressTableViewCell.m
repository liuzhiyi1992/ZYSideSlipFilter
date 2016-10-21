//
//  AddressTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/20.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressModel.h"
#import "NSString+Utils.h"
#import "UIColor+hexColor.h"
#import "ZYSideSlipFilterConfig.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLabelHeightConstraint;
@end

@implementation AddressTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"AddressTableViewCell";
}

+ (AddressTableViewCell *)createCell {
    AddressTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)updateCellWithAddressModel:(AddressModel *)model isSelected:(BOOL)isSelected {
    [_addressLabel setText:model.addressString];
//    [self calculateContentLabelheight];
    if (isSelected) {
        [_iconImageView setImage:[UIImage imageNamed:@"address_icon_sel"]];
        [_addressLabel setTextColor:[UIColor hexColor:FILTER_RED_STRING]];
    } else {
        [_iconImageView setImage:[UIImage imageNamed:@"address_icon_desel"]];
        [_addressLabel setTextColor:[UIColor hexColor:FILTER_BLACK_STRING]];
    }
}

- (void)calculateContentLabelheight {
    [self layoutIfNeeded];
    CGSize size = [_addressLabel.text sizeWithMyFont:_addressLabel.font constrainedToSize:CGSizeMake(_addressLabel.frame.size.width, CGFLOAT_MAX)];
    _addressLabelHeightConstraint.constant = size.height;
}
@end
