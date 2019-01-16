//
//  QSButton.m
//  Taker
//
//  Created by qws on 2018/6/5.
//  Copyright © 2018年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "QSButton.h"

@interface QSButton()
@property (nonatomic, strong) NSString *currentText;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGSize textSize;
@property (nonatomic, assign) CGRect targetImageRect;
@property (nonatomic, assign) CGRect targetTitleRect;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation QSButton

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withStyle:(ButtonLayoutStyleTitleOnly)];
}

- (instancetype)initWithFrame:(CGRect)frame withStyle:(ButtonLayoutStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layoutStyle = style;
        [self applyDefaultConfigure];
    }
    return self;
}

- (void)applyDefaultConfigure {
    self.backgroundColor = [UIColor clearColor];
    self.tintColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.imageSize = CGSizeZero;
    self.hSpace = 5;
    self.vSpace = 5;
    self.currentText = @"";
}

#pragma mark -
#pragma mark - Public

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self useHighLightStyle:highlighted];
}

- (void)useHighLightStyle:(BOOL)highLightStyle {
    if (highLightStyle) {
        self.alpha = 0.3;
    } else {
        self.alpha = 1;
    }
}

- (void)startIndicatorAnimation {
    if (![self.subviews containsObject:self.indicatorView]) {
        [self addSubview:self.indicatorView];
    }
    self.indicatorView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    self.enabled = NO;
    [self.indicatorView startAnimating];
}

- (void)stopIndicatorAnimation {
    self.enabled = YES;
    [self.indicatorView stopAnimating];
}

/**
 设置禁用/启用模式
 
 @param enable
 */
- (void)setUseableStyle:(BOOL)enable {
    if (self.enabled == enable) {
        return;
    }
    self.enabled = enable;
    if (enable) {
        self.alpha = 1;
    } else {
        self.alpha  = 0.3;
    }
}

/**
 设置标题和图片
 
 @param title 标题
 @param image 图片
 */
- (void)setName:(NSString *)title andImage:(UIImage *)image {
    self.imageSize = image.size;
    self.textSize  = [self getSizeWithText:title font:self.titleLabel.font color:self.titleLabel.textColor];
    self.currentText = title;
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self resetFrame];
}

- (void)setVSpace:(CGFloat)vSpace {
    if (_vSpace == vSpace) {
        return;
    }
    _vSpace = vSpace;
    
    [self resetFrame];
}

- (void)setHSpace:(CGFloat)hSpace {
    if (_hSpace == hSpace) {
        return;
    }
    _hSpace = hSpace;
    [self resetFrame];
}

- (void)setLayoutStyle:(ButtonLayoutStyle)layoutStyle {
    if (_layoutStyle == layoutStyle) {
        return;
    }
    _layoutStyle = layoutStyle;
}

#pragma mark -
#pragma mark - Override

