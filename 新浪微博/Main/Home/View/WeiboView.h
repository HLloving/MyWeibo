//
//  WeiboView.h
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/12.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboModel.h"
#import "WeiboViewFrameLayout.h"
#import "WXLabel.h"
@interface WeiboView : UIView<WXLabelDelegate>


@property (nonatomic,strong)WXLabel *textLabel;//微博文字
@property (nonatomic,strong)WXLabel *sourceLabel;//如果转发则：原微博文字
@property (nonatomic,strong)UIImageView  *imgView;// 微博图片
@property (nonatomic,strong)ThemeImageView *bgImageView;//原微博背景图片

@property (nonatomic,strong)WeiboViewFrameLayout *layout;

@end
