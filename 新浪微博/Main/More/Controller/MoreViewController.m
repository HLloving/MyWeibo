//
//  MoreViewController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeImageView.h"
#import "ThemeTableViewController.h"
#import "ThemeManager.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"

@interface MoreViewController ()
{
    NSArray *_titles;
    NSArray *_imageName;
    UITableView *_tableView;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatTabelView];
    _titles = @[@"主题选择",@"账户管理",@"意见反馈",@"登出当前账号"];
    _imageName =@[@"more_icon_theme@2x",@"more_icon_account@2x",@"more_icon_feedback@2x"];

  
}
-(void)_creatTabelView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 370) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 7;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    //移除所有视图

        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    
   
    
    
    
    if (indexPath.row == 1) {
        ThemeLabel *lable = [[ThemeLabel alloc] initWithFrame:CGRectMake(300, 5, 60, 50)];
        lable.text = [ThemeManager shareInstance].themeName;
        lable.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_color"];
        lable.colorName = @"More_Item_Text_color";
        [cell.contentView addSubview:lable];
    }
    if (indexPath.row == 1 || indexPath.row == 2 ) {
        ThemeLabel *lable = [[ThemeLabel alloc] initWithFrame:CGRectMake(50, 5, 100, 50)];
        lable.text = _titles[indexPath.row - 1];
        lable.colorName = @"More_Item_Text_color";
        lable.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_color"];
        ThemeImageView *imageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        imageView.imageName = _imageName[indexPath.row-1];
        
        
        [cell.contentView addSubview:lable];
        [cell.contentView addSubview:imageView];
    }else if(indexPath.row == 4){
        ThemeLabel *lable = [[ThemeLabel alloc] initWithFrame:CGRectMake(50, 5, 100, 50)];
        lable.text = _titles[2];
        lable.colorName = @"More_Item_Text_color";
        lable.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_color"];
        ThemeImageView *imageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        imageView.imageName = _imageName[2];
        [cell.contentView addSubview:lable];
        [cell.contentView addSubview:imageView];
       
    }else if (indexPath.row == 6){
        ThemeLabel *lable = [[ThemeLabel alloc] initWithFrame:CGRectMake(140, 5, 200, 50)];
        lable.text = _titles[3];
        lable.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_color"];
        lable.colorName = @"More_Item_Text_color";
        [cell.contentView addSubview:lable];
    
    }else{
        cell.backgroundColor = [UIColor clearColor];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 1) {
        ThemeTableViewController *theme = [[ThemeTableViewController alloc] init];
        [self.navigationController pushViewController:theme animated:YES];
       
    }
    if (indexPath.row == 6) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        SinaWeibo *sinaWeibo =  appDelegate.sinaWeibo;
        
        //判断是否在登录状态
        if ([sinaWeibo isLoggedIn] == NO) {
            [sinaWeibo logIn];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定登出吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        
        }
        
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
       
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        SinaWeibo *sinaWeibo =  appDelegate.sinaWeibo;
        if ([sinaWeibo isLoggedIn]) {
            
        }
        [sinaWeibo logOut];
        
    }

}
-(void)viewWillAppear:(BOOL)animated{

    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
