//
//  SNViewController.m
//  SNColorPicker
//
//  Created by Seongwook Seo on 02/10/2015.
//  Copyright (c) 2014 Seongwook Seo. All rights reserved.
//

#import "SNViewController.h"
#import "SNColorPickerSlider.h"
#import "SNColorPickerManager.h"
#import "SNColorPickerPreview.h"
#import "SNColorPickerPalette.h"

@interface SNViewController () <ColorPickerManagerDelegate>

@property (strong, nonatomic) SNColorPickerManager *colorPickerManager;

@property (weak, nonatomic) IBOutlet SNColorPickerSlider *slider;
@property (weak, nonatomic) IBOutlet SNColorPickerPreview *preview;
@property (weak, nonatomic) IBOutlet SNColorPickerPalette *palette;
@property (weak, nonatomic) IBOutlet UILabel *rgbLabel;

@end

@implementation SNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorPickerManager = [[SNColorPickerManager alloc] init];
    self.colorPickerManager.delegate = self;
    
    [self.colorPickerManager addColorPickerComponents:@[self.slider, self.preview, self.palette]];
    self.colorPickerManager.color = [UIColor colorWithHexString:@"#5d7c8c"];
}

#pragma mark - SNColorPickerManager Delegate

- (void)colorPickerManager:(SNColorPickerManager *)manager didChangeColor:(UIColor *)color {
    RGBColor rgbColor = RGBColorFromUIColor(color);
    self.rgbLabel.text = [NSString stringWithFormat:@"%d\n%d\n%d", (int)(255.0f*rgbColor.red), (int)(255.0f*rgbColor.green), (int)(255.0f*rgbColor.blue)];
}

@end
