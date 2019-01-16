//
//  YXTabBarAnimation.m
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/3.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import "YXTabBarAnimation.h"
#import <objc/runtime.h>

CG_INLINE CAKeyframeAnimation *yx_CAKeyframeAnimationRemoved(NSString *key,NSArray *values,NSTimeInterval duration) {
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animationWithKeyPath:key];
    animate.values = values;
    animate.duration = duration;
    animate.fillMode = kCAFillModeRemoved;
    animate.removedOnCompletion = YES;
    return animate;
}
CG_INLINE CAKeyframeAnimation *yx_CAKeyframeAnimationForwards(NSString *key,NSArray *values,NSTimeInterval duration) {
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animationWithKeyPath:key];
    animate.values = values;
    animate.duration = duration;
    animate.fillMode = kCAFillModeForwards;
    animate.removedOnCompletion = NO;
    return animate;
}

@implementation YXTabBarAnimation
- (instancetype)init {
    if (self = [super init]) {
        _duration = 0.5f;
    }
    return self;
}

- (void)playAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    //override method in subclass
}
- (void)playDeselectAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    //override method in subclass
}

@end

//MARK: - ----------弹性动画----------
@implementation YXTabBarBounceAnimation
- (void)playAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    [self showBounceAnimation:imageView];
    
}

- (void)showBounceAnimation:(UIImageView *)imageView {
    CAKeyframeAnimation *animate = yx_CAKeyframeAnimationRemoved(@"transform.scale", @[@1.0, @1.4, @0.9, @1.15, @0.95, @1.02, @1.0], self.duration);
    [imageView.layer addAnimation:animate forKey:nil];
}
@end

//MARK: - ----------旋转动画----------
@implementation YXTabBarRotationAnimation
- (instancetype)init {
    if (self = [super init]) {
        //默认向右旋转
        _rotationDirection = RotationDirectionRight;
    }
    return self;
}

- (void)playAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    [self showRotationAnimation:imageView];
}

- (void)showRotationAnimation:(UIImageView *)imageView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];;
    CGFloat toValue = _rotationDirection == RotationDirectionRight ? M_PI*2 : -M_PI*2;
    animation.fromValue = @(0);
    animation.toValue = @(toValue);
    animation.duration = self.duration;
    [imageView.layer addAnimation:animation forKey:@"YXTabBarRotationAnimation"];
}

@end

//MARK: - ----------翻转动画----------
@implementation YXTabBarTranstionAnimation

- (instancetype)init {
    if (self = [super init]) {
        //默认向左翻转
        _transtionDirection = TranstionDirectionLeft;
    }
    return self;
}

- (void)playAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    [self showTranstionAnimation:imageView];
}

- (void)showTranstionAnimation:(UIImageView *)imageView {
    
    [UIView transitionWithView:imageView duration:self.duration options:(UIViewAnimationOptions)_transtionDirection animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

@end

//MARK: - ----------冒出动画----------
@implementation YXTabBarFumeAnimation

- (void)playAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    [self playIconMoveAnimation:imageView value:@[@(imageView.center.y),@(imageView.center.y+5)]];
    [self playLabelAnimation:titleLabel];
}
- (void)playDeselectAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    [self playIconMoveAnimation:imageView value:@[@(imageView.center.y+5),@(imageView.center.y)]];
    [self playDeselectLableAnimation:titleLabel];
}

- (void)playLabelAnimation:(UILabel *)titleLabel {
    CAKeyframeAnimation *yAnimation = yx_CAKeyframeAnimationRemoved(@"position.y", @[@(titleLabel.center.y),@(titleLabel.center.y-60)], self.duration);
    [titleLabel.layer addAnimation:yAnimation forKey:nil];
    
    CAKeyframeAnimation *scaleAnimation = yx_CAKeyframeAnimationRemoved(@"transform.scale", @[@1,@2], self.duration);
    [titleLabel.layer addAnimation:scaleAnimation forKey:nil];
    
    CAKeyframeAnimation *opacityAnimation = yx_CAKeyframeAnimationForwards(@"opacity", @[@1,@0], self.duration);
    [titleLabel.layer addAnimation:opacityAnimation forKey:nil];
}

- (void)playDeselectLableAnimation:(UILabel *)titleLabel {
    CAKeyframeAnimation *opacityAnimation = yx_CAKeyframeAnimationForwards(@"opacity", @[@0,@1], self.duration);
    [titleLabel.layer addAnimation:opacityAnimation forKey:nil];
    
    CAKeyframeAnimation *yAnimation = yx_CAKeyframeAnimationForwards(@"position.y", @[@(titleLabel.center.y+15),@(titleLabel.center.y)], self.duration);
    [titleLabel.layer addAnimation:yAnimation forKey:nil];
}

- (void)playIconMoveAnimation:(UIImageView *)imageView value:(NSArray *)values {
    CAKeyframeAnimation *animation = yx_CAKeyframeAnimationForwards(@"position.y", values, self.duration/2);
    [imageView.layer addAnimation:animation forKey:nil];
}

@end


//MARK: - ----------图片数组动画----------
@interface YXTabBarFrameAnimation()
@property (nonatomic, strong) NSMutableArray <UIImage *>*allImages;
@end
@implementation YXTabBarFrameAnimation

- (void)playAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    [self showFrameAnimationWithIcon:imageView];
}

- (void)playDeselectAnimationWithIcon:(UIImageView *)imageView title:(UILabel *)titleLabel {
    [self showDeselectedFrameAniamtionWithIcon:imageView];
}

- (void)showFrameAnimationWithIcon:(UIImageView *)imageView {
    CAKeyframeAnimation *animation = yx_CAKeyframeAnimationForwards(@"contents", _allImages, self.duration);
    [imageView.layer addAnimation:animation forKey:nil];
}

- (void)showDeselectedFrameAniamtionWithIcon:(UIImageView *)imageView {
    CAKeyframeAnimation *animation = yx_CAKeyframeAnimationForwards(@"contents", [_allImages reverseObjectEnumerator].allObjects, self.duration);
    [imageView.layer addAnimation:animation forKey:nil];
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    _allImages = [NSMutableArray array];
    for (NSString *imageName in imageArray) {
        CGImageRef image = [UIImage imageNamed:imageName].CGImage;
        [_allImages addObject:(__bridge UIImage * _Nonnull)(image)];
    }
}

@end





