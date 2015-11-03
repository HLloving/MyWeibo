//
//  BaseTabBarController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavgationController.h"
#import "Commen.h"
#import "ThemeImageView.h"
#import "ThemeButton.h"
@interface BaseTabBarController ()
{
    ThemeImageView *_selectImage;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatNavgation];
    [self _creatTabBar];
    // Do any additional setup after loading the view.
}

-(void)_creatNavgation{

    NSArray *names = @[@"HomeStoryboard",
                       @"DiscoverStoryboard",
                       @"MessageStoryboard",
                       @"ProfileStoryboard",
                       @"MoreStoryboard"];
    
    NSMutableArray *navArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:names[i] bundle:nil];
        
       BaseNavgationController *navControll = [storyboard instantiateInitialViewController];
        
        [navArray addObject:navControll];
    }
    
    self.viewControllers = navArray;

}

-(void)_creatTabBar{
    
    for (UIView *view in self.tabBar.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
    }
    CGFloat width = kScreenWidth/5;
    //背景视图
   ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
//    bgImageView.image = [UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    bgImageView.imageName =@"mask_navbar.png";
    [self.tabBar addSubview:bgImageView];
    
    //选中图片
    _selectImage = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, width, 49)];
    _selectImage.imageName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectImage];
    
    //创建button
    NSArray *imageNames = @[@"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png"];
    for (int i = 0; i < 5; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 49)];
//        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        button.norlmaImageName = imageNames[i];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+100;
        [self.tabBar addSubview:button];
    }

}

-(void)buttonAction:(UIButton *)btn{
    NSInteger index = btn.tag-100;
    self.selectedIndex = index;
    [UIView animateWithDuration:0.3 animations:^{
        _selectImage.center = btn.center;
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
