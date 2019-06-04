//
//  GCDGroup.m
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "GCDGrouping.h"

@interface GCDGrouping ()

@property (strong, nonatomic, readwrite) dispatch_group_t expeditionGroup;

@end

@implementation GCDGrouping

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.expeditionGroup = dispatch_group_create();
    }
    
    return self;
}

- (void)getInto {
    
    dispatch_group_enter(self.expeditionGroup);
}

- (void)leave {
    
    dispatch_group_leave(self.expeditionGroup);
}

- (void)wait {
    
    dispatch_group_wait(self.expeditionGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    
    return dispatch_group_wait(self.expeditionGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

@end
