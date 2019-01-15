//
//  XYBaseNavController.m
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "XYBaseNavController.h"

@interface XYBaseNavController ()<UIGestureRecognizerDelegate>

@end

@implementation XYBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [self.navigationBar setBackgroundImage:XYImageFromColor([UIColor brownColor]) forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationBar setBackgroundImage:XYImageFromColor([UIColor brownColor]) forBarMetrics:UIBarMetricsDefault];
    }
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self xy_setLeftBarButtonItemWithController:viewController];

    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}


- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [self xy_setLeftBarButtonItemWithController:viewControllers[viewControllers.count-1]];
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super setViewControllers:viewControllers animated:animated];
}

- (void)xy_setLeftBarButtonItemWithController:(UIViewController *)viewController {
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"NavBack"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 44, 44);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if(self.childViewControllers.count > 1){
        return YES;
    } else {
        return NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
