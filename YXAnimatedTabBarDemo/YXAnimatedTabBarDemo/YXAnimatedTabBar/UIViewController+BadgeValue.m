//
//  UIViewController+BadgeValue.m
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/7.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import "UIViewController+BadgeValue.h"
#import <objc/runtime.h>
#import "YXTabBar.h"

const char *badgeValueKay = "badgeValueKay";

@implementation UIViewController (BadgeValue)

- (void)setBadgeValue:(NSString *)badgeValue {
    YXTabBar *myTabBar = (YXTabBar *)self.tabBarController.tabBar;
    [myTabBar setBadgeValue:badgeValue index:self.tabBarController.selectedIndex];
    objc_setAssociatedObject(self, badgeValueKay, badgeValue, OBJC_ASSOCIATION_COPY);
}

- (NSString *)badgeValue {
    return objc_getAssociatedObject(self, badgeValueKay);
}

@end
