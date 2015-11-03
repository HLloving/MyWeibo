//
//  WeiboTableView.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/12.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
@implementation WeiboTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self == [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
//        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"weiboCell"];
        [self registerNib:nib forCellReuseIdentifier:@"weiboCell"];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weiboCell" forIndexPath:indexPath];
    if (_dataArray !=nil) {
        WeiboViewFrameLayout *layout =  _dataArray[indexPath.row];
        
        cell.layout = layout;

    }

    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboViewFrameLayout *layout =  _dataArray[indexPath.row];
    
    return layout.frame.size.height + 100;
}
@end
