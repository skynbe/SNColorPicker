//
//  ColorPickerComponent.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+SNColorPicker.h"

@protocol SNColorPickerComponentDelegate;

@protocol SNColorPickerComponent <NSObject>

@required
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<SNColorPickerComponentDelegate> delegate;

@end

@protocol SNColorPickerComponentDelegate <NSObject>

- (void)colorPickerComponent:(UIView<SNColorPickerComponent> *)component didChangeColor:(UIColor *)color;

@end