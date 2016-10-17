//
//  FilterCommonCollectionViewCell.m
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/15.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "FilterCommonCollectionViewCell.h"
#import "CommonItemModel.h"
#import "UIColor+hexColor.h"

#define TEXT_COLOR_SELECTED FILTER_RED
#define TEXT_COLOR_NORMAL [UIColor hexColor:@"333333"]
#define BACKGROUND_COLOR_SELECTED [UIColor whiteColor]
#define BACKGROUND_COLOR_NORMAL [UIColor hexColor:@"eeeeee"]

@interface FilterCommonCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (copy, nonatomic) NSString *itemId;
@end

@implementation FilterCommonCollectionViewCell
+ (NSString *)cellReuseIdentifier {
    return @"FilterCommonCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return [[NSBundle mainBundle] loadNibNamed:@"FilterCommonCollectionViewCell" owner:nil options:nil][0];
}

- (void)updateCellWithModel:(CommonItemModel *)model {
    [_nameButton setTitle:model.itemName forState:UIControlStateNormal];
    self.itemId = model.itemId;
    [self tap2SelectItem:model.selected];
}

- (void)tap2SelectItem:(BOOL)selected {
    if (selected) {
        [self setBackgroundColor:BACKGROUND_COLOR_SELECTED];
        [_nameButton setTitleColor:TEXT_COLOR_SELECTED forState:UIControlStateNormal];
        self.layer.borderWidth = .5f;
        self.layer.borderColor = TEXT_COLOR_SELECTED.CGColor;
    } else {
        [self setBackgroundColor:BACKGROUND_COLOR_NORMAL];
        [_nameButton setTitleColor:TEXT_COLOR_NORMAL forState:UIControlStateNormal];
        self.layer.borderWidth = 0;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
