//
//  NSString+Utils.h
//  Sport
//
//  Created by haodong  on 13-9-3.
//  Copyright (c) 2013年 haodong . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Utils)

- (NSString *)encodedURLParameterString;
- (NSString*)decodeURLString;

- (NSString *)md5;
- (int)actualLength;

- (NSString *)stringByTrimmingLeadingWhitespace;
- (NSString *)stringByTrimmingTrailingWhitespace;
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewline;
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewline;
- (CGSize)sizeWithMyFont:(UIFont *)fontToUse;
- (CGSize)sizeWithMyFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (BOOL) validateNickname;
- (BOOL) validateChinesename;
- (BOOL) validateEnglish;
@end
