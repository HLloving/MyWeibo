//
//  BaseNavgationController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "BaseNavgationController.h"
#import "ThemeManager.h"
@interface BaseNavgationController ()

@end

@implementation BaseNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
    
}
//当XIB创建出来对象的时候调用该init方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
        
        
    }
    return self;
    
}

- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadImage];
}

-(void)loadImage{
    ThemeManager *manager = [ThemeManager shareInstance];
    
    //设置导航栏背景图片
    UIImage *naBgImage = [manager getThemeImage:@"mask_titlebar64.png"];
    [self.navigationBar setBackgroundImage:naBgImage forBarMetrics:UIBarMetricsDefault];
   
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    NSDictionary *attrDic = @{NSForegroundColorAttributeName:color};
    
    self.navigationBar.titleTextAttributes = attrDic;

    
    //
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
