//
//  SideSlipBaseTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipBaseTableViewCell.h"
#import "ZYSideSlipFilterConfig.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation SideSlipBaseTableViewCell
#pragma clang diagnostic pop

+ (NSString *)cellReuseIdentifier {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model
                  indexPath:(NSIndexPath *)indexPath {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerNotification];
}

- (void)dealloc {
    [self resignNotification];
}

- (void)resetData {
    
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetData) name:FILTER_NOTIFICATION_NAME_DID_RESET_DATA object:nil];
}

- (void)resignNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
