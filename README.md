# QSButton
根据文字和图片的大小自动调整大小的Button，并设置了最小手势相应大小，还还可以设置图片文字左右布局和间隔

#初始化传入一个布局方案

- (instancetype)initWithFrame:(CGRect)frame; //默认 ButtonLayoutStyleTitleOnly

- (instancetype)initWithFrame:(CGRect)frame withStyle:(ButtonLayoutStyle)style;

    ButtonLayoutStyleTitleOnly = 0,  //只有文字
    
    ButtonLayoutStyleImageOnly,      //只有图片
    
    ButtonLayoutStyleTitleHL,        //文字图片水平排列，文字在左
    
    ButtonLayoutStyleTitleHR,        //文字图片水平排列，文字在右
    
    ButtonLayoutStyleTitleVT,        //文字图片垂直排列，文字在上
    
    ButtonLayoutStyleTitleVB,        //文字图片垂直排列，文字在下
    
    
    
#初始化后用该方法设置图片和文字 没有则用nil

- (void)setName:(NSString *)title andImage:(UIImage *)image; //设置图片和文字


#一些可以设置的值

@property (nonatomic, assign) ButtonLayoutStyle layoutStyle; // 布局样式

@property (nonatomic, assign) CGFloat hSpace; //水平间距 默认5

@property (nonatomic, assign) CGFloat vSpace; //垂直间距 默认5

@property (nonatomic, assign) BOOL lockWidth; //锁定宽度 暂未实现


@property (nonatomic, assign) BOOL lockHeight;//锁定高度 暂未实现

- (void)setUseableStyle:(BOOL)enable;  //是否可以点击

- (void)useHighLightStyle:(BOOL)highLightStyle; //是否高亮模式



#菊花，开始转动会隐藏图片和文字，停止显示

@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView; 

- (void)startIndicatorAnimation; //开始菊花动画

- (void)stopIndicatorAnimation;  //停止菊花动画




