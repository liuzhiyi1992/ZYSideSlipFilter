//
//  SideSlipPriceTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipPriceTableViewCell.h"
#import "PriceRangeModel.h"
#import "UIColor+hexColor.h"
#import "ZYSideSlipFilterConfig.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define TEXTFIELD_MAX_LENGTH 6

#define ACCESSORY_VIEW_HEIGHT 34
#define ACCESSORY_BUTTON_WIDTH 50
#define ACCESSORY_BUTTON_LEADING_TRAILING 0

@interface SideSlipPriceTableViewCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *minTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTextField;
@property (strong, nonatomic) ZYSideSlipFilterRegionModel *regionModel;
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
    [cell configureKeyboard];
    return cell;
}

- (void)configureKeyboard {
    UIView *keyBoardAccessoryView = [self createKeyBoardAccessoryView];
    _minTextField.inputAccessoryView = keyBoardAccessoryView;
    _maxTextField.inputAccessoryView = keyBoardAccessoryView;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model
                  indexPath:(NSIndexPath *)indexPath {
    self.regionModel = *model;
}

- (void)resetData {
    [_minTextField setText:@""];
    [_maxTextField setText:@""];
}

- (UIView *)createKeyBoardAccessoryView {
    UIView *keyBoardAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ACCESSORY_VIEW_HEIGHT)];
    [keyBoardAccessoryView setBackgroundColor:[UIColor hexColor:@"e1e1e1"]];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(ACCESSORY_BUTTON_LEADING_TRAILING, 0, ACCESSORY_BUTTON_WIDTH, ACCESSORY_VIEW_HEIGHT)];
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [backButton addTarget:self action:@selector(accessoryButtonBack) forControlEvents:UIControlEventTouchUpInside];
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - ACCESSORY_BUTTON_LEADING_TRAILING - ACCESSORY_BUTTON_WIDTH, 0, ACCESSORY_BUTTON_WIDTH, ACCESSORY_VIEW_HEIGHT)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor hexColor:FILTER_RED_STRING] forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [doneButton addTarget:self action:@selector(accessoryButtonDone) forControlEvents:UIControlEventTouchUpInside];
    [keyBoardAccessoryView addSubview:backButton];
    [keyBoardAccessoryView addSubview:doneButton];
    return keyBoardAccessoryView;
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
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:_regionModel.customDict];
    [mutDict setValue:model forKey:PRICE_RANGE_MODEL];
    _regionModel.customDict = [mutDict copy];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_maxTextField resignFirstResponder];
    [_minTextField resignFirstResponder];
}

- (void)accessoryButtonBack {
    if ([_minTextField isFirstResponder]) {
        [_minTextField setText:@""];
        [_minTextField resignFirstResponder];
    } else if ([_maxTextField isFirstResponder]) {
        [_maxTextField setText:@""];
        [_maxTextField resignFirstResponder];
    }
}

- (void)accessoryButtonDone {
    [_minTextField resignFirstResponder];
    [_maxTextField resignFirstResponder];
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
