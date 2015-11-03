//
//  ProfileViewController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "ProfileViewController.h"
#import "WeiboModel.h"
#import "WeiboViewFrameLayout.h"
#import "UIImageView+WebCache.h"
#import "WeiboTableView.h"
#import "AppDelegate.h"
@interface ProfileViewController ()
{
    WeiboTableView *_tableView;
    WeiboModel *_model;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 219, self.view.frame.size.width, self.view.frame.size.height-155) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaWeibo =  appDelegate.sinaWeibo;
    
    [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
    
    // Do any additional setup after loading the view.
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"错误%@",error);
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSArray *statusesArray = [result objectForKey:@"statuses"];
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in statusesArray) {
        _model = [[WeiboModel alloc] initWithDataDic:dic];
        WeiboViewFrameLayout *layout = [[WeiboViewFrameLayout alloc] init];
        layout.model = _model;
        
        [modelArray addObject:layout];
        
    }
    [self loadData];
    _tableView.dataArray = modelArray;
    
    [_tableView reloadData];
}

//加载数据
-(void)loadData{
    _nickLabel.text = _model.userModel.screen_name;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url]];
    NSString *cityName = _model.userModel.location;
    NSString *six = _model.userModel.gender;
    if ([six isEqualToString:@"m"]) {
        
        six = @"男";
        
    }else if([six isEqualToString:@"w"]){
        
        six = @"女";
        
    }else{
        
        six =@"未知";
        
    }
    NSString *information = [NSString stringWithFormat:@"%@  %@",six,cityName];
    _informationLabel.text = information;
    _fansNumberLabel.text = [NSString stringWithFormat:@"%@",_model.userModel.followers_count];
    _attentionNumberLabel.text = [NSString stringWithFormat:@"%@",_model.userModel.friends_count];
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
