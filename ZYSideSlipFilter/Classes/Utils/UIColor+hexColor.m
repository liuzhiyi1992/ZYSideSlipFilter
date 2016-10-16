//
//  UIColor+hexColor.m
//  IBABoss
//
//  Created by lzy on 16/8/31.
//  Copyright © 2016年 IBA. All rights reserved.
//

#import "UIColor+hexColor.h"
@implementation UIColor (hexColor)
+ (UIColor *)hexColor:(NSString *)hexColor{
    if ([hexColor length] < 6) {
        return nil;
    }
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.f) green:(float)(green / 255.f) blue:(float)(blue / 255.f) alpha:1.f];
}
@end
