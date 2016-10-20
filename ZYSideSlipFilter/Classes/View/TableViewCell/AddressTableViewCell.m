//
//  AddressTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/20.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressModel.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
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
    if (isSelected) {
        [_iconImageView setImage:[UIImage imageNamed:@"address_icon_sel"]];
    } else {
        [_iconImageView setImage:[UIImage imageNamed:@"address_icon_desel"]];
    }
}
@end
