//
//  MoreViewController.h
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic, copy)NSString *themeName;
@end
