//
//  ZWSSectionBar.m
//

#import "ZWSSectionBar.h"

@interface ZWSSectionBar ()

@end

@implementation ZWSSectionBar

@synthesize selectedTextColor = _selectedTextColor;
@synthesize nomarlTextColor = _nomarlTextColor;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _tapGestureRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:_tapGestureRecognizer];

        self.scrollsToTop = NO;
    }

    return self;
}

- (UIColor *)nomarlTextColor
{
    if (!_nomarlTextColor) {
        return [UIColor blueColor];
    }
    return _nomarlTextColor;
}

- (UIColor *)selectedTextColor
{
    if (!_selectedTextColor) {
        return [UIColor yellowColor];
    }
    return _selectedTextColor;
}

- (UIFont *)nomarlTextFont
{
    if (!_nomarlTextFont) {
        return [UIFont systemFontOfSize:15.0f];
    }
    return _nomarlTextFont;
}

- (UIFont *)selectedTextFont
{
    if (!_selectedTextFont) {
        return [UIFont systemFontOfSize:15.0f];
    }
    return _selectedTextFont;
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor = selectedTextColor;
    for (ZWSMenuLabel *item in self.items) {
        item.selectedColor = _selectedTextColor;
    }
}

- (void)setNomarlTextColor:(UIColor *)nomarlTextColor
{
    _nomarlTextColor = nomarlTextColor;
    for (ZWSMenuLabel *item in self.items) {
        item.textColor = _nomarlTextColor;
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:titles.count];

    if ([titles count] > 0) {
        
        for (CategoryListDTO *s in titles) {
            [items addObject:[self itemForTitle:s]];
        }
        
        UIView *iv = [[UIView alloc] initWithFrame:CGRectMake(.0, .0, 2.0, 10.0)];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(.0, 8.0, 2.0, 2.0)];
        iv.userInteractionEnabled = NO;
        lv.backgroundColor = self.selectedTextColor;
        lv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [iv addSubview:lv];
        
        self.items = items;
        self.indicatorView = iv;
    } else {
        self.items = nil;
        self.indicatorView = nil;
    }
}

- (void)setItemSize:(CGSize)itemSize {
    if (CGSizeEqualToSize(itemSize, _itemSize)) {
        return;
    }

    _itemSize = itemSize;

    for (UIView *item in self.items) {
        [self resizeItem:item];
    }
}

- (UIView *)itemForTitle:(CategoryListDTO *)dto {
    NSString *title = [self subStrToNum:dto.categName num:8];

    ZWSMenuLabel *item = [ZWSMenuLabel new];
    if (dto.labelId.integerValue == 3) {
        item.tagImage.image = [UIImage imageNamed:@"new"];
    }else if (dto.labelId.integerValue == 4) {
        item.tagImage.image = [UIImage imageNamed:@"hot"];
    }
    item.selectedColor  = self.selectedTextColor;
    item.textColor = self.nomarlTextColor;
    item.selectedFont = self.selectedTextFont;
    item.font = self.nomarlTextFont;
    item.backgroundColor = [UIColor clearColor];
    item.text = title;
    [self resizeItem:item];
    
    if (self.barDelegate && [self.barDelegate respondsToSelector:@selector(didCreateItemView:)]) {
        [self.barDelegate performSelector:@selector(didCreateItemView:) withObject:item];
    }
    
    return item;
}

- (void)tapped:(UITapGestureRecognizer *)sender {
    NSInteger index = [super indexOfItemContainsPoint:[sender locationInView:self]];
    
    if (![super indexIsValid:index]) {
        return;
    }
    
    if ([_barDelegate respondsToSelector:@selector(sectionBar:didSelectAtInedx:)]) {
        [_barDelegate sectionBar:self didSelectAtInedx:index];
    }
}


#pragma mark - Private
//num:是需要截取第几个，比如四个字符串，是8
- (NSString *)subStrToNum:(NSString *)str num:(NSInteger)num
{
    NSString *subStr;
    NSInteger length = 0;
    for(int i = 0; i < [str length]; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [str substringWithRange:range];
        if(length <= (num-2))
        {
            const char    *cString = [subString UTF8String];
            if (strlen(cString) == 3)
            {
                length = length + 2;
            }
            else
            {
                length = length + 1;
            }
            subStr  = [str substringToIndex:i+1];
            if([subStr length] == num)
            {
                return subStr;
            }
        }
        else if(length == (num+1))
        {
            const char    *cString = [subString UTF8String];
            if (strlen(cString) == 3)
            {
                subStr  = [str substringToIndex:i];
                return subStr;
            }
            else
            {
                subStr  = [str substringToIndex:i+1];
                return subStr;
            }
        }
    }
    return subStr;
}

- (void)resizeItem:(UIView *)item {
    if (CGSizeEqualToSize(self.itemSize, CGSizeZero)) {
        [item sizeToFit];
    } else {
        CGSize size = [item sizeThatFits:self.itemSize];
        size.width = MAX(size.width, self.itemSize.width);
        size.height = MAX(size.height, self.itemSize.height);
        
        item.bounds = (CGRect){CGPointZero, size};
        item.frame = CGRectOffset(item.frame, 12, 0);
    }
}

@end