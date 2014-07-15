//
//  UICollectionViewWaterfallCell.h
//  Demo
//
//  Created by NIRAV on 12/11/27.

#import <UIKit/UIKit.h>
#import "ImageSettingDelegate.h"
#import "AsyncImageView.h"


@interface CHTCollectionViewWaterfallCell : UICollectionViewCell<ImageSettingDelegate>{
     UIActivityIndicatorView *_activityIndicatorView;
}
@property (nonatomic, copy) NSString *displayString;
@property (nonatomic, strong) IBOutlet UILabel *displayLabel;

@property (nonatomic, retain) UIView *view;
@property(nonatomic, strong) NSString *photoURL;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UIImageView *cellImageView;
@property (nonatomic, retain) UIImageView *cellImageViewLine;
@property (nonatomic, retain) UILabel *lblTitle;

@property (nonatomic, retain) UILabel *lblUserName;
@property  (nonatomic, retain) UILabel *lblDesc;
@property  (nonatomic, retain) UILabel *lblDetailDesc;
@property (nonatomic, retain) UIImageView *featuredImageView;
@property (nonatomic, retain) UIImageView *soldImageView;

@property (nonatomic, retain) UIButton *btnLike;
@property (nonatomic, retain) UIButton *btnCounter;


@end
