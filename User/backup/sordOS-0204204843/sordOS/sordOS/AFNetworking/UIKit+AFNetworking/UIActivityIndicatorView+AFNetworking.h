




















#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import <UIKit/UIKit.h>


@interface UIActivityIndicatorView (AFNetworking)






- (void)setAnimatingWithStateOfTask:(nullable NSURLSessionTask *)task;

@end

#endif
