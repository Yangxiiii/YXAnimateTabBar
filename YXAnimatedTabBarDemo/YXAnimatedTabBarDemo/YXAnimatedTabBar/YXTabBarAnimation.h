//
//  YXTabBarAnimation.h
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/3.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YXTabBarAnimationProtocol <NSObject>

- (void)playAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel;
- (void)playDeselectAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel;

@end

@interface YXTabBarAnimation : NSObject<YXTabBarAnimationProtocol>

@property (nonatomic, assign) NSTimeInterval duration;//持续时间

@end

//MARK: - ----------弹性动画----------
@interface YXTabBarBounceAnimation : YXTabBarAnimation

@end

//MARK: - ----------旋转动画----------
typedef NS_ENUM(NSUInteger, RotationDirection) {
    RotationDirectionLeft,
    RotationDirectionRight,
};
@interface YXTabBarRotationAnimation : YXTabBarAnimation
@property (nonatomic, assign) RotationDirection rotationDirection;
@end

//MARK: - ----------翻转动画----------
typedef NS_ENUM(NSUInteger, TranstionDirection) {
    TranstionDirectionLeft = 1 << 20,
    TranstionDirectionRight = 2 << 20,
    TranstionDirectionUp = 6 << 20,
    TranstionDirectionDown = 7 << 20
};
@interface YXTabBarTranstionAnimation : YXTabBarAnimation
@property (nonatomic, assign) TranstionDirection transtionDirection;
@end

//MARK: - ----------冒出动画----------
@interface YXTabBarFumeAnimation : YXTabBarAnimation
@end

//MARK: - ----------图片数组动画----------
@interface YXTabBarFrameAnimation : YXTabBarAnimation
@property (nonatomic, strong) NSArray *imageArray;
@end
