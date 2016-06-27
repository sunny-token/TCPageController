//
//  ZWSViewController.h
//  ZWSlideViewController
//
//  Created by sunny on 09/07/2016.
//  Copyright (c) 2015 sunny. All rights reserved.
//

#import "ZWSPagingView.h"
#import "ZWSSectionBar.h"
#import "DefineConstant.h"
#import "UIView+Frame.h"
#import "UIColor+Foundation.h"
#import "UIButton+TapScope.h"

@interface ZWSViewController : UIViewController <ZWSPagingViewDataSource, ZWSPagingViewDelegate, ZWSSectionBarDelegate>
{
    //more view 伸缩
    BOOL isShow;
}

@property (nonatomic, readonly) ZWSPagingView *pagingView;
@property (nonatomic, readonly) ZWSSectionBar *sectionBar;
@property (nonatomic, strong) UIView *lineView;

/**
 Whether to use 3D effects scrolling to next page. Defaults to `NO`.
 */
@property(nonatomic, assign) BOOL useTransform3DEffects;

@property(nonatomic, assign) CGFloat menuHeight;

@property(nonatomic, assign) CGFloat menuWidth;

@property(nonatomic, strong) NSMutableArray *menuTitles;

@property (nonatomic, strong)UIView * moreView;

@property (nonatomic, strong)UIButton *moreBtn;

@property (nonatomic, strong) UIImageView *linView;


// This method could be overridden in subclasses to prepare some data source, The default is a nop.
- (void)loadData;

// This method could be invoked to refresh all subViews.
- (void)refreshViews;

// This method could be overridden in subclasses to create custom content view in page
- (UIViewController *)contentViewForPage:(ZWSPage *)page atIndex:(NSInteger)index;

-(void)hideMoreView:(BOOL)hidden;

-(void)configMoreView;
@end