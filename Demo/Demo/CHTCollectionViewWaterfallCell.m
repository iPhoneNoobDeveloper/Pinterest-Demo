//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by NIRAV on 12/11/27.

#import "CHTCollectionViewWaterfallCell.h"
#import "ImageCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation CHTCollectionViewWaterfallCell
@synthesize photoURL = _photoURL;
@synthesize cellImageView,lblTitle,lblDetailDesc;
@synthesize view;
@synthesize featuredImageView;
@synthesize btn,lblDesc,lblUserName;
@synthesize cellImageViewLine;
@synthesize soldImageView;
@synthesize btnLike,btnCounter;

#pragma mark - Accessors

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 150, 165)];
        //view.backgroundColor = [UIColor greenColor];
        view.backgroundColor = [UIColor clearColor];
        //        view.layer.cornerRadius = 10;
        //        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //        view.layer.borderWidth  = 0.5;
        
        view.clipsToBounds = YES;
        
        [self.contentView addSubview:view];
        
        cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 150, 100)];
        //cellImageView.layer.cornerRadius = 8;
       // cellImageView.image = [UIImage imageNamed:@"Default.png"];
        cellImageView.clipsToBounds =YES;
        cellImageView.backgroundColor = [UIColor clearColor];
        [view addSubview:cellImageView];
        
        cellImageViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 1)];
        //cellImageView.layer.cornerRadius = 8;
        cellImageViewLine.clipsToBounds =YES;
        cellImageViewLine.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        [view addSubview:cellImageViewLine];
        
        lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 101, 130, 20)];
        lblTitle.text = @"ad title";
        [lblTitle setFont:[UIFont boldSystemFontOfSize:14]];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.numberOfLines = 0;
        lblTitle.textAlignment = NSTextAlignmentRight;
        lblTitle.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.contentView addSubview:lblTitle];
        
        
//        imageViewUser = [[AsyncImageView alloc] initWithFrame:CGRectMake(113, 125, 35, 38)];
//        //imageViewUser.layer.cornerRadius = 10;
//        //        imageViewUser.image = [UIImage imageNamed:@"search-selected.png"];
//        [self.contentView addSubview:imageViewUser];
//        [imageViewUser.layer setCornerRadius:10.0];
        
        // border
        //        [imageViewUser.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        //        [imageViewUser.layer setBorderWidth:1.5f];
        //
        //        // drop shadow
        //        [imageViewUser.layer setShadowColor:[UIColor blackColor].CGColor];
        //        [imageViewUser.layer setShadowOpacity:0.8];
        //        [imageViewUser.layer setShadowRadius:3.0];
        //        [imageViewUser.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
        
        lblUserName= [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 45, 15)];
        //lblTitle.text = @"Kyuki tum hi ho";
        [lblUserName setFont:[UIFont boldSystemFontOfSize:11]];
        lblUserName.textColor = [UIColor darkGrayColor];
        lblUserName.numberOfLines = 0;
        lblUserName.textAlignment = NSTextAlignmentRight;
        lblUserName.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:lblUserName];
        
        lblDetailDesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 145, 100, 18)];
        //lblDetailDesc.text = @"Kyuki tum hi ho";
        [lblDetailDesc setFont:[UIFont systemFontOfSize:11]];
        lblDetailDesc.textColor = [UIColor darkGrayColor];
        lblDetailDesc.textAlignment = NSTextAlignmentRight;
        lblDetailDesc.backgroundColor = [UIColor clearColor]    ;
        [self.contentView addSubview:lblDetailDesc];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = view.bounds;
        btn.backgroundColor = [UIColor clearColor];
        [view addSubview:btn];
        self.backgroundColor = [UIColor clearColor];
        
                
        
        self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)setPhotoURL:(NSString *)aPhotoURL {
    [_activityIndicatorView removeFromSuperview];
    _activityIndicatorView = nil;
    
    _photoURL = aPhotoURL;
    
    if (_photoURL) {
        [[ImageCache sharedInstance] downloadImageWithUrl:_photoURL
                                                 delegate:self
                                           shouldDownload:YES];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //self.cellImageView.frame = CGRectInset(self.bounds, 10, 10);
    //    self.cellImageView.layer.borderColor = [UIColor grayColor].CGColor;
    //    self.cellImageView.layer.borderWidth = 2.0f;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    if (self.photoURL) {
        self.cellImageView.image = nil;
        [[ImageCache sharedInstance] removeOperationForKey:self.photoURL];
    }
}

- (void)didCacheImage:(UIImage *)image {
    [_activityIndicatorView removeFromSuperview];
    _activityIndicatorView = nil;
    
    if (image) {
        
        self.cellImageView.image = image;
        [self setNeedsLayout];
    } else {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        _activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.bounds)/4, 20);
        
        [_activityIndicatorView startAnimating];
        
        [self addSubview:_activityIndicatorView];
    }
}
- (UILabel *)displayLabel {
	if (!_displayLabel) {
		_displayLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
		_displayLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_displayLabel.backgroundColor = [UIColor lightGrayColor];
		_displayLabel.textColor = [UIColor whiteColor];
		_displayLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _displayLabel;
}

- (void)setDisplayString:(NSString *)displayString {
	if (![_displayString isEqualToString:displayString]) {
		_displayString = [displayString copy];
		self.displayLabel.text = _displayString;
	}
}

#pragma mark - Life Cycle
- (void)dealloc {
	[_displayLabel removeFromSuperview];
	_displayLabel = nil;
}


@end
