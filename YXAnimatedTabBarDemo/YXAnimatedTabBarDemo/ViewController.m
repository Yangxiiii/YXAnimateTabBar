//
//  ViewController.m
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/3.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import "ViewController.h"
#import "YXTabBar.h"
#import "UIViewController+BadgeValue.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *TestL;
@property (nonatomic, assign) NSInteger badge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"asdkjhashdkashdkahsasgdaadskahdkajshdkajhksahd";
    [lab setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisVertical];
    [lab setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(200);
        make.height.mas_equalTo(30);
        make.left.greaterThanOrEqualTo(self.view.mas_left).offset(10);
    }];
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blackColor];
    [view1 setContentHuggingPriority:250 forAxis:UILayoutConstraintAxisVertical];
    [view1 setContentHuggingPriority:250 forAxis:UILayoutConstraintAxisHorizontal];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.left.equalTo(lab.mas_right).offset(10);
        make.centerY.equalTo(lab.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-10).with.priorityMedium();
    }];
    
}

- (void)btnClick {
    _badge+=20;
    self.badgeValue = [NSString stringWithFormat:@"%ld",_badge];
}

- (void)hideClick {
    self.badgeValue = @"";
}

- (void)setTestTitle:(NSString *)testTitle {
    _testTitle = testTitle;
    self.TestL.text = testTitle;
    [_TestL sizeToFit];
    _TestL.center = self.view.center;
}

- (UILabel *)TestL {
    if (!_TestL) {
        _TestL = [[UILabel alloc] initWithFrame:CGRectZero];
        _TestL.textColor = [UIColor blackColor];
        [self.view addSubview:_TestL];
    }
    return _TestL;
}

@end
