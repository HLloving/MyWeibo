//
//  ThemeManager.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/9.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager
+(ThemeManager *)shareInstance{
    static ThemeManager *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;

}
-(instancetype)init{
    self = [super init];
    if (self) {
        
        //如果没有则用默认
        _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeKey];
        if (_themeName.length == 0) {
            
            _themeName = @"Cat";
        
        }
        
        //获取plist文件路径
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        
        //读取plist文件
        _themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
        //读取颜色配置
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfing = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return self;
}
-(void)setThemeName:(NSString *)themeName{
    if (![_themeName isEqualToString:themeName]) {
        _themeName = themeName;
        
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotificationName object:nil];
        
        //写入本地
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfing = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }

}

-(UIColor *)getThemeColor:(NSString *)colorName{
    if (colorName.length == 0) {
        return nil;
    }
    NSDictionary *rgbDic = [_colorConfing objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    
    CGFloat alpha = 1;
    if (rgbDic[@"alpha" ] != nil) {
        alpha = [rgbDic[@"alpha"] floatValue];
    }
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    return color;
}

-(UIImage *)getThemeImage:(NSString *)imageName{

    //得到图片路径
    //得到主题包路径
    NSString *themePath = [self themePath];
    
    //拼接图片路径
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    
    //读取图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;

}
-(NSString *)themePath{

    //获取主题包根路径
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
   
    //当前主题包的路径
    NSString *thmePath = [self.themeConfig objectForKey:self.themeName];
   
    //完整路径
    NSString *path = [bundlePath stringByAppendingPathComponent:thmePath];
    
    return path;

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
