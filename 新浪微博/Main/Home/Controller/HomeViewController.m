//
//  HomeViewController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "WeiboTableView.h"
#import "WeiboModel.h"
#import "WeiboViewFrameLayout.h"
@interface HomeViewController ()
{
    WeiboTableView *_tableView;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    
    _tableView = [[WeiboTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaWeibo =  appDelegate.sinaWeibo;
    
    [sinaWeibo requestWithURL:@"statuses/public_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
    
    // Do any additional setup after loading the view.
}
//- (IBAction)loginAction:(UIButton *)sender {
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    SinaWeibo *sinaWeibo =  appDelegate.sinaWeibo;
//    [sinaWeibo logIn];
//}
//- (IBAction)logout:(UIButton *)sender {
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    SinaWeibo *sinaWeibo =  appDelegate.sinaWeibo;
//    [sinaWeibo logOut];
//}
//- (IBAction)getWeiBo:(UIButton *)sender {
//    
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    SinaWeibo *sinaWeibo =  appDelegate.sinaWeibo;
//   
//    [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
//                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
//                   httpMethod:@"GET"
//                     delegate:self];
//   
//}
//- (IBAction)changeTheme:(UIButton *)sender {
//    ThemeManager *manager = [ThemeManager shareInstance];
//    
//    
//        
//    manager.themeName = @"Mr.O";
//    
//}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"错误%@",error);
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSArray *statusesArray = [result objectForKey:@"statuses"];
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in statusesArray) {
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dic];
        WeiboViewFrameLayout *layout = [[WeiboViewFrameLayout alloc] init];
        layout.model = model;
        
        [modelArray addObject:layout];

    }
    _tableView.dataArray = modelArray;
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
