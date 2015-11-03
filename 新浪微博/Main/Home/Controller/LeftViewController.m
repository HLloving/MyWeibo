//
//  LeftViewController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/10.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeLabel.h"
@interface LeftViewController ()
{
    NSArray *_title;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _title = @[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差",@"小图",@"大图"];
    [self _creatTabelView];
}
-(void)_creatTabelView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 500)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
    
        return 2;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.text = _title[indexPath.row];
        [cell.contentView addSubview:label];
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.text = _title[indexPath.row+5];
        [cell.contentView addSubview:label];
    }
    
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.text = @"界面切换效果";
        label.colorName = @"More_Item_Text_color";
        
        
        return label;
    }else{
        ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.text = @"图片浏览模式";
        label.colorName = @"More_Item_Text_color";
        return label;
    }


}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 80;
}
@end
