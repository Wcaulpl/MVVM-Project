//
//  UIViewController+XYBase.m
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "UIViewController+XYBase.h"
#import "Aspects.h"

@implementation UIViewController (XYBase)

+ (void)load {
    [self aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        UIViewController *controller = info.instance;
        controller.edgesForExtendedLayout = UIRectEdgeAll;
        controller.extendedLayoutIncludesOpaqueBars = NO;
        controller.automaticallyAdjustsScrollViewInsets = NO;
        
        // 执行分解方法
        [controller xy_initialDefaultsForController];
        [controller xy_bindViewModelForController];
        [controller xy_configNavigationForController];
        [controller xy_createViewForConctroller];
    } error:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    // 点击隐藏键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

/// 初始化数据
- (void)xy_initialDefaultsForController {
    
}

/// 绑定 vm
- (void)xy_bindViewModelForController {
    
}

/// 创建视图
- (void)xy_createViewForConctroller {
    
}

/// 配置导航栏
- (void)xy_configNavigationForController {
    
}

@end
