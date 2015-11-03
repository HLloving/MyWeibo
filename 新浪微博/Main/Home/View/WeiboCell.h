//
//  WeiboCell.h
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/12.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewFrameLayout.h"
#import "WeiboView.h"
@interface WeiboCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *rePost;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *scor;

@property (strong,nonatomic) WeiboView *weiboView;

//@property (nonatomic,strong) WeiboModel *model;

@property (nonatomic,strong) WeiboViewFrameLayout *layout;
@end
