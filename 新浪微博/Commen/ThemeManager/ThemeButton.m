//
//  ThemeButton.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/9.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
        
        
    }
    return self;
    
}

- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadImage];
}

-(void)setNorlmaImageName:(NSString *)norlmaImageName{
    if (![_norlmaImageName isEqualToString:norlmaImageName]) {
        _norlmaImageName = [norlmaImageName copy];
        [self loadImage];
    }

}


- (void)loadImage{
    //01 得到 管家对象
    
    ThemeManager *manager = [ThemeManager shareInstance];
    
    UIImage *normalImage = [manager getThemeImage:self.norlmaImageName];
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
