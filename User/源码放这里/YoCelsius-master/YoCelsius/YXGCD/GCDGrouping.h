//
//  GCDGroup.h
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDGrouping : NSObject

@property (strong, nonatomic, readonly) dispatch_group_t expeditionGroup;

#pragma 初始化
- (instancetype)init;

#pragma mark - 用法
- (void)getInto;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
