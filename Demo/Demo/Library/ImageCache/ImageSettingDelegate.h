//
//  ImageSettingDelegate.h
//  VKTime
//
//  Created by Volodymyr Shevchenko on 18.04.12.
//  Copyright (c) 2012 Dimalex. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageSettingDelegate <NSObject>

- (void)didCacheImage:(UIImage *)image;

@end
