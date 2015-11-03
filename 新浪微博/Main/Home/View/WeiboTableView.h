//
//  WeiboTableView.h
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/12.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy)NSArray *dataArray;
@end
