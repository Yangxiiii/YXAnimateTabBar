//
//  YXTabBar.m
//  YXAnimatedTabBarDemo
//
//  Created by YangXiiiii on 2018/9/3.
//  Copyright © 2018年 MyOrganization. All rights reserved.
//

#import "YXTabBar.h"
#import "Masonry.h"

//MARK: - ----------YXTabBarItem----------
@implementation YXTabBarItem

- (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle {
    YXTabBarBounceAnimation *animation = [YXTabBarBounceAnimation new];
    return [self initWithImage:image selectedImage:selectedImage title:title selectedTitle:selectedTitle fontSize:10 padding:UIEdgeInsetsMake(10, 0, 0, 0) imageH:24 titleTop:5 animation:animation normalColor:[UIColor grayColor] selectedColor:[UIColor blackColor] imageRenderTemplate:NO];
}

- (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
          imageRenderTemplate:(BOOL)imageRenderTemplate {
    YXTabBarBounceAnimation *animation = [YXTabBarBounceAnimation new];
    return [self initWithImage:image selectedImage:selectedImage title:title selectedTitle:selectedTitle fontSize:10 padding:UIEdgeInsetsMake(10, 0, 0, 0) imageH:24 titleTop:5 animation:animation normalColor:normalColor selectedColor:selectedColor imageRenderTemplate:imageRenderTemplate];
}

- (instancetype)initWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
                    animation:(YXTabBarAnimation *)animation
          imageRenderTemplate:(BOOL)imageRenderTemplate {
    return [self initWithImage:image selectedImage:selectedImage title:title selectedTitle:selectedTitle fontSize:10 padding:UIEdgeInsetsMake(10, 0, 0, 0) imageH:24 titleTop:5 animation:animation normalColor:normalColor selectedColor:selectedColor imageRenderTemplate:imageRenderTemplate];
}

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
          imageRenderTemplate:(BOOL)imageRenderTemplate {
    if (self = [super init]) {
        _imageName = image;
        _selectImageName = selectedImage;
        _title = title;
        _selectedTitle = selectedTitle;
        _fontSize = fontSize;
        _padding = padding;
        _imageH = imageH;
        _titleTop = titleTop;
        _animation = animation;
        _normalColor = normalColor;
        _selectedColor = selectedColor;
        _imageRenderTemplate = imageRenderTemplate;
    }
    return self;
}



@end

//MARK: - ----------YXTabBarButton----------

@interface YXTabBarButton()

@property (nonatomic, assign) UIEdgeInsets padding; //内边距 默认 UIEdgeInsetsZero
@property (nonatomic, assign) CGFloat imageH;       //图片高度 默认27
@property (nonatomic, assign) CGFloat titleTop;     //文字距离上部图片的距离 默认5
@property (nonatomic, strong) YXTabBarAnimation *animation;//动画属性
@property (nonatomic, strong) UILabel *badgeLabel;  //红色小气泡
@property (nonatomic, strong) UIView *popView;

@end

@implementation YXTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
                      padding:(UIEdgeInsets)padding
                       imageH:(CGFloat)imageH
                     titleTop:(CGFloat)titleTop
                        image:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                    animation:(YXTabBarAnimation *)animation
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
                         font:(CGFloat)fontSize
          imageRenderTemplate:(BOOL)imageRenderTemplate {
    if (self = [super initWithFrame:frame]) {
        _padding = padding;
        _imageH = imageH;
        _titleTop = titleTop;
        _animation = animation;
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:selectedTitle forState:UIControlStateDisabled];
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        UIImage *selImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:imageRenderTemplate ? UIImageRenderingModeAlwaysTemplate : UIImageRenderingModeAlwaysOriginal];
        if (imageRenderTemplate) {
            self.imageView.tintColor = selectedColor;
        }
        [self setImage:selImage forState:UIControlStateDisabled];
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        [self setTitleColor:selectedColor forState:UIControlStateDisabled];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        
        //添加红色小气泡
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _popView = [[UIView alloc] init];
        _popView.backgroundColor = [UIColor redColor];
        [self addSubview:_popView];
        [self addSubview:_badgeLabel];
        [_badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        [_popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.badgeLabel.mas_height);
            make.left.equalTo(self.badgeLabel.mas_left).offset(-5);
            make.right.equalTo(self.badgeLabel.mas_right).offset(5);
            make.centerY.equalTo(self.badgeLabel.mas_centerY);
        }];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //图片居中
    CGRect imageFrame = self.imageView.frame;
    imageFrame.size.width = _imageH;
    imageFrame.size.height = _imageH;
    imageFrame.origin.y = _padding.top;
    imageFrame.origin.x = (self.bounds.size.width - _imageH)/2;
    self.imageView.frame = imageFrame;
    
    //文字居中
    [self.titleLabel sizeToFit];
    CGPoint textCenter = self.titleLabel.center;
    textCenter.x = self.bounds.size.width/2;
    textCenter.y = CGRectGetMaxY(self.imageView.frame)+_titleTop+CGRectGetHeight(self.titleLabel.frame)/2;
    self.titleLabel.center = textCenter;
    
    self.popView.layer.cornerRadius = self.popView.frame.size.height/2;
    
}

- (void)playAnimation {
    [self.animation playAnimationWithIcon:self.imageView title:self.titleLabel];
}

- (void)playDeselectAnimation {
    [self.animation playDeselectAnimationWithIcon:self.imageView title:self.titleLabel];
}

@end

//MARK: - ----------YXTabBar----------
@implementation YXTabBar

- (void)setItemsAry:(NSArray<YXTabBarItem *> *)itemsAry {
    if (!itemsAry.count) {
        return;
    }
    //初始化内部控件
    CGFloat itemW = SWidth/itemsAry.count;
    for (int i = 0; i < itemsAry.count; i++) {
        YXTabBarItem *item = itemsAry[i];
        CGFloat itemX = i*itemW;
        YXTabBarButton *tabBtn = [[YXTabBarButton alloc] initWithFrame:CGRectMake(itemX, 0, itemW, self.bounds.size.height) padding:item.padding imageH:item.imageH titleTop:item.titleTop image:item.imageName selectedImage:item.selectImageName title:item.title selectedTitle:item.selectedTitle animation:item.animation normalColor:item.normalColor selectedColor:item.selectedColor font:item.fontSize imageRenderTemplate:item.imageRenderTemplate];
        [tabBtn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        tabBtn.tag = 100+i;
        [self addSubview:tabBtn];
    }
    //默认选中第一个
    self.index = 0;
}

- (void)setBadgeValue:(NSString *)badgeV index:(NSInteger)index {
    YXTabBarButton *btn = [self viewWithTag:index+100];
    if (badgeV.length >=3) {
        badgeV = @"···";
    }
    btn.badgeLabel.text = badgeV;
}

- (void)tabBarBtnClick:(YXTabBarButton *)sender {
    self.index = sender.tag-100;
    if (_selectedIndex) {
        self.selectedIndex(sender.tag-100);
    }
}

- (void)setIndex:(NSInteger)index {
    YXTabBarButton *btn = [self viewWithTag:_index+100];
    btn.enabled = YES;
    [btn playDeselectAnimation];
    YXTabBarButton *btn2 = [self viewWithTag:index+100];
    [btn2 playAnimation];
    btn2.enabled = NO;
    _index = index;
}

@end
