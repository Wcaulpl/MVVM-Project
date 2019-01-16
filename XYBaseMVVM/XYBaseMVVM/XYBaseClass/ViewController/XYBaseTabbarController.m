//
//  XYBaseTabbarController.m
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "XYBaseTabbarController.h"
#import "XYTabBarViewModel.h"
#import <LYEmptyView/LYEmptyViewHeader.h>

#import "XYBaseNavController.h"
#import "ViewController.h"
#import "DYLeftSlipManager.h"

@interface XYBaseTabbarController () <UITabBarControllerDelegate>

@property(nonatomic, strong) XYTabBarViewModel *viewModel;


@end

@implementation XYBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    self.tabBar.tintColor = RGB(249, 104, 62);
    
    [[DYLeftSlipManager sharedManager] setLeftViewController:[UIViewController new] coverViewController:self];
    
    [self.viewModel.loadCommand execute:nil];
}

- (void)setupChildControllers {
    NSArray *childViewControllers = @[
                                      [self addChildViewController:[[ViewController alloc] init] image:@"tabbar_home_normal" seletedImage:@"tabbar_home_selected" title:@"首页"],
                                      [self addChildViewController:[[ViewController alloc] init] image:@"tabbar_stat_normal"  seletedImage:@"tabbar_stat_selected"  title:@"统计"],
                                      [self addChildViewController:[[ViewController alloc] init] image:@"tabbar_mine_normal"  seletedImage:@"tabbar_mine_selected"  title:@"我的"]];
    
    [self setViewControllers:childViewControllers animated:NO];
}

- (XYBaseNavController *)addChildViewController:(UIViewController *)childController image:(NSString *)image seletedImage:(NSString *)selectedImage title:(NSString *)title
{
    childController.title = title;
    [childController.tabBarItem setImage:[self scaleImage:image]];
    [childController.tabBarItem setSelectedImage:[self scaleImage:selectedImage]];
    [childController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    // 包装导航条
    XYBaseNavController *nav = [[XYBaseNavController alloc] initWithRootViewController:childController];
    return nav;
}


#pragma mark UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navi = (UINavigationController *)viewController;
        UIViewController *con = navi.viewControllers.lastObject;
        if ([con.title isEqualToString:@"我的"]) {
            if (navi.navigationBar.hidden == NO)
            {
                [navi setNavigationBarHidden:YES animated:NO];
            }
        }
    }
    
    return YES;
}

- (UIImage *)scaleImage:(NSString *)imageName
{
    UIImage *img = [UIImage imageNamed:imageName];
    
    CGFloat height = 23.6;
    CGSize origin = img.size;
    origin.width = height / origin.height*origin.width;
    origin.height = height;
    
    UIGraphicsBeginImageContextWithOptions(origin, NO, [UIScreen mainScreen].scale);
    [img drawInRect:CGRectMake(0, 0, origin.width, origin.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [scaledImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/// 初始化数据
- (void)xy_initialDefaultsForController {
    if (!self.viewModel) {
        self.viewModel = [[XYTabBarViewModel alloc] init];
    }
}

/// 绑定 vm
- (void)xy_bindViewModelForController {
    @weakify(self);
    [[self.viewModel.loadCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue) {
            @strongify(self);
            [self.view ly_showEmptyView];
            [SVProgressHUD xy_dispalyLoadingMsgWithStatus: @"正在获取登录用户信息"];
        };
    }];
    
    [self.viewModel.loadCommand.executionSignals subscribeNext:^(RACSignal* signal) {
        [[signal dematerialize] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            //请求成功后，关闭提示信息，否则将一直显示提示信息
            [SVProgressHUD dismiss];
            [self.view ly_hideEmptyView];
            [self setupChildControllers];

        } error:^(NSError * _Nullable error) {
            [SVProgressHUD xy_displayErrorWithStatus:error.localizedDescription];
            //如果是网络问题，则退出登录，并返回登录页面
            [self.view ly_hideEmptyView];
            [self setupChildControllers];
//            logout
        }];
    }];
}

/// 创建视图
- (void)xy_createViewForConctroller {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"splash"];
    self.view.ly_emptyView = [LYEmptyView emptyViewWithCustomView:imageView];
    [self.view ly_showEmptyView];
}

@end
