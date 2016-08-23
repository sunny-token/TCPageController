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
    self.title = @"分页界面";
}

- (void)loadData
{
    //在这初始化数据
    if (self.menuTitles.count == 0) {
        for (int i = 0; i < 10; i++) {
            CategoryListDTO *allDto = [[CategoryListDTO alloc] init];
            allDto.categName = [NSString stringWithFormat:@"第%d页", i];
            [self.menuTitles addObject:allDto];
        }
    }
}

#pragma mark - ZWSPagingViewDataSource
- (UIViewController *)contentViewForPage:(ZWSPage *)page atIndex:(NSInteger)index
{
    UIViewController *view = nil;
    NSString *indexStr = [NSString stringWithFormat:@"%ld", (long)index];
    if (![self.viewDic objectForKey:indexStr]) {
        view = [[UIViewController alloc] init];
        view.view.backgroundColor = [UIColor colorWithRed:((arc4random()%255)/255.0) green:((arc4random()%255)/255.0) blue:((arc4random()%255)/255.0) alpha:1.0];
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
