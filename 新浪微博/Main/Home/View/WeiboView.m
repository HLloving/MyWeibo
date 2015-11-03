//
//  WeiboView.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/12.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"
@implementation WeiboView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self _createSubView];
    }
    return  self;
    
}
- (void)_createSubView{
    _textLabel.backgroundColor = [UIColor redColor];
    _sourceLabel.backgroundColor = [UIColor yellowColor];
    
    
    //1 微博内容
    _textLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _textLabel.wxLabelDelegate = self;
    _textLabel.linespace = 5;
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    [self addSubview:_textLabel];
    
    //2 原微博内容
    _sourceLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.wxLabelDelegate =self;
    _sourceLabel.linespace = 5;
    _sourceLabel.font = [UIFont systemFontOfSize:14];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    
    [self addSubview:_sourceLabel];
    _imgView = [[UIImageView alloc] init];
    _bgImageView = [[ThemeImageView alloc] init];
    
    
    [self addSubview:_bgImageView];
    [self addSubview:_textLabel];
    [self addSubview:_sourceLabel];
    [self addSubview:_imgView];
    
}

- (void)setLayout:(WeiboViewFrameLayout *)layout{
    if (_layout  != layout) {
        _layout = layout;
        
        [self setNeedsLayout];
        
    }
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    WeiboModel *model = _layout.model;
    
    //微博文字
    _textLabel.frame = _layout.textFrame;
    _textLabel.text = model.text;
//    NSLog(@"%@",model.reWeiboModel);
    if (model.reWeiboModel != nil) {//有转发
        
        _bgImageView.hidden = NO;
        _sourceLabel.hidden = NO;
        //被转发的微博
        _sourceLabel.frame = _layout.srTextFrame;
        _sourceLabel.text = model.reWeiboModel.text;
        
        
        //背景图片
        _bgImageView.frame = _layout.bgImageFrame;
        _bgImageView.leftCapWidth = 30;
        _bgImageView.topCapWidth = 30;
        _bgImageView.imageName = @"timeline_rt_border_9.png";
        
        
        //图片
        NSString *imageStr = model.reWeiboModel.thumbnailImage;
        if (imageStr == nil) {
            _imgView.hidden = YES;
        }else{
            _imgView.hidden = NO;
            _imgView.frame = _layout.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
            
        }
        
    }else{ //没转发
        _bgImageView.hidden = YES;
        _sourceLabel.hidden = YES;
        
        //图片
        NSString *imageStr = model.thumbnailImage;
        if (imageStr == nil) {
            _imgView.hidden = YES;
        }else{
            _imgView.hidden = NO;
            _imgView.frame = _layout.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
            
        }
        
    }
    
    
}
#pragma mark - WXLabelDelegate


//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    // https://www.baidu.com/hello/jlasjdlf/1.json
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}


//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{
    
    return [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{
    return  [UIColor blueColor];
}

- (void)toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context{

    NSLog(@"点击了");

}


#pragma mark - 主题切换通知
- (void)themeDidChange:(NSNotification *)notification{
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
