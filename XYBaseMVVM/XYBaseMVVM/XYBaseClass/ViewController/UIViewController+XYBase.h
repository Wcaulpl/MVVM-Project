//
//  UIViewController+XYBase.h
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XYBase)

/// 初始化数据
- (void)xy_initialDefaultsForController;

/// 绑定 vm
- (void)xy_bindViewModelForController;

/// 创建视图
- (void)xy_createViewForConctroller;

/// 配置导航栏
- (void)xy_configNavigationForController;

@end

NS_ASSUME_NONNULL_END
