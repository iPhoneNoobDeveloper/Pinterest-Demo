//
//  ViewController.m
//  Demo
//
//  Created by NIRAV on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "ViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *cellSizes;
@end

@implementation ViewController

#pragma mark - Accessors

- (UICollectionView *)collectionView {
  if (!_collectionView) {
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];

      layout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
      layout.headerHeight = 201;
      layout.footerHeight = 10;
      
      layout.minimumColumnSpacing = 10.0;
      layout.minimumInteritemSpacing =5.0;

      _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height) collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:FOOTER_IDENTIFIER];
  }
  return _collectionView;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    return insets;
}
- (NSMutableArray *)cellSizes {
  if (!_cellSizes) {
    _cellSizes = [NSMutableArray array];
    for (NSInteger i = 0; i < CELL_COUNT; i++) {
      CGSize size = CGSizeMake(arc4random() % 50 + 50, arc4random() % 50 + 50);
      _cellSizes[i] = [NSValue valueWithCGSize:size];
    }
  }
  return _cellSizes;
}

#pragma mark - Life Cycle

- (void)dealloc {
  _collectionView.delegate = nil;
  _collectionView.dataSource = nil;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    
    self.title = @"Pinterest Demo";
    self.navigationController.navigationBarHidden = NO;
    int min = 100 ; //it's as per your requirement
    int max = 250;
    arrHeight = [[NSMutableArray alloc]init];
    
    for (int i = 1; i < 6 ; i++) {
        float rowHeight =  min + arc4random() % (max - min + 1);
        [arrHeight addObject:[NSNumber numberWithFloat:rowHeight]];
    }
    
    arrRowImages = [[NSMutableArray alloc]initWithObjects:@"http://i.imgur.com/m8iz1LA.jpg",@"http://i.imgur.com/UCujWjw.jpg",@"http://i.imgur.com/SwBD82D.jpg",@"http://i.imgur.com/SwBD82D.jpg",@"http://i.imgur.com/2bRcGI8.jpg",@"http://i.imgur.com/KqU5AcT.jpg",@"http://i.imgur.com/mAsFOwf.jpg",@"http://i.imgur.com/3RxIgaf.jpg",@"http://i.imgur.com/F0utj45.jpg",@"http://i.imgur.com/WkuUkU4.jpg",@"http://i.imgur.com/VqdJECw.jpg",@"http://i.imgur.com/8YkZceb.jpg",@"http://i.imgur.com/JZxs27i.jpg", nil];
    
    
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
  CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
  layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return CELL_COUNT;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
  CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    
    float height = 0.0;
    switch (indexPath.row%5) {
        case 0:{
            height = [[arrHeight objectAtIndex:0] floatValue];
        }break;
        case 1:{
            height = [[arrHeight objectAtIndex:1] floatValue];
        }break;
        case 2:{
            height = [[arrHeight objectAtIndex:2] floatValue];
        }break;
        case 3:{
            height = [[arrHeight objectAtIndex:3] floatValue];
        }break;
        case 4:{
            height = [[arrHeight objectAtIndex:4] floatValue];
        }break;
            
        default:
            break;
    }
  
   
    cell.photoURL = [[arrRowImages objectAtIndex:indexPath.row%13] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    cell.displayString = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    
    cell.view.frame = CGRectMake(0, 0, 150, height);
    cell.cellImageView.frame = CGRectMake(0, 1, 150, height-1);
    cell.lblTitle.frame = CGRectMake(0, height-20, 150, 20);
    return cell;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  UICollectionReusableView *reusableView = nil;

    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
        
        if (reusableView==nil) {
            reusableView=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 201)];
        }
        int x=0;
        int y=0;
        int width=320;
        int height=201;
        
        if (!scrollView) {
             scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 201)];
            
            
            for (int i=0;i<3; i++) {
                
                UIView *view = [[UIView alloc]init];
                view.frame = CGRectMake(x+(i*width), y, width, height);
                
                
                AsyncImageView  *asyncImageView =  [[AsyncImageView alloc]initWithFrame:CGRectMake(0,0, 320, height)];
                
                asyncImageView.backgroundColor = [UIColor grayColor];
                // [asyncImageView setTag:2436];
                [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:asyncImageView];
                
                
                
                //            //
                NSString *urlImage = [[arrRowImages objectAtIndex:i+4]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                asyncImageView.backgroundColor = [UIColor clearColor];
                NSURL *url = [NSURL URLWithString:urlImage];
                asyncImageView.imageURL = url;
                
                //  [asyncImageView.layer setMasksToBounds:YES];
                
                [view addSubview:asyncImageView];
                // [view sendSubviewToBack:imageView];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [btn addTarget:self action:@selector(navigateToDetail:) forControlEvents:UIControlEventTouchUpInside];
                btn.frame = asyncImageView.bounds;
                btn.backgroundColor = [UIColor clearColor];
                [btn setTag:i];
                
                [view addSubview:btn];
                
                [scrollView addSubview:view];
                
                
                
                
                UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, height-40, 320, 40)];
                titleView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
                
                [view addSubview:titleView];
                
                
                UILabel *labelCompanyName = [[UILabel alloc]initWithFrame:CGRectMake(0 ,7 , 320, 25 )];
                labelCompanyName.text = [NSString stringWithFormat: @"Feature Ad %d",i+1];
                labelCompanyName.textColor = [UIColor whiteColor];
                labelCompanyName.backgroundColor = [UIColor clearColor];
                labelCompanyName.font = [UIFont systemFontOfSize:14];
                labelCompanyName.textAlignment = NSTextAlignmentCenter;
                [titleView addSubview:labelCompanyName];
                //
                
                
                
                
            }
            int size=(int)(3*width);
            [scrollView setContentSize:CGSizeMake(size, height)];
            scrollView.pagingEnabled = YES;
            [reusableView addSubview:scrollView];
            
            if (!timer || ![timer isValid]) {
                timer =[NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(moveNextScroll) userInfo:Nil repeats:YES];
            }

            
        }
        
        
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    
   
  return reusableView;
}

