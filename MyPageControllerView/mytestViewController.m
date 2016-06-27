//
//  mytestViewController.m
//  MyPageControllerView
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 Foucsteach. All rights reserved.
//

#import "mytestViewController.h"


@implementation mytestViewController

#pragma mark property
-(NSMutableDictionary *)viewDic
{
    if (!_viewDic) {
        _viewDic = [[NSMutableDictionary alloc] init];
    }
    return _viewDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)loadData
{
    //在这初始化数据
    if (self.menuTitles.count == 0) {
        for (int i = 0; i < 2; i++) {
            CategoryListDTO *allDto = [[CategoryListDTO alloc] init];
            allDto.categName = [NSString stringWithFormat:@"第%d页", i];
            [self.menuTitles addObject:allDto];
        }
//        [self configMoreView];
    }
}

#pragma mark - ZWSPagingViewDataSource
- (UIViewController *)contentViewForPage:(ZWSPage *)page atIndex:(NSInteger)index
{
    UIViewController *view = nil;
    NSString *indexStr = [NSString stringWithFormat:@"%ld", (long)index];
    if (![self.viewDic objectForKey:indexStr]) {
        view = [[UIViewController alloc] init];
        view.view.backgroundColor = [UIColor yellowColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.frame = CGRectMake(100, 100, 50, 50);
        [btn setTitle:[NSString stringWithFormat:@"%ld",(long)index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view.view addSubview:btn];
        [self.viewDic setObject:view forKey:indexStr];
    }else {
        view = [self.viewDic objectForKey:indexStr];
    }
    
    return view;
}

-(void)hideMyMoreView
{
    [self hideMoreView];
}
#pragma mark - todayChildViewController delegate
-(void)hideMoreView
{
    if (![self.moreView isHidden]) {
        [self hideMoreView:YES];
        isShow = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
