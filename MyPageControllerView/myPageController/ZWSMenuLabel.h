//
//  ZWSMenuLabel.h
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ZWSMenuLabel : UILabel

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIImageView *tagImage;

- (void)transformColor:(float)progress;

- (void)transformFont:(float)progress;

@end