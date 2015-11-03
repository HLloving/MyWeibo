//
//  WeiboCell.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/12.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"


@implementation WeiboCell

- (void)awakeFromNib {
    //创建微博内容View
//    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
//    [self.contentView addSubview:_weiboView];
    [self _createSubView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)_createSubView{
    self.backgroundColor = [UIColor clearColor];
    _weiboView = [[WeiboView alloc] init];
    [self.contentView addSubview:_weiboView];
    
}

- (void)setLayout:(WeiboViewFrameLayout *)layout{
    if (_layout  != layout) {
        _layout = layout;
        _weiboView.layout = _layout;
        
        [self setNeedsLayout];
        
    }
    
}





- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    WeiboModel *model = _layout.model;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.userModel.profile_image_url]];
    _nickName.text = model.userModel.screen_name;
    NSString *commentCount = [model.commentsCount stringValue];
    _comment.text = [NSString stringWithFormat:@"评论:%@",commentCount];
    
    NSString *repostCount = [model.repostsCount stringValue];
    _rePost.text = [NSString stringWithFormat:@"转发:%@",repostCount];
    
    //05 来源
    _scor.text = model.source;
    
    //06 对weiboView 进行布局 显示
    _weiboView.frame = _layout.frame;
    
    
}

@end
