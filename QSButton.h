//
//  QSButton.h
//  Taker
//
//  Created by qws on 2018/6/5.
//  Copyright © 2018年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonLayoutStyle) {
    ButtonLayoutStyleTitleOnly = 0,  //只有文字
    ButtonLayoutStyleImageOnly,      //只有图片
    ButtonLayoutStyleTitleHL,        //文字图片水平排列，文字在左
    ButtonLayoutStyleTitleHR,        //文字图片水平排列，文字在右
    ButtonLayoutStyleTitleVT,        //文字图片垂直排列，文字在上
    ButtonLayoutStyleTitleVB,        //文字图片垂直排列，文字在下
};

@interface QSButton : UIButton
@property (nonatomic, assign) ButtonLayoutStyle layoutStyle; // 布局样式
@property (nonatomic, assign) CGFloat hSpace; //水平间距 默认5
@property (nonatomic, assign) CGFloat vSpace; //垂直间距 默认5
@property (nonatomic, assign) BOOL lockWidth; //锁定宽度 暂未实现
@property (nonatomic, assign) BOOL lockHeight;//锁定高度 暂未实现
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView; //菊花，开始转动会隐藏图片和文字，停止显示

- (instancetype)initWithFrame:(CGRect)frame; //ButtonLayoutStyleTitleOnly
- (instancetype)initWithFrame:(CGRect)frame withStyle:(ButtonLayoutStyle)style;

- (void)setName:(NSString *)title andImage:(UIImage *)image; //设置图片和文字
- (void)setUseableStyle:(BOOL)enable;  //是否可以点击
- (void)useHighLightStyle:(BOOL)highLightStyle; //是否高亮模式

- (void)startIndicatorAnimation; //开始菊花动画
- (void)stopIndicatorAnimation;  //停止菊花动画

@end
