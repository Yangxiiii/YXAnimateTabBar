//
//  YXTabBar.h
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/3.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXTabBarAnimation.h"

#define SHeight [UIScreen mainScreen].bounds.size.height    //屏幕高
#define SWidth [UIScreen mainScreen].bounds.size.width      //屏幕宽

@interface YXTabBarItem : NSObject

@property (nonatomic, copy) NSString *imageName;            //未选中图片名字
@property (nonatomic, copy) NSString *selectImageName;      //选中图片名字
@property (nonatomic, copy) NSString *title;                //未选中标题
@property (nonatomic, copy) NSString *selectedTitle;        //选中标题
@property (nonatomic, assign) CGFloat fontSize;             //字体大小 默认 10
@property (nonatomic, assign) UIEdgeInsets padding;         //内边距 默认 top 5
@property (nonatomic, assign) CGFloat imageH;               //图片高度 默认27
@property (nonatomic, assign) CGFloat titleTop;             //文字距离上部图片的距离 默认5
@property (nonatomic, strong) UIColor *normalColor;         //默认颜色 默认灰色
@property (nonatomic, strong) UIColor *selectedColor;       //选中颜色 默认黑色
@property (nonatomic, strong) YXTabBarAnimation *animation; //动画效果
@property (nonatomic, assign) BOOL imageRenderTemplate;     //图片是否需要根据文字颜色渲染 默认不渲染

/**
 简单初始化定制 默认bounce动画 图片不渲染

 @param image 未选中图片
 @param selectedImage 选中图片
 @param title 未选中文字
 @param selectedTitle 选中文字
 @return return value
 */
- (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle;

/**
 简单初始化定制 默认bounce动画 (自定义图片渲染)

 @param image 未选中图片
 @param selectedImage 选中图片
 @param title 未选中文字
 @param selectedTitle 选中文字
 @param normalColor 未选中颜色
 @param selectedColor 选中颜色
 @param imageRenderTemplate 图片是否渲染
 @return return value
 */
- (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
          imageRenderTemplate:(BOOL)imageRenderTemplate;

/**
 简单初始化定制 (自定义动画和图片渲染)

 @param image 未选中图片
 @param selectedImage 选中图片
 @param title 未选中标题
 @param selectedTitle 选中标题
 @param normalColor 为选中颜色
 @param selectedColor 选中颜色
 @param animation 选中动画
 @param imageRenderTemplate 图片是否渲染
 @return return value
 */
- (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
                    animation:(YXTabBarAnimation *)animation
          imageRenderTemplate:(BOOL)imageRenderTemplate;

/**
 详细初始化定制

 @param image 未选中图片
 @param selectedImage 选中图片
 @param title 未选中文字
 @param selectedTitle 选中文字
 @param fontSize 文字字号
 @param padding 内边距
 @param imageH 图片高度
 @param titleTop 文字距离图片距离
 @param animation 动画效果
 @param normalColor 未选中文字颜色
 @param selectedColor 选中文字颜色
 @param imageRenderTemplate 图片是否根据文字颜色渲染
 @return 返回值
 */
- (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                     fontSize:(CGFloat)fontSize
                      padding:(UIEdgeInsets)padding
                       imageH:(CGFloat)imageH
                     titleTop:(CGFloat)titleTop
                    animation:(YXTabBarAnimation *)animation
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
          imageRenderTemplate:(BOOL)imageRenderTemplate;

@end

//MARK: - ----------YXTabBarButton----------
@interface YXTabBarButton : UIButton
@end

//MARK: - ----------YXTabBar----------
@interface YXTabBar : UITabBar

@property (nonatomic, copy) void(^selectedIndex)(NSInteger index);  //选中回调
@property (nonatomic, strong) NSArray <YXTabBarItem *>*itemsAry;    //元素数组
@property (nonatomic, assign) NSInteger index;                      //选中下标

//设置角标 (直接用 viewcontroller的badgeValue属性即可)
- (void)setBadgeValue:(NSString *)badgeV index:(NSInteger)index;

@end
