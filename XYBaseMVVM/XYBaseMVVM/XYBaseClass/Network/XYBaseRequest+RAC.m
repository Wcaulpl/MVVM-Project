//
//  XYBaseRequest+RAC.m
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "XYBaseRequest+RAC.h"
#import "NSObject+RACDescription.h"

@implementation XYBaseRequest (RAC)

- (RACSignal *)rac_requestSignal
{
    [self stop];
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 请求起飞
        [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [subscriber sendNext:[request responseJSONObject]];
            [subscriber sendCompleted];
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [subscriber sendError:[request error]];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
            [self stop];
        }];
    }] takeUntil:[self rac_willDeallocSignal]];
    
    //设置名称 便于调试
    if (DEBUG) {
        [signal setNameWithFormat:@"%@ -rac_xzwRequest", RACDescription(self)];
    }
    return signal;
}

@end
