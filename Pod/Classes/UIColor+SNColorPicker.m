//
//  UIColor+ColorPicker.m
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 9..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import "UIColor+SNColorPicker.h"

@implementation UIColor (SNColorPicker)

HSBColor HSBColorFromUIColor(UIColor *color) {
    HSBColor hsbColor;
    [color getHue:&hsbColor.hue saturation:&hsbColor.saturation brightness:&hsbColor.brightness alpha:nil];
    return hsbColor;
}

RGBColor RGBColorFromUIColor(UIColor *color) {
    RGBColor rgbColor;
    [color getRed:&rgbColor.red green:&rgbColor.green blue:&rgbColor.blue alpha:nil];
    return rgbColor;
}

+ (UIColor *)colorWithHSBColor:(HSBColor)color {
    // RGB color <-> HSB Color not working properly in extreme point
    CGFloat hue = MAX(0.001f, color.hue);
    CGFloat saturation = MAX(0.001f, color.saturation);
    CGFloat brightness = MAX(0.001f, color.brightness);
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
}

- (NSString *)hexString {
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"#%06x", rgb];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    unsigned rgbValue = 0;
    [[NSScanner scannerWithString:colorString] scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
