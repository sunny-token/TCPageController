//
//  UIButton+TapScope.h
//  SuningSummer
//
//  Created by snping on 14-8-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TapScope)

/**
 *  扩大按钮的点击范围（insets必须不超过button的superview范围,否者超出范围的不起作用）
 */
@property(nonatomic, assign) UIEdgeInsets hitEdgeInsets;


@end
