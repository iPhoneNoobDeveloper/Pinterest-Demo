//
//  ImageCacheOperation.h
//  VKTime
//
//  Created by Volodymyr Shevchenko on 18.04.12.
//  Copyright (c) 2012 Dimalex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageSettingDelegate.h"

@interface ImageCacheOperation : NSOperation

@property (nonatomic, strong) id<ImageSettingDelegate> delegate;
@property (nonatomic, strong) NSString *imageURLString;

@end
