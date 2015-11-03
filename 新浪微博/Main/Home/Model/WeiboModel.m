//
//  WeiboModel.m
//  XSWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"

@implementation WeiboModel


- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}
-(void)setAttributes:(NSDictionary *)dataDic{
    //调用父类方法处理Model数据
    [super setAttributes:dataDic];
    
    if (_source != nil) {
        NSString *regex = @">.+<";
        NSArray *array = [_source componentsMatchedByRegex:regex];
        if (array.count != 0) {
            NSString *str = array[0];
            str = [str substringWithRange:NSMakeRange(1, str.length - 2)];
            _source =[ NSString stringWithFormat:@"来源:%@",str ];
        }
    }
    
    //处理用户
    NSDictionary *userDic = dataDic[@"user"];
    _userModel = [[UserModel alloc] initWithDataDic:userDic];
//    _userModel = [[UserModel alloc] initContentWithDic:userDic];
    
    //被转发的微博
    NSDictionary *reWeiBoDic = [dataDic objectForKey:@"retweeted_status"];
    if (reWeiBoDic != nil) {
        _reWeiboModel = [[WeiboModel alloc] initWithDataDic:reWeiBoDic];
        NSString *name =  _reWeiboModel.userModel.name;
        _reWeiboModel.text = [NSString stringWithFormat:@"@%@:%@",name,_reWeiboModel.text];
    }
    //03 表情处理
    // [兔子]
    // 1.png
    // 这条微博内容[兔子]lsajldjfla
    // 这条微博内容<image url = '1.png'>lsa
    
    //>>01 找到微博中表示表情的字符串  [兔子] [微笑]
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [_text componentsMatchedByRegex:regex];
    
    
    NSLog(@"%@",faceItems);
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for (NSString *faceName in faceItems) {
        
        //faceName=@"[兔子]"  self.chs=@'[兔子]'
        //用谓词过滤
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        
        NSArray *items = [faceConfigArray filteredArrayUsingPredicate:predicate];
        
        if (items.count > 0) {
            NSDictionary *faceDic = items[0];
            NSString *imageName = [faceDic objectForKey:@"png"];
            // <image url = '1.png'>
            
            NSString *replaceString = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            
            //原微博中【兔子】替换成 <image url = '001.png'>
            
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceString];
        }
    }
    
}


@end
