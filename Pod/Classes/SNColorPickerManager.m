//
//  ColorPickerManager.m
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import "SNColorPickerManager.h"

@interface SNColorPickerManager () <SNColorPickerComponentDelegate>

@property (nonatomic, strong) NSMutableArray *components;

@end

@implementation SNColorPickerManager

- (id)init {
    self = [super init];
    if (self) {
        self.components = [NSMutableArray array];
    }
    return self;
}

- (void)addColorPickerComponents:(NSArray *)components {
    for (UIView<SNColorPickerComponent> *component in components) {
        [self.components addObject:component];
        component.delegate = self;
    }
}

- (void)setColor:(UIColor *)color {
    if (![_color isEqual:color]) {
        for (UIView<SNColorPickerComponent> *component in self.components) {
            component.color = color;
        }
        if ([self.delegate respondsToSelector:@selector(colorPickerManager:didChangeColor:)]) {
            [self.delegate colorPickerManager:self didChangeColor:color];
        }
    }
    _color = color;
}

#pragma mark - Color Picker Component Delegate

- (void)colorPickerComponent:(UIView<SNColorPickerComponent> *)component didChangeColor:(UIColor *)color {
    self.color = color;
}

@end
