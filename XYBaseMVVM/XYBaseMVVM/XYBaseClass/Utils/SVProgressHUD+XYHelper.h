//
//  SVProgressHUD+XYHelper.h
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (XYHelper)

/// 显示不带文字的overflow
+ (void)xy_displayOverFlowActivityView;

+ (void)xy_displayOverFlowActivityView:(NSTimeInterval)maxShowTime;

/// 显示成功状态
+ (void)xy_displaySuccessWithStatus:(NSString *)status;

/// 显示失败状态
+ (void)xy_displayErrorWithStatus:(NSString *)status;

/// 显示提示信息
+ (void)xy_dispalyInfoWithStatus:(NSString *)status;

/// 显示提示信息
+ (void)xy_dispalyMsgWithStatus:(NSString *)status;

/// 显示加载圈 加文本
+ (void)xy_dispalyLoadingMsgWithStatus:(NSString *)status;

/// 显示进度，带文本
+ (void)xy_dispalyProgress:(CGFloat)progress status:(NSString *)status;

/// 显示进度，不带文本
+ (void)xy_dispalyProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
