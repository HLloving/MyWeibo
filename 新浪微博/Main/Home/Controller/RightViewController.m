//
//  RightViewController.m
//  新浪微博
//
//  Created by 黄翔宇 on 15/10/10.
//  Copyright (c) 2015年 黄翔宇. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _creatButton];
}
-(void)_creatButton{
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];
    for (int i = 0; i < imageNames.count; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 70+i*60, 50, 50)];
        button.norlmaImageName = imageNames[i];
        [self.view addSubview:button];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
