//
//  ViewController.h
//  Demo
//
//  Created by NIRAV on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
{
    NSMutableArray *arrHeight;
    NSMutableArray *arrRowImages;
    UIScrollView *scrollView;
     NSTimer *timer;
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
}

@property (strong, nonatomic) IBOutlet UIView *featureAdView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end
