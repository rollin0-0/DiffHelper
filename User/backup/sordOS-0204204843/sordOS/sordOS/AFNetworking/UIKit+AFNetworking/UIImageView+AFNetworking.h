




















#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AFImageDownloader;


@interface UIImageView (AFNetworking)






+ (void)setSharedImageDownloader:(AFImageDownloader *)imageDownloader;


+ (AFImageDownloader *)sharedImageDownloader;






- (void)setImageWithURL:(NSURL *)url;


- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(nullable UIImage *)placeholderImage;


- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(nullable UIImage *)placeholderImage
                       success:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, UIImage *image))success
                       failure:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error))failure;


- (void)cancelImageDownloadTask;

@end

NS_ASSUME_NONNULL_END

#endif
