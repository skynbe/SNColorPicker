//
//  ColorPickerCursor.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 9..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNColorPickerCursor : UIView

@property (nonatomic, strong) UIColor *color;

- (void)touchBegan;
- (void)touchEnd;

@end
