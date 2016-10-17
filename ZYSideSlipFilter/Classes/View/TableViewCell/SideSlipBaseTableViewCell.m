//
//  SideSlipBaseTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipBaseTableViewCell.h"
#import "ZYSideSlipFilterConfig.h"

@implementation SideSlipBaseTableViewCell
+ (NSString *)cellReuseIdentifier {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass");
    return nil;
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass");
    return nil;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass");
}

- (void)resetData {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerNotification];
}

- (void)dealloc {
    [self resignNotification];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetData) name:FILTER_NOTIFICATION_NAME_RESET_DATA object:nil];
}

- (void)resignNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
