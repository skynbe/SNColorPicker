//
//  ColorPickerSlider.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNColorPickerComponent.h"

/**
 @abstract A slider managing brightness of color
 */
@interface SNColorPickerSlider : UIView <SNColorPickerComponent>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<SNColorPickerComponentDelegate> delegate;

@end
