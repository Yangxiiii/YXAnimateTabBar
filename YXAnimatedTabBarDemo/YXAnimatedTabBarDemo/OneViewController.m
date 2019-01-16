//
//  OneViewController.m
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/7.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import "OneViewController.h"
#import "UIViewController+BadgeValue.h"

@interface OneViewController ()
@property (nonatomic, assign) NSInteger badge;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    _badge = 0;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    [btn setTitle:@"badge" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *hideBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 100, 50)];
    [hideBtn setTitle:@"hideBadge" forState:UIControlStateNormal];
    [self.view addSubview:hideBtn];
    [hideBtn addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hideBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)btnClick {
    _badge++;
    self.badgeValue = [NSString stringWithFormat:@"%ld",_badge];
}

- (void)hideClick {
    self.badgeValue = @"";
}


@end
