//
//  ColorPickerPreview.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNColorPickerComponent.h"

/**
 @abstract A view showing the color you choose and setting color with hex string.
 */
@interface SNColorPickerPreview : UIView <SNColorPickerComponent, UITextFieldDelegate>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<SNColorPickerComponentDelegate> delegate;
@property (nonatomic, strong) UITextField *hexColorTextField;

@end
