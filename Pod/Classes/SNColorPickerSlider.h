//
//  ColorPickerSlider.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNColorPickerComponent.h"

@interface SNColorPickerSlider : UIView <SNColorPickerComponent>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<SNColorPickerComponentDelegate> delegate;

@end

@interface SNColorPickerBrightnessSlider : SNColorPickerSlider

@end

@interface SNColorPickerAlphaSlider : SNColorPickerSlider

@end
