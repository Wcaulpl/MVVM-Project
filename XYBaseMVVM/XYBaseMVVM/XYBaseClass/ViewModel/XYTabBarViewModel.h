//
//  XYTabBarViewModel.h
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYTabBarViewModel : NSObject

@property (nonatomic, strong) RACCommand *loadCommand;

@end

NS_ASSUME_NONNULL_END
