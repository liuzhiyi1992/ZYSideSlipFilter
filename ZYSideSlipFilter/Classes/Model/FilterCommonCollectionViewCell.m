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

- (void)updateCellWithDataDict:(NSDictionary *)dataDict {
    [_nameButton setTitle:dataDict[@"itemTitle"] forState:UIControlStateNormal];
    self.itemId = dataDict[@"itemId"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
