//
//  ColorPickerPalette.m
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 6..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import "SNColorPickerPalette.h"
#import "SNColorPickerCursor.h"

@interface SNColorPickerPalette ()

@property (nonatomic, strong) CALayer *paletteLayer;
@property (nonatomic, strong) CALayer *brightnessLayer;
@property (nonatomic, strong) SNColorPickerCursor *cursor;

@end

@implementation SNColorPickerPalette

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
    [self.layer addSublayer:self.paletteLayer];
    [self.layer addSublayer:self.brightnessLayer];
    [self addSubview:self.cursor];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGestureRecognizer.minimumPressDuration = 0.01f;
    [self addGestureRecognizer:longPressGestureRecognizer];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.brightnessLayer.frame = self.bounds;
    self.paletteLayer.frame = self.bounds;
    self.color = self.color;
}

- (CALayer *)brightnessLayer {
    if (_brightnessLayer == nil) {
        _brightnessLayer = [[CALayer alloc] init];
        _brightnessLayer.frame = self.bounds;
        _brightnessLayer.backgroundColor = [UIColor blackColor].CGColor;
    }
    return _brightnessLayer;
}

- (CALayer *)paletteLayer {
    if (_paletteLayer == nil) {
        _paletteLayer = [[CALayer alloc] init];
        CGSize size = self.frame.size;
        
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        for (int i = 0; i < size.width; i++) {
            for (int j = 0; j < size.height; j++) {
                UIColor *color = [UIColor colorWithHue:(CGFloat)(i/size.width) saturation:(CGFloat)(1-j/size.height) brightness:1.0f alpha:1.0f];
                CGContextSetFillColorWithColor(context, color.CGColor);
                CGContextFillRect(context, CGRectMake(i, j, 1.0f, 1.0f));
            }
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        _paletteLayer.contents = (id)image.CGImage;
        _paletteLayer.frame = (CGRect){
            .origin = CGPointZero,
            .size = image.size
        };
    }
    return _paletteLayer;
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
    if (_color == nil) {
        return;
    }
    HSBColor hsbColor = HSBColorFromUIColor(_color);
    [CATransaction begin];
    [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.brightnessLayer.opacity = (1 - hsbColor.brightness) * hsbColor.alpha;
    self.cursor.center = CGPointMake(CGRectGetWidth(self.frame) * hsbColor.hue, CGRectGetHeight(self.frame) * (1 - hsbColor.saturation));
    self.cursor.color = _color;
    self.paletteLayer.opacity = hsbColor.alpha;
    [CATransaction commit];
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
    HSBColor hsbColor   = HSBColorFromUIColor(self.color);
    hsbColor.hue        = point.x / CGRectGetWidth(self.frame);
    hsbColor.saturation = 1 - point.y / CGRectGetHeight(self.frame);
    self.color = [UIColor colorWithHSBColor:hsbColor];
    [self.delegate colorPickerComponent:self didChangeColor:self.color];
}

@end