-(void)moveNextScroll{
    //    if (!_categoryCell) {
    //        return;
    //    }
    //UIScrollView *scrollView =(UIScrollView *)[_featureAdView viewWithTag:111];
    CGPoint scrollPoint=scrollView.contentOffset;
    int catIndex=scrollPoint.x/320;
    int categoryCount=3;
    catIndex++;
    
    if (catIndex>=categoryCount) {
        catIndex=0;
    }
    [scrollView scrollRectToVisible:CGRectMake(catIndex*320,0, 320, 199) animated:YES];
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float height = 0.0;
    switch (indexPath.row%5) {
        case 0:{
            height = [[arrHeight objectAtIndex:0] floatValue];
        }break;
        case 1:{
            height = [[arrHeight objectAtIndex:1] floatValue];
        }break;
        case 2:{
            height = [[arrHeight objectAtIndex:2] floatValue];
        }break;
        case 3:{
            height = [[arrHeight objectAtIndex:3] floatValue];
        }break;
        case 4:{
            height = [[arrHeight objectAtIndex:4] floatValue];
        }break;
            
        default:
            break;
    }
    return CGSizeMake(150, height);
  
}

#pragma mark UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
    //NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
   
    NSLog(@"%f", scrollView1.contentOffset.y);
    if (scrollView1.contentOffset.y  >= 50) {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
    else{
         [[self navigationController] setNavigationBarHidden:NO animated:YES];
    }
}

-(float)tableViewOrigin{
    float height=0.0f;
    height=_collectionView.contentOffset.y;
    return height;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float maxHeight = 0.0f;
    
    
    float endOfTable = [self endOfTableView:scrollView];
    float orginTable = [self tableViewOrigin];
    if (orginTable < -50.0f  ) {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
    
    
    
}

- (float)endOfTableView:(UIScrollView *)scrollView {
    return [self tableViewHeight] - scrollView.bounds.size.height - scrollView.bounds.origin.y;
}

- (float)tableViewHeight {
   
    CGFloat maxHeight = 0;
    
    
    float height=[_collectionView contentSize].height;
    float contentHeight=self.collectionView.contentSize.height;
    float tableHeight=self.collectionView.frame.size.height;
    if (height<tableHeight) {
        height=tableHeight;
    }
    if (height< contentHeight) {
        height=contentHeight;
    }
    //    if (height<416.0f) {
    //        height=416;
    //    }
    return maxHeight;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    return YES;
}



@end
