//
//  ZWSViewController.m
//  ZWSlideViewController
//

#import "ZWSViewController.h"
#import "CategoryListDTO.h"

#define MVSidePadding (22)
#define MVCentPadding (30)
#define MVSideHeightPadding (15)
#define MVCenterHeightPadding (12)
#define MVLableTag  1000

@interface ZWSViewController ()
{
    
}

@end

@implementation ZWSViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    self.useTransform3DEffects = NO;
    isShow = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!_sectionBar) {
        _sectionBar = [[ZWSSectionBar alloc] init];
        _sectionBar.barDelegate = self;
        _sectionBar.menuInsets   = UIEdgeInsetsMake(0, 10, 0, 10);
        _sectionBar.backgroundColor = [UIColor whiteColor];
    }
    
    if (!_pagingView) {
        _pagingView = [[ZWSPagingView alloc] init];
        _pagingView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _pagingView.pagingDataSource = self;
        _pagingView.pagingDelegate = self;
    }
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    }
}

-(void)moreBtnAction:(id)sender
{
    [self hideMoreView:isShow];
    isShow = !isShow;
}

-(UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.backgroundColor = [UIColor clearColor];
        [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_moreBtn setTitle:@"more" forState:UIControlStateNormal];
        CGFloat height = (self.sectionBar.height - 9.0f)/2;
        _moreBtn.frame = CGRectMake(self.sectionBar.right + (kScreenWidth - self.sectionBar.width - 15.0f)/2, height, 15.0f, 9.0f);
        [_moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn.hitEdgeInsets = UIEdgeInsetsMake(-15, -10, -15, -10);
        [_moreBtn setAlpha:0.7];
        [_moreBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}


-(UIImageView *)linView
{
    if (!_linView) {
        _linView = [[UIImageView alloc] initWithFrame:CGRectMake(self.moreBtn.left-10/2-8, 0, 10/2, 87/2)];
        [_linView setImage:[UIImage imageNamed:@"djh_ext_bg"]];
        [_linView setAlpha:0.8];
    }
    return _linView;
}

-(UIView *)moreView
{
    if (!_moreView) {
        _moreView = [[UIView alloc] initWithFrame:CGRectMake(0, self.sectionBar.bottom, kScreenWidth, 150.f)];
        _moreView.backgroundColor = [UIColor whiteColor];
        _moreView.hidden = YES;
        _moreView.alpha = 0.9;
    }
    return _moreView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configMoreView];
}

- (void)viewWillLayoutSubviews
{
    [self loadData];
}

- (void)viewDidLayoutSubviews
{
    [self refreshViews];
}

- (CGFloat)menuHeight
{
    if (!_menuHeight) {
        return 44.0f;
    }
    return _menuHeight;
}

- (CGFloat)menuWidth
{
    if (!_menuWidth) {
        return kScreenWidth;
    }
    return _menuWidth;
}

-(NSMutableArray *)menuTitles
{
    if (!_menuTitles) {
        _menuTitles = [[NSMutableArray alloc] init];
    }
    return _menuTitles;
}

#pragma mark - Public methods

- (void)loadData
{
    //do nothing
}

-(void)hideMoreView:(BOOL)hidden
{
    if (!hidden) {
        [self.moreBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        self.moreView.hidden = NO;

    }else {
        [self.moreBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        self.moreView.hidden = YES;

    }
}

- (void)refreshViews
{
    self.sectionBar.nomarlTextColor = [UIColor colorWithHexString:@"#333333"];
    self.sectionBar.selectedTextColor = [UIColor colorWithHexString:@"#f33550"];
    self.menuWidth = kScreenWidth - 30;
    self.menuHeight = 44.f;
    
    _sectionBar.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.menuWidth, self.menuHeight-1);
    [self.view addSubview:_sectionBar];
    
    _lineView.frame = CGRectMake(0, _sectionBar.bottom, kScreenWidth, 1);
    [self.view addSubview:_lineView];
    
    _pagingView.frame = CGRectMake(self.view.bounds.origin.x, _lineView.bottom, kScreenWidth, self.view.bounds.size.height - self.sectionBar.frame.size.height-1);
    [self.view insertSubview:_pagingView belowSubview:_sectionBar];
    [self.view insertSubview:self.moreView aboveSubview:self.view];
    [self.view insertSubview:self.moreBtn aboveSubview:_sectionBar];
    [self.view insertSubview:self.linView aboveSubview:self.view];

    [_pagingView reloadPages];
    _sectionBar.titles = self.menuTitles;
    
}

#pragma mark - Override Methods

- (UIViewController *)contentViewForPage:(ZWSPage *)page atIndex:(NSInteger)index
{
    // subclass could override
    return nil;
}

#pragma mark - ZWSPagingViewDataSource

- (NSUInteger)numberOfPagesInPagingView:(ZWSPagingView *)pagingView {
    return [[self menuTitles] count];
}

- (ZWSPage *)pagingView:(ZWSPagingView *)pagingView pageForIndex:(NSUInteger)index {
    ZWSPage *page = [pagingView dequeueReusablePage];
    if (!page) {
        page = [ZWSPage new];
    }
    
    return page;
}

#pragma mark - ZWSPagingViewDelegate

- (void)pagingView:(ZWSPagingView *)pagingView didRemovePage:(ZWSPage *)page {
    if (pagingView.centerPage != page) {
        return;
    }
}

- (void)pagingView:(ZWSPagingView *)pagingView willMoveToPage:(ZWSPage *)page {
    if (![self.moreView isHidden]) {
        [self hideMoreView:YES];
        isShow = NO;
    }
    page.contentView = [self contentViewForPage:(ZWSPage *)page atIndex:[pagingView indexOfPage:page]].view;
}

- (void)pagingView:(ZWSPagingView *)pagingView didMoveToPage:(ZWSPage *)page {

}

- (void)pagingViewLayoutChanged:(ZWSPagingView *)pagingView {
    if (self.useTransform3DEffects) {
        [self transform3DEffects:pagingView];
    }
    
    [_sectionBar moveToMenuAtFloatIndex:pagingView.floatIndex animated:YES];
}

#pragma mark - ZWSSectionBarDelegate

- (void)sectionBar:(ZWSSectionBar *)sectionBar didSelectAtInedx:(NSUInteger)index
{
    [_pagingView moveToPageAtFloatIndex:index animated:NO];
}

- (void)didCreateItemView:(UIView *)itemView
{
    
}

#pragma mark - must methods

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    UILabel *label=(UILabel*)recognizer.view;
    long index = label.tag-MVLableTag;

    [self.pagingView moveToPageAtFloatIndex:index animated:NO];
    
    [self hideMoreView:YES];
    isShow = NO;
}

-(void)configMoreView
{
    int index = 0;
    int i = 0, j = 0;
    UIColor *textColor = [UIColor colorWithHexString:@"#333333"];
    UIColor *textBorderColor = [UIColor colorWithHexString:@"#999999"];
    CGFloat tmpWidth = MVSidePadding;
    CGFloat moreViewHeight = 0.f;
    for (CategoryListDTO *dto in self.menuTitles) {
        NSString *str = dto.categName;
        ZWSMenuLabel *item = [ZWSMenuLabel new];
        if (dto.labelId.integerValue == 3) {
            item.tagImage.image = [UIImage imageNamed:@"new"];
        }else if (dto.labelId.integerValue == 4) {
            item.tagImage.image = [UIImage imageNamed:@"hot"];
        }
        item.textColor = [UIColor whiteColor];
        item.font = [UIFont systemFontOfSize:12];
        item.backgroundColor = [UIColor clearColor];
        item.text = str;
        item.tag = MVLableTag + index;
        item.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        item.layer.borderColor = textBorderColor.CGColor;
        item.layer.borderWidth = 0.5f;
        item.layer.cornerRadius = 2;
        item.textColor = textColor;
        item.textAlignment = NSTextAlignmentCenter;
        [item addGestureRecognizer:labelTapGestureRecognizer];
        
        CGFloat height = (25);
        CGFloat width = (60);
        if (tmpWidth + width > kScreenWidth) {
            i = 0;
            tmpWidth = MVSidePadding;
            j++;
        }
        moreViewHeight = MVSideHeightPadding  + (height *j)+ (MVCenterHeightPadding *j);
        if (i == 0) {
            item.frame = CGRectMake(MVSidePadding, moreViewHeight, width, height);
        }else {
            item.frame = CGRectMake(tmpWidth, moreViewHeight, width, height);
        }
        item.tagImage.center = CGPointMake(item.right - (CGRectGetWidth(item.tagImage.frame)/2), item.top + (CGRectGetHeight(item.tagImage.frame)/2));

        tmpWidth += width + MVCentPadding;
        
        [self.moreView addSubview:item];
        [self.moreView insertSubview:item.tagImage aboveSubview:item];

        i++;
        index++;
        moreViewHeight += height;
    }
    moreViewHeight += MVSideHeightPadding;
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, moreViewHeight, kScreenWidth, 1)];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.moreView addSubview:bottomLine];
    self.moreView.frame = CGRectMake(0, self.sectionBar.bottom+1, kScreenWidth, moreViewHeight+1+1);
    [self.view bringSubviewToFront:self.moreView];
}

#pragma mark - Private Methods

- (void)transform3DEffects:(ZWSPagingView *)pagingView
{
    CGFloat ratio = .0, scale;
    for (ZWSPage *page in pagingView.visiblePages) {
        ratio = [pagingView widthInSight:page] / CGRectGetWidth(page.frame);
        scale = .9 + ratio * .1;
        
        CATransform3D t = CATransform3DMakeScale(scale, scale, scale);
        
        page.layer.transform = t;
    }
}


@end