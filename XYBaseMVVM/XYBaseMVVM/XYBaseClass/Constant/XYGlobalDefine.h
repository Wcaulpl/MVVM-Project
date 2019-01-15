//
//  XYGlobalDefine.h
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#ifndef XYGlobalDefine_h
#define XYGlobalDefine_h

/*********************************************************************
 * 单例宏
 */
#define XY_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));

#define XY_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}
//*********************************************************************



/*********************************************************************
 * 屏幕宽高
 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif
//*********************************************************************



/*********************************************************************
 * 颜色宏
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define RGB(r, g, b) RGBA(r, g, b, 1.0)

#define HEX(hex, a) RGBA(((float)((hex & 0xFF0000) >> 16)), ((float)((hex & 0xFF00) >> 8)), ((float)(hex & 0xFF)), a)

// 颜色转image
#define XYImageFromColor(color) \
({\
CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);\
UIGraphicsBeginImageContext(rect.size);\
CGContextRef context = UIGraphicsGetCurrentContext();\
CGContextSetFillColorWithColor(context, [color CGColor]);\
CGContextFillRect(context, rect);\
UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();\
UIGraphicsEndImageContext();\
(theImage);\
})\

//*********************************************************************



/*********************************************************************
 * 自定义Log
 */
#ifdef DEBUG
#define XYLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define XYLog(...)
#endif
//*********************************************************************



/*********************************************************************
 * Assert functions Assert 断言
 */
//iAssert 断言
#define XYAssert(expression, ...) \
do { if(!(expression)) { \
XYLog(@"%@", \
[NSString stringWithFormat: @"Assertion failure: %s in %s on line %s:%d. %@",\
#expression, \
__PRETTY_FUNCTION__, \
__FILE__, __LINE__,  \
[NSString stringWithFormat:@"" __VA_ARGS__]]); \
abort(); } \
} while(0)
//*********************************************************************



/*********************************************************************
 * 方法禁用提示
 */
#define XYDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
//*********************************************************************



/*********************************************************************
 * 获取当前语言
 */
#define XYCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//*********************************************************************



/*********************************************************************
 * 沙盒目录文件
 */
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//*********************************************************************



/*********************************************************************
 * 强弱引用宏
 */
//#define weakify(obj) __typeof__(obj) __weak obj##__weak_ = obj
//
//#define strongify(obj) __typeof__(obj##__weak_) __strong obj = obj##__weak_
//*********************************************************************



/*********************************************************************
 * Extern and Inline  functions 内联函数  外联函数
 */
/*／EXTERN 外联函数*/
#if !defined(XY_EXTERN)
#  if defined(__cplusplus)
#   define XY_EXTERN extern "C"
#  else
#   define XY_EXTERN extern
#  endif
#endif

/*INLINE 内联函数*/
#if !defined(XY_INLINE)
# if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
#  define XY_INLINE static inline
# elif defined(__cplusplus)
#  define XY_INLINE static inline
# elif defined(__GNUC__)
#  define XY_INLINE static __inline__
# else
#  define XY_INLINE static
# endif
#endif
//*********************************************************************



/*********************************************************************
 * 手机系统版本
 */
#define XYSystemVersion [[UIDevice currentDevice] systemVersion]
//********************************************************************

/*********************************************************************
 * nil or NULL 空判断
 */

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

//********************************************************************

/*********************************************************************
 * 角度弧度转换
 */
#define XYDegreesToRadian(degrees) (M_PI * (degrees) / 180.0)

#define XYRadianToDegrees(radian) (radian*180.0)/(M_PI)
//********************************************************************



/*********************************************************************
 * 设置视图圆角
 */
// 全部圆角设置
#define XYViewBorderRadius(view, radius)view.layer.masksToBounds=YES;\
view.layer.cornerRadius=radius;

// 各个圆角设置
#define XYViewCornerRadius(view, radius, rectCorner) CAShapeLayer *shapeLayer = [CAShapeLayer layer];\
shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)].CGPath;\
view.layer.mask = shapeLayer
//********************************************************************



/*********************************************************************
 * 属性快速声明
 */
//property快速声明
#define XYPropStatement(propertyModifier, propertyPointerType, propertyName)                  \
@property(nonatomic, propertyModifier)propertyPointerType propertyName

//属性方法快速声明
#define XYPropStatementAndFuncStatement(propertyModifier,className, propertyPointerType, propertyName)                  \
@property(nonatomic, propertyModifier)propertyPointerType propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define XYPropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
self.propertyName = propertyName;                                                                                       \
return self;                                                                                                            \
};                                                                                                                      \
}
//********************************************************************



/*********************************************************************
 * GCD宏定义
 */
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock)

//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock)

//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), globalQueueBlock)

//GCD - 安全访问
#ifndef dispatch_main_async_safe

#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) ==0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif
//********************************************************************

// controller 基类
#import "UIViewController+XYBase.h"
// 全局定义
#import "XYFunctionDefine.h"
// 提示组件
#import "SVProgressHUD+XYHelper.h"

// 自动布局框架
#import "Masonry.h"

// Request RAC
#import "XYBaseRequest+RAC.h"

#endif /* Header_h */
