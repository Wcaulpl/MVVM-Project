//
//  XYTabBarViewModel.m
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "XYTabBarViewModel.h"
#import "XYTabbarRequest.h"

@implementation XYTabBarViewModel

- (RACCommand *)loadCommand {
    if (!_loadCommand) {
        _loadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString * _Nullable input) {
            XYTabbarRequest *request = [[XYTabbarRequest alloc] init];
            return [[[request rac_requestSignal] doNext:^(id  _Nullable x) {
                
            }] materialize];
        }];
    }
    return _loadCommand;
}

@end
