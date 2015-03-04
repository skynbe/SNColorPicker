//
//  ColorPickerPreview.m
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import "SNColorPickerPreview.h"

@implementation SNColorPickerPreview

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
    [self addSubview:self.hexColorTextField];
    NSDictionary *views = NSDictionaryOfVariableBindings(_hexColorTextField);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_hexColorTextField]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_hexColorTextField(25.0)]|" options:0 metrics:nil views:views]];
    
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [self.hexColorTextField becomeFirstResponder];
}

- (UITextField *)hexColorTextField {
    if (_hexColorTextField == nil) {
        _hexColorTextField = [[UITextField alloc] init];
        _hexColorTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _hexColorTextField.backgroundColor = [UIColor whiteColor];
        _hexColorTextField.textAlignment = NSTextAlignmentCenter;
        _hexColorTextField.delegate = self;
    }
    return _hexColorTextField;
}

#pragma mark - Color Picker Component Protocol

- (void)setColor:(UIColor *)color {
    _color = color;
    self.hexColorTextField.text = [_color hexString];
    self.backgroundColor = color;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.color = [UIColor colorWithHexString:textField.text];
    [self.delegate colorPickerComponent:self didChangeColor:self.color];
}

- (BOOL)resignFirstResponder {
    return [self.hexColorTextField resignFirstResponder];
}

@end
