//
//  ThemeManager.h
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/9.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNotificationName  @"kThemeDidChangeNotificationName"
#define kThemeKey @"kThemeKey"
@interface ThemeManager : NSObject
@property (nonatomic, copy)NSString *themeName;
@property (nonatomic, copy)NSDictionary *themeConfig;
@property (nonatomic, copy)NSDictionary *colorConfing;
+(ThemeManager *)shareInstance;
- (UIImage *)getThemeImage:(NSString *)imageName;//根据图片名字获得对应主题包下的图片
-(UIColor *)getThemeColor:(NSString *)colorName;
@end
