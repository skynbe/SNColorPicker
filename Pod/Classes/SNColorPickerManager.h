//
//  ColorPickerManager.h
//  ColorPicker
//
//  Created by Seongwook Seo on 2015. 2. 5..
//  Copyright (c) 2015년 Seongwook Seo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNColorPickerComponent.h"

@class SNColorPickerManager;

@protocol SNColorPickerManagerDelegate <NSObject>

- (void)colorPickerManager:(SNColorPickerManager *)manager didChangeColor:(UIColor *)color;

@end

@interface SNColorPickerManager : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<SNColorPickerManagerDelegate> delegate;

/**
 @abstract Add color components to be managed by this. All color of components under this manager will be synchronized.
 */
- (void)addColorPickerComponents:(NSArray *)components;

@end
