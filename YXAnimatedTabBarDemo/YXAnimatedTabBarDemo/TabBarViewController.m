//
//  TabBarViewController.m
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/3.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import "TabBarViewController.h"
#import "YXTabBar.h"
#import "ViewController.h"
#import "OneViewController.h"

@interface TabBarViewController ()
@property (nonatomic, strong) YXTabBar *myTabBar;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTabBar = [[YXTabBar alloc] initWithFrame:CGRectMake(0, 0, SWidth, 49)];
    [self setValue:_myTabBar forKey:@"tabBar"];
    [self addChildVc];
    __weak typeof(self) weakSelf = self;
    _myTabBar.selectedIndex = ^(NSInteger index) {
        NSLog(@"%ld",index);
        weakSelf.selectedIndex = index;
    };
}

- (void)addChildVc {
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        UIViewController *vc;
        if (i == 0) {
            vc = [[OneViewController alloc] init];
        } else {
            vc = [[ViewController alloc] init];
            ViewController *tempVc = (ViewController *)vc;
            tempVc.testTitle = [NSString stringWithFormat:@"界面%d",i];
        }
        UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
        YXTabBarItem *item;
        if (i == 0) {
            item = [[YXTabBarItem alloc] initWithImage:@"tab_show_h_account" selectedImage:@"tab_show_h_account" title:@"首页" selectedTitle:@"item0s"];
        } else if (i == 1) {
            YXTabBarRotationAnimation *animation = [YXTabBarRotationAnimation new];
            animation.rotationDirection = RotationDirectionLeft;
            item = [[YXTabBarItem alloc] initWithImage:@"tab_show_h_apps" selectedImage:@"tab_show_h_apps" title:@"item1" selectedTitle:@"item1s" normalColor:[UIColor grayColor] selectedColor:[UIColor redColor] animation:animation imageRenderTemplate:YES];
        } else if (i == 2) {
            YXTabBarTranstionAnimation *animation = [YXTabBarTranstionAnimation new];
            animation.transtionDirection = TranstionDirectionUp;
            item = [[YXTabBarItem alloc] initWithImage:@"icon_pin_00160" selectedImage:@"icon_pin_00160" title:@"item2" selectedTitle:@"item2s" normalColor:[UIColor grayColor] selectedColor:[UIColor redColor] animation:animation imageRenderTemplate:YES];
        } else if (i == 3) {
            YXTabBarFumeAnimation *animation = [YXTabBarFumeAnimation new];
            item = [[YXTabBarItem alloc] initWithImage:@"tab_show_h_wealth" selectedImage:@"tab_show_h_wealth" title:@"item3" selectedTitle:@"item3s" normalColor:[UIColor grayColor] selectedColor:[UIColor redColor] animation:animation imageRenderTemplate:NO];
        } else {
            YXTabBarFrameAnimation *animation = [YXTabBarFrameAnimation new];
            NSArray *imageAry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ToolsAnimation" ofType:@"plist"]];
            animation.imageArray = imageAry;
            item = [[YXTabBarItem alloc] initWithImage:imageAry[0] selectedImage:imageAry.lastObject title:@"item4" selectedTitle:@"item4s" fontSize:10 padding:UIEdgeInsetsMake(10, 0, 0, 0) imageH:30 titleTop:0 animation:animation normalColor:[UIColor grayColor] selectedColor:[UIColor blackColor] imageRenderTemplate:YES];
        }
        [itemArray addObject:item];
        [array addObject:navVc];
    }
    self.viewControllers = array;
    _myTabBar.itemsAry = itemArray;
}

@end
