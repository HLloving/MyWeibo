//
//  ThemeTableViewController.h
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/9.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ThemeNameBlock)(NSString *);
@interface ThemeTableViewController : UITableViewController
@property(nonatomic, copy)ThemeNameBlock themeBlock;
@end
