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
    [color getHue:&hsbColor.hue saturation:&hsbColor.saturation brightness:&hsbColor.brightness alpha:&hsbColor.alpha];
    return hsbColor;
}

RGBColor RGBColorFromUIColor(UIColor *color) {
    RGBColor rgbColor;
    [color getRed:&rgbColor.red green:&rgbColor.green blue:&rgbColor.blue alpha:&rgbColor.alpha];
    return rgbColor;
}

+ (UIColor *)colorWithHSBColor:(HSBColor)color {
    // RGB color <-> HSB Color not working properly in extreme point
    CGFloat hue = MAX(0.001f, color.hue);
    CGFloat saturation = MAX(0.001f, color.saturation);
    CGFloat brightness = MAX(0.001f, color.brightness);
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:color.alpha];
}

- (NSString *)hexString {
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    if (a == 1.0f) {
        int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
        return [NSString stringWithFormat:@"#%06x", rgb];
    } else {
        int rgba = (int) (r * 255.0f)<<24 | (int) (g * 255.0f)<<16 | (int) (b * 255.0f)<<8 | (int) (a*255.0f)<<0;
        return [NSString stringWithFormat:@"#%08x", rgba];
    }
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    unsigned rgbValue = 0;
    [[NSScanner scannerWithString:colorString] scanHexInt:&rgbValue];
    if ([colorString length] == 8) {
        // #RRGGBBAA
        return [UIColor colorWithRed:((rgbValue >> 24) & 0xFF)/255.0f
                               green:((rgbValue >> 16) & 0xFF)/255.0f
                                blue:((rgbValue >> 8) & 0xFF)/255.0f
                               alpha:(rgbValue & 0xFF)/255.0f];
    } else {
        // #RRGGBB
        return [UIColor colorWithRed:((rgbValue >> 16) & 0xFF)/255.0f
                               green:((rgbValue >> 8) & 0xFF)/255.0f
                                blue:(rgbValue & 0xFF)/255.0f
                               alpha:1.0f];
    }
}

@end