- (void)resetFrame {
    CGFloat width    = self.frame.size.width;
    CGFloat height   = self.frame.size.height;
    CGSize textSize  = self.textSize;
    CGSize imageSize = self.imageSize;
    CGFloat hSpace   = self.hSpace;
    CGFloat vSpace   = self.vSpace;
    switch (self.layoutStyle) {
        case ButtonLayoutStyleTitleOnly:
            width = textSize.width;
            height = textSize.height;
            break;
        case ButtonLayoutStyleImageOnly:
            width = imageSize.width;
            height = imageSize.height;
            break;
        case ButtonLayoutStyleTitleHL:
            width = textSize.width + hSpace + imageSize.width;
            height = MAX(textSize.height, imageSize.height);
            break;
        case ButtonLayoutStyleTitleHR:
            width = textSize.width + hSpace + imageSize.width;
            height = MAX(textSize.height, imageSize.height);
            break;
        case ButtonLayoutStyleTitleVT:
            width = MAX(imageSize.width, textSize.width);
            height = textSize.height + vSpace + imageSize.height;
            break;
        case ButtonLayoutStyleTitleVB:
            width = MAX(imageSize.width, textSize.width);
            height = textSize.height + vSpace + imageSize.height;
            break;
        default:
            break;
    }
    
    CGRect frame = self.frame;
    frame.size.width = width;
    frame.size.height = height;
    self.frame = frame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    [self caculateTitleAndImageRectWithStyle:self.layoutStyle contentRect:contentRect];
    if (self.indicatorView.animating) {
        return CGRectZero;
    } else {
        return self.targetTitleRect;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    [self caculateTitleAndImageRectWithStyle:self.layoutStyle contentRect:contentRect];
    if (self.indicatorView.animating) {
        return CGRectZero;
    } else {
        return self.targetImageRect;
    }
}

/**
 计算图片和文字的渲染Rect
 
 @param style 样式
 @param cRect contentRect
 */
- (void)caculateTitleAndImageRectWithStyle:(ButtonLayoutStyle)style contentRect:(CGRect)cRect {
    CGFloat tX,tY,tW,tH,iX,iY,iW,iH;
    CGSize textSize  = self.textSize;
    CGSize imageSize = self.imageSize;
    CGFloat hSpace   = self.hSpace;
    CGFloat vSpace   = self.vSpace;
    switch (style) {
        case ButtonLayoutStyleTitleOnly:
            //文字居中
            tW = MIN(textSize.width, cRect.size.width);
            tH = MIN(textSize.height, cRect.size.height);
            tX = (cRect.size.width - tW) * 0.5;
            tY = (cRect.size.height - tH) * 0.5;
            //图片0
            iX = iY = iW = iH = 0;
            break;
        case ButtonLayoutStyleImageOnly:
            //图片居中
            iW = MIN(imageSize.width, cRect.size.width);
            iH = MIN(imageSize.height, cRect.size.height);
            iX = (cRect.size.width - iW) * 0.5;
            iY = (cRect.size.height - iH) * 0.5;
            //图片0
            tX = tY = tW = tH = 0;
            break;
        case ButtonLayoutStyleTitleHL: //水平，文字左
            tW = textSize.width;
            tH = textSize.height;
            tX = cRect.origin.x;
            tY = (cRect.size.height - tH) * 0.5;
            
            iW = imageSize.width;
            iH = imageSize.height;
            iX = tX + tW + hSpace;
            iY = (cRect.size.height - iH) * 0.5;
            break;
        case ButtonLayoutStyleTitleHR: //水平，文字右
            iW = imageSize.width;
            iH = imageSize.height;
            iX = cRect.origin.x;
            iY = (cRect.size.height - iH) * 0.5;
            
            tW = textSize.width;
            tH = textSize.height;
            tX = iX + iW + hSpace;
            tY = (cRect.size.height - tH) * 0.5;
            break;
        case ButtonLayoutStyleTitleVT: //垂直，文字上
            tW = textSize.width;
            tH = textSize.height;
            tX = (cRect.size.width - tW) * 0.5;
            tY = cRect.origin.y;
            
            iW = imageSize.width;
            iH = imageSize.height;
            iX = (cRect.size.width - iW) * 0.5;
            iY = tY + tH + vSpace;
            break;
        case ButtonLayoutStyleTitleVB: //垂直，文字下
            iW = imageSize.width;
            iH = imageSize.height;
            iX = (cRect.size.width - iW) * 0.5;
            iY = cRect.origin.y;
            
            tW = textSize.width;
            tH = textSize.height;
            tX = (cRect.size.width - tW) * 0.5;
            tY = iY + iH + vSpace;
            break;
        default:
            break;
    }
    
    self.targetTitleRect = CGRectMake(tX, tY, tW, tH);
    self.targetImageRect = CGRectMake(iX, iY, iW, iH);
}

#pragma mark -
#pragma mark - Getter

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _indicatorView.frame = CGRectMake(0, 0, 20, 20);
    }
    return _indicatorView;
}

#pragma mark -
#pragma mark - HitTest
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.hidden == YES || self.alpha == 0 || self.userInteractionEnabled == NO) {
        return NO;
    }
    
    CGFloat width  = MAX(44, self.frame.size.width);
    CGFloat height = MAX(44, self.frame.size.height);
    
    CGRect rect = CGRectMake((self.frame.size.width - width) * 0.5, (self.frame.size.height - height) * 0.5, width, height);
    if (CGRectContainsPoint(rect, point)) {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark - Private
- (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    if (text.length < 1) {
        return CGSizeZero;
    }
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    NSAttributedString *attstr = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : font}];
    CGRect newRect = [attstr boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil];
    CGSize size = CGSizeMake(newRect.size.width, newRect.size.height);
    return size;
}


@end
