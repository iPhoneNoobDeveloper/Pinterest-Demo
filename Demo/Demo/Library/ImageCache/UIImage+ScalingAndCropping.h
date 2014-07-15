//
//  UIImage+ScalingAndCropping.h
//  VKTime
//
//  Created by Volodymyr Shevchenko on 19.04.12.
//  Copyright (c) 2012 Dimalex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScalingAndCropping)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage *)makeRoundCornerImage:(UIImage *)img cornerWidth:(int)cornerWidth cornerHeight:(int)cornerHeight;

@end
