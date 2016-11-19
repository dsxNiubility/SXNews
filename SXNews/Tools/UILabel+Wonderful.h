//
//  UILabel+Wonderful.h
//  Wonderful
//
//  Created by dongshangxian on 16/1/7.
//  Copyright © 2016年 Sankuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Wonderful)

/**
 *  Set text which contains color mark
 *
 *  @param text  Text with color mark
 */
- (void)setColorText:(NSString *)text;

/**
 *  Set text which contains font mark
 *
 *  @param text Text with font mark
 */
- (void)setFontText:(NSString *)text;

/**
 *  Set text which contains color and font mark
 *
 *  @param text Text with color and font mark
 */
- (void)setColorFontText:(NSString *)text;

/**
 *  Set a highlight color to show emphasis between the beginmark and endmark
 *
 *  @param color A color different from label.TextColor
 */
+ (void)setAnotherColor:(UIColor *)color;

/**
 *  Set a highlight font to show emphasis between the beginmark and endmark
 *
 *  @param font A font different from label.font
 */
+ (void)setAnotherFont:(UIFont *)font;

@end
