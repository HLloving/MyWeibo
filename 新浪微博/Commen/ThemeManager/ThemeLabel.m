//
//  ThemeLabel.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/10.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
@implementation ThemeLabel
-(instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];


}

- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadColor];
}

-(void)loadColor{
    
    ThemeManager *manager = [ThemeManager shareInstance];
    
    self.textColor = [manager getThemeColor:_colorName];


}
-(void)setColorName:(NSString *)colorName{
    if (![_colorName isEqualToString:colorName]) {
        _colorName = colorName;
        [self loadColor];
    }


}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
