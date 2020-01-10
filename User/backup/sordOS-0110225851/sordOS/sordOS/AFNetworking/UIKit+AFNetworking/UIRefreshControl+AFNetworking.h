





















#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIRefreshControl (AFNetworking)






- (void)setRefreshingWithStateOfTask:(NSURLSessionTask *)task;

@end

NS_ASSUME_NONNULL_END

#endif
