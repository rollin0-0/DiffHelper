




















#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface UIProgressView (AFNetworking)






- (void)setProgressWithUploadProgressOfTask:(NSURLSessionUploadTask *)task
                                   animated:(BOOL)animated;


- (void)setProgressWithDownloadProgressOfTask:(NSURLSessionDownloadTask *)task
                                     animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

#endif
