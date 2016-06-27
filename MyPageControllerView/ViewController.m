//
//  ViewController.m
//  MyPageControllerView
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 Foucsteach. All rights reserved.
//

#import "ViewController.h"
#import "mytestViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSMutableDictionary *viewDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"go" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(gotoNextView) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)gotoNextView
{
    mytestViewController *testView = [[mytestViewController alloc] init];
    testView.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    [self.navigationController pushViewController:testView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
