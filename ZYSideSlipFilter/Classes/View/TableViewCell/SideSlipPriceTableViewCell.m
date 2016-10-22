//
//  SideSlipPriceTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipPriceTableViewCell.h"
#import "PriceRangeModel.h"

#define TEXTFIELD_MAX_LENGTH 6

@interface SideSlipPriceTableViewCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *minTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTextField;
@property (strong, nonatomic) ZYSideSlipFilterRegionModel *itemModel;
@end

@implementation SideSlipPriceTableViewCell 
+ (NSString *)cellReuseIdentifier {
    return @"SideSlipPriceTableViewCell";
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    SideSlipPriceTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"SideSlipPriceTableViewCell" owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.minTextField.delegate = cell;
    cell.maxTextField.delegate = cell;
    return cell;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model
                  indexPath:(NSIndexPath *)indexPath {
    self.itemModel = *model;
}

- (void)resetData {
    [_minTextField setText:@""];
    [_maxTextField setText:@""];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= TEXTFIELD_MAX_LENGTH && ![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    PriceRangeModel *model = [[PriceRangeModel alloc] init];
    model.minPrice = [_minTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    model.maxPrice = [_maxTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:_itemModel.customDict];
    [mutDict setValue:model forKey:PRICE_RANGE_MODEL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_maxTextField resignFirstResponder];
    [_minTextField resignFirstResponder];
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
