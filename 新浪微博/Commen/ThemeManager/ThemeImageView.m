//
//  ThemeImageView.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/9.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView

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



-(void)setImageName:(NSString *)imageName{
    if (![_imageName isEqualToString:imageName]) {
        _imageName = [imageName copy];
        [self loadImage];
    }

}
- (void)loadImage{
    //01 得到 管家对象
    
    ThemeManager *manager = [ThemeManager shareInstance];
    
    UIImage *image = [manager getThemeImage:self.imageName];
    UIImage *tempImage =  [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapWidth];

    if (image != nil) {
        self.image = tempImage;
    }
    
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
@end
