//
//  XYBaseRequest+RAC.h
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "XYBaseRequest.h"
// 响应式框架
#import "ReactiveObjC/ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBaseRequest (RAC)

- (RACSignal *)rac_requestSignal;

@end

NS_ASSUME_NONNULL_END
