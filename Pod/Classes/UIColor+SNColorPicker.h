//
//  UIColor+ColorPicker.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 9..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct  {
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
} HSBColor;

typedef struct {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
} RGBColor;

@interface UIColor (SNColorPicker)

HSBColor HSBColorFromUIColor(UIColor *color);
RGBColor RGBColorFromUIColor(UIColor *color);

+ (UIColor *)colorWithHSBColor:(HSBColor)color;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
- (NSString *)hexString;

@end
