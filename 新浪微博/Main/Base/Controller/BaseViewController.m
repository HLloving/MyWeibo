//
//  BaseViewController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeLabel.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    [self loadImage];

    
    // Do any additional setup after loading the view.
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

    
    //设置背景图片
    UIImage *bgImage = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    //
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置导航栏左右按钮
- (void)setNavItem{

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    
    ThemeButton *leftButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
    leftButton.norlmaImageName = @"group_btn_all_on_title.png";
    [leftButton addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    ThemeImageView *leftImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    leftImageView.imageName = @"button_title.png";
    
    ThemeLabel *leftLable = [[ThemeLabel alloc] initWithFrame:CGRectMake(55, 0, 45, 50)];
    leftLable.colorName = @"More_Item_Text_color";
    leftLable.text = @"设置";
    
   
    [leftImageView addSubview:leftLable];
    [leftImageView addSubview:leftButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftImageView];
    
    
    
    ThemeButton *rightButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    rightButton.norlmaImageName = @"button_icon_plus.png";
    [rightButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    
    ThemeImageView *rightImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    rightImageView.imageName = @"button_m.png";
    
    [rightImageView addSubview:rightButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightImageView];
    
    
}
- (void)setAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)editAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}



@end
