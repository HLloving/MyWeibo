//
//  ProfileViewController.h
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface ProfileViewController : BaseViewController<SinaWeiboRequestDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UILabel *instroductionLabel;

@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (weak, nonatomic) IBOutlet UILabel *attentionNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *fansButton;
@property (weak, nonatomic) IBOutlet UILabel *fansNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *materialButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
