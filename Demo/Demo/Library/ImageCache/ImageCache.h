//
//  ImageCache.h
//  VKTime
//
//  Created by NIRAV on 18.04.12.
//  Copyright (c) 2012 Dimalex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageSettingDelegate.h"

@interface ImageCache : NSObject

+ (ImageCache *)sharedInstance;

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary *operationsDictionary;
@property (nonatomic, strong) NSCache *cache;

- (void)downloadImageWithUrl:(NSString *)urlString 
         delegate:(id<ImageSettingDelegate>)delegate 
              shouldDownload:(BOOL)shouldDownload;

- (void)removeOperationForKey:(NSString *)key;

- (void)storeImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageFromKey:(NSString *)key;

@end
