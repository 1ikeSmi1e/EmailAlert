// UI相关
#define MSWIDTH         [UIScreen mainScreen].bounds.size.width
#define MSHIGHT         CGRectGetHeight([UIScreen mainScreen].bounds)
#define RECT(x, y, w, h) CGRectMake(x, y, w, h)
#define EDGEINSET(top, left, bottom, right) UIEdgeInsetsMake(top, left, bottom, right)
// 按照ipnone6设计效果图缩放比例
#define AJScaleMiltiplier MSWIDTH/375
#define AJHeightMiltiplier MSHIGHT/667
#define AJHeightMiltiplier_Content (MSHIGHT-64)/(667-64)

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ClickType){
    ClickType_sendEmail = 1,       // 发送邮件
    ClickType_adjustAmount,    // 调整金额
    ClickType_selectVendor,    // 选择商户号
};
@protocol UIViewOutterDelegate <NSObject>
// uiview的外部实现的方法，UIview告知代理
@optional
/**区块view里面的各个按钮点击事件，代理传递 */
- (void)view:(UIView *)sectionView didClickWithType:(ClickType)type;
@end


@protocol UIViewInnerDelegate <NSObject>
// uiview的内部实现的方法，外部可调用uiview的UIViewInnerDelegate协议方法
@optional
/** 给外界提供更新view的数据的方法声明*/
- (void)reloadDataWithObject:(id)bean;
@end


@interface UIView (AJ)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic, readonly) CGFloat maxX;
@property (assign, nonatomic, readonly) CGFloat maxY;
@property (assign, nonatomic, readonly) CGFloat minX;
@property (assign, nonatomic, readonly) CGFloat minY;


/**
  梯度背景色
 */
- (void)gradientView;

- (void)setCornerRadiu:(CGFloat)radius borderWidth:(CGFloat)border borderColor:(UIColor *)color;
/**
  移除梯度背景色
 */
- (void)removeGradientView;


/**
  抖动动画
 */
- (void)shakeAnimation;

- (UIViewController*)viewController;
@end


@interface UIControl (AJ)
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;// 可以用这个给重复点击加间隔
@end

