//
//  ThemeTableViewController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/9.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "ThemeManager.h"
#import "MoreViewController.h"
#import "ThemeLabel.h"
@interface ThemeTableViewController ()
{
    NSArray *_themeNames;
    NSDictionary *_theme;
}
@end

@implementation ThemeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
    _theme = [NSDictionary dictionaryWithContentsOfFile:configPath];
    _themeNames = [_theme allKeys];
//    self.tableView.backgroundColor = [UIColor clearColor];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^{
         self.tabBarController.tabBar.hidden = NO;
    }];
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.tabBar.hidden = YES;
    }];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _themeNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ThemeLabel *lable = [[ThemeLabel alloc] initWithFrame:CGRectMake(50, 5, 100, 50)];
    cell.backgroundColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_color"];

    lable.text = _themeNames[indexPath.row];
    [cell.contentView addSubview:lable];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    lable.colorName = @"More_Item_Text_color";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeManager *manager = [ThemeManager shareInstance];
    manager.themeName = _themeNames[indexPath.row];
    
    [self.tableView reloadData];
    
    

}

@end
