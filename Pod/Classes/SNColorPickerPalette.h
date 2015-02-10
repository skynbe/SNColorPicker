//
//  ColorPickerPalette.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 6..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNColorPickerComponent.h"

/**
 @abstract A pallete managing hue and saturation of color
 */
@interface SNColorPickerPalette : UIView <SNColorPickerComponent>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<SNColorPickerComponentDelegate> delegate;

@end
