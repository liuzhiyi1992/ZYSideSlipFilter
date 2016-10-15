//
//  FilterCommonCollectionViewCell.m
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/15.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "FilterCommonCollectionViewCell.h"

@interface FilterCommonCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@end

@implementation FilterCommonCollectionViewCell
+ (NSString *)cellReuseIdentifier {
    return @"FilterCommonCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self setupCell];
    }
    return self;
}

- (void)updateCellWithDataDict:(NSDictionary *)dataDict {
    [_nameButton setTitle:dataDict[@"name"] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
