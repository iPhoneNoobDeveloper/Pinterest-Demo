//
//  ImageCacheOperation.m
//  VKTime
//
//  Created by Volodymyr Shevchenko on 18.04.12.
//  Copyright (c) 2012 Dimalex. All rights reserved.
//

#import "ImageCacheOperation.h"
#import "ImageCache.h"
#import "UIImage+ScalingAndCropping.h"


UIImage* decodeImage(UIImage *imageToDecode) {
    return imageToDecode;
    //TODO:Fix image decoding
    
    CGImageRef originalImage = imageToDecode.CGImage;
    //    NSAssert(originalImage != NULL, @"Original image is NULL");
    
    CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(originalImage));
    CGDataProviderRef imageDataProvider = CGDataProviderCreateWithCFData(imageData);
    if (imageData != NULL) {
        CFRelease(imageData);
    }
    
    CGImageRef image = CGImageCreate(CGImageGetWidth(originalImage),
                                     CGImageGetHeight(originalImage),
                                     CGImageGetBitsPerComponent(originalImage),
                                     CGImageGetBitsPerPixel(originalImage),
                                     CGImageGetBytesPerRow(originalImage),
                                     CGImageGetColorSpace(originalImage),
                                     CGImageGetBitmapInfo(originalImage),
                                     imageDataProvider,
                                     CGImageGetDecode(originalImage),
                                     CGImageGetShouldInterpolate(originalImage),
                                     CGImageGetRenderingIntent(originalImage));
    if (imageDataProvider != NULL) {
        CGDataProviderRelease(imageDataProvider);
    }
    
    UIImage *resultImage = [UIImage imageWithCGImage:image]; 
    
    CGImageRelease(image);
    
    return resultImage;
}


@implementation ImageCacheOperation
@synthesize delegate, imageURLString;

- (void)main {
    void (^setupImage)(UIImage *image) = ^(UIImage *image) {
        if (self.delegate && !self.isCancelled) {
            [self.delegate didCacheImage:image];
        }
    };
    
    NSURL *url = [NSURL URLWithString:self.imageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    [[ImageCache sharedInstance] storeImage:image forKey:self.imageURLString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        setupImage(image);
    });
}

@end
