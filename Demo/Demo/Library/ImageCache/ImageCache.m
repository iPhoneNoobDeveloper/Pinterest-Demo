//
//  ImageCache.m
//  VKTime
//
//  Created by NIRAV on 18.04.12.
//  Copyright (c) 2012 Dimalex. All rights reserved.
//

#import "ImageCache.h"
#import "ImageCacheOperation.h"

@implementation ImageCache
@synthesize queue;
@synthesize operationsDictionary;
@synthesize cache;

+ (ImageCache *)sharedInstance {
    static ImageCache *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [ImageCache new];
    });
    
    return shared;
}

- (id)init {
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
        self.operationsDictionary = [NSMutableDictionary new];
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)storeImage:(UIImage *)image forKey:(NSString *)key {
    if (key && image) {
        [self.cache setObject:image forKey:key];
    }
}

- (UIImage *)imageFromKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    return [self.cache objectForKey:key];
}

- (void)downloadImageWithUrl:(NSString *)urlString 
                    delegate:(id<ImageSettingDelegate>)delegate 
              shouldDownload:(BOOL)shouldDownload {

    if (urlString == nil) {
        return;
    }
    
    UIImage *image = [self imageFromKey:urlString];
    
    if (image) {
        [delegate didCacheImage:image];
    } else if (shouldDownload) {
        [delegate didCacheImage:nil];

        ImageCacheOperation *operation = [[ImageCacheOperation alloc] init];
        operation.imageURLString = urlString;
        operation.delegate = delegate;
        
        [self.operationsDictionary setObject:operation forKey:urlString];
        [self.queue addOperation:operation];
    }
}

- (void)removeOperationForKey:(NSString *)key {
    
    NSLog(@"%@", key);
    if (key) {
        NSOperation *operation = [self.operationsDictionary objectForKey:key];
        [self.operationsDictionary removeObjectForKey:key];
        [operation cancel];
    }
}

@end
