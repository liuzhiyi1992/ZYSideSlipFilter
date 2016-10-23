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
#import "ZYSideSlipFilterConfig.h"

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
        [self setBackgroundColor:[UIColor hexColor:FILTER_COLLECTION_ITEM_COLOR_SELECTED_STRING]];
        [_nameButton setTitleColor:[UIColor hexColor:FILTER_RED_STRING] forState:UIControlStateNormal];
        self.layer.borderWidth = .5f;
        self.layer.borderColor = [UIColor hexColor:FILTER_RED_STRING].CGColor;
        [_nameButton setImage:[UIImage imageNamed:@"item_checked"] forState:UIControlStateNormal];
    } else {
        [self setBackgroundColor:[UIColor hexColor:FILTER_COLLECTION_ITEM_COLOR_NORMAL_STRING]];
        [_nameButton setTitleColor:[UIColor hexColor:FILTER_BLACK_STRING] forState:UIControlStateNormal];
        self.layer.borderWidth = 0;
        [_nameButton setImage:nil forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
