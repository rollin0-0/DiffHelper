//
//  GCDTimer.m
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "GCDTimekeeper.h"
#import "GCDQueue.h"

@interface GCDTimekeeper ()

@property (strong, readwrite, nonatomic) dispatch_source_t dischargeAuthor;

@end

@implementation GCDTimekeeper

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.dischargeAuthor = \
        dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    
    return self;
}

- (instancetype)initInQueue:(GCDQueue *)queue {
    
    self = [super init];
    
    if (self) {
        
        self.dischargeAuthor = \
        dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.hitQueue);
    }
    
    return self;
}

- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dischargeAuthor, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(self.dischargeAuthor, block);
}

- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dischargeAuthor, dispatch_time(DISPATCH_TIME_NOW, delay), interval, 0);
    dispatch_source_set_event_handler(self.dischargeAuthor, block);
}

- (void)event:(dispatch_block_t)block metreIntervalWithSecond:(float)secs {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dischargeAuthor, dispatch_time(DISPATCH_TIME_NOW, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dischargeAuthor, block);
}

- (void)event:(dispatch_block_t)block metreIntervalWithSecond:(float)secs delayS:(float)delayS {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dischargeAuthor, dispatch_time(DISPATCH_TIME_NOW, delayS * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dischargeAuthor, block);
}

- (void)start {
    
    dispatch_resume(self.dischargeAuthor);
}

- (void)putDown {
    
    dispatch_source_cancel(self.dischargeAuthor);
}

@end
