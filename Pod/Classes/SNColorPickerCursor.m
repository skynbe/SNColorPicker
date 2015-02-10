//
//  ColorPickerCursor.m
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 9..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import "SNColorPickerCursor.h"
#import "UIColor+SNColorPicker.h"

@interface SNColorPickerCursor ()

@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) CALayer *backgroundLayer;

@end

@implementation SNColorPickerCursor

- (id)init {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    if (self) {
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
        [self.layer addSublayer:self.backgroundLayer];
        [self.layer addSublayer:self.colorLayer];
    }
    return self;
}

- (CALayer *)backgroundLayer {
    if (_backgroundLayer == nil) {
        _backgroundLayer = [[CALayer alloc] init];
        _backgroundLayer.frame = self.bounds;
        _backgroundLayer.cornerRadius = CGRectGetWidth(_backgroundLayer.frame)/2;
        _backgroundLayer.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f].CGColor;
        _backgroundLayer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
        _backgroundLayer.borderWidth = 1.0f / [[UIScreen mainScreen] scale];
    }
    return _backgroundLayer;
}

- (CALayer *)colorLayer {
    if (_colorLayer == nil) {
        _colorLayer = [[CALayer alloc] init];
        _colorLayer.frame = CGRectInset(self.frame, 5.0f, 5.0f);
        _colorLayer.cornerRadius = CGRectGetWidth(_colorLayer.frame)/2;
        _colorLayer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
        _colorLayer.borderWidth = 1.0f / [[UIScreen mainScreen] scale];

    }
    return _colorLayer;
}

- (void)touchBegan {
    [UIView animateWithDuration:0.1f
                     animations:^{
                         self.layer.transform = CATransform3DMakeScale(1.6f, 1.6f, 1.0f);
                     }];
}

- (void)touchEnd {
    [UIView animateWithDuration:0.1f
                     animations:^{
                         self.layer.transform = CATransform3DIdentity;
                     }];
}

- (void)setColor:(UIColor *)color {
    HSBColor hsbColor = HSBColorFromUIColor(color);
    if (hsbColor.brightness > 0.8 && hsbColor.saturation < 0.3) {
        self.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
    self.colorLayer.backgroundColor = color.CGColor;
}

@end
