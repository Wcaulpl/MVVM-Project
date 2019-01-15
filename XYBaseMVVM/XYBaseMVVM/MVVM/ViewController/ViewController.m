//
//  ViewController.m
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = RGB((arc4random()%255), (arc4random()%255), (arc4random()%255));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.navigationController.childViewControllers.count == 4) {
        NSMutableArray *array = self.navigationController.childViewControllers.mutableCopy;
        [array removeLastObject];
        [array addObject:ViewController.new];
        XYLog(@"setViewControllers");
//        [self.navigationController setViewControllers:array];
        [self.navigationController setViewControllers:array animated:YES];
    } else
        [self.navigationController pushViewController:[ViewController new]  animated:YES];
}

@end
