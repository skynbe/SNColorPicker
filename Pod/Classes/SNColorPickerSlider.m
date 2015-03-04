//
//  ColorPickerSlider.m
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import "SNColorPickerSlider.h"
#import "SNColorPickerCursor.h"

@interface SNColorPickerSlider ()

@property (nonatomic, strong) CAGradientLayer *sliderLayer;
@property (nonatomic, strong) SNColorPickerCursor *cursor;

@end

@implementation SNColorPickerSlider

- (id)init {
    self = [super init];
    if (self) {
        [self buildup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self buildup];
}

- (void)buildup {
    [self.layer addSublayer:self.sliderLayer];
    [self addSubview:self.cursor];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGestureRecognizer.minimumPressDuration = 0.01f;
    [self addGestureRecognizer:longPressGestureRecognizer];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.sliderLayer.frame = CGRectInset(self.bounds, 0.0f, 13.0f);
    self.color = self.color;
}

- (CAGradientLayer *)sliderLayer {
    if (_sliderLayer == nil) {
        _sliderLayer = [[CAGradientLayer alloc] initWithLayer:self.layer];
        _sliderLayer.frame = CGRectInset(self.bounds, 0, 13.0f);
        _sliderLayer.startPoint = CGPointMake(0.0f, 0.5f);
        _sliderLayer.endPoint = CGPointMake(1.0f, 0.5f);
        _sliderLayer.cornerRadius = 5.0f;
        _sliderLayer.borderWidth = 1.0f;
        _sliderLayer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
    }
    return _sliderLayer;
}

- (SNColorPickerCursor *)cursor {
    if (_cursor == nil) {
        _cursor = [[SNColorPickerCursor alloc] init];
    }
    return _cursor;
}

#pragma mark - Color Picker Component Protocol

- (void)setColor:(UIColor *)color {
    _color = color;
}

#pragma mark - UITapGesture Recognizer

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cursor touchBegan];
        }
        case UIGestureRecognizerStateChanged:{
            if (gestureRecognizer.numberOfTouches <= 0) {
                return;
            }
            CGPoint tapPoint = [gestureRecognizer locationOfTouch:0 inView:self];
            [self updateColorWithTapPoint:tapPoint];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self.cursor touchEnd];
        }
        default:
            break;
    }
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (gestureRecognizer.numberOfTouches <= 0) {
            return;
        }
        CGPoint tapPoint = [gestureRecognizer locationOfTouch:0 inView:self];
        [self updateColorWithTapPoint:tapPoint];
    }
}

- (void)updateColorWithTapPoint:(CGPoint)point {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end

@implementation SNColorPickerBrightnessSlider

- (void)setColor:(UIColor *)color {
    [super setColor:color];
    [CATransaction begin];
    [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
    HSBColor hsbColor = HSBColorFromUIColor(color);
    self.cursor.center = CGPointMake(CGRectGetWidth(self.frame) * (1 - hsbColor.brightness), CGRectGetHeight(self.frame) * 0.5);
    self.cursor.color = color;
    
    hsbColor.brightness = 0.0f;
    UIColor *darkColor = [UIColor colorWithHSBColor:hsbColor];
    hsbColor.brightness = 1.0f;
    UIColor *lightColor = [UIColor colorWithHSBColor:hsbColor];
    self.sliderLayer.colors = @[(id)lightColor.CGColor, (id)darkColor.CGColor];
    [CATransaction commit];
}

- (void)updateColorWithTapPoint:(CGPoint)point {
    HSBColor hsbColor   = HSBColorFromUIColor(self.color);
    hsbColor.brightness = 1 - point.x / CGRectGetWidth(self.frame);
    self.color = [UIColor colorWithHSBColor:hsbColor];
    [self.delegate colorPickerComponent:self didChangeColor:self.color];
}

@end

@implementation SNColorPickerAlphaSlider

- (void)setColor:(UIColor *)color {
    [super setColor:color];
    [CATransaction begin];
    [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
    HSBColor hsbColor = HSBColorFromUIColor(color);
    self.cursor.center = CGPointMake(CGRectGetWidth(self.frame) * (1 - hsbColor.alpha), CGRectGetHeight(self.frame) * 0.5);
    self.cursor.color = color;
    
    hsbColor.alpha = 0.0f;
    UIColor *darkColor = [UIColor colorWithHSBColor:hsbColor];
    hsbColor.alpha = 1.0f;
    UIColor *lightColor = [UIColor colorWithHSBColor:hsbColor];
    self.sliderLayer.colors = @[(id)lightColor.CGColor, (id)darkColor.CGColor];
    [CATransaction commit];
}

- (void)updateColorWithTapPoint:(CGPoint)point {
    HSBColor hsbColor   = HSBColorFromUIColor(self.color);
    hsbColor.alpha = 1 - point.x / CGRectGetWidth(self.frame);
    self.color = [UIColor colorWithHSBColor:hsbColor];
    [self.delegate colorPickerComponent:self didChangeColor:self.color];
}

@end