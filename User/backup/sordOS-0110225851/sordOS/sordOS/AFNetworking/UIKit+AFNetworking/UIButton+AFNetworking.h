




















#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AFImageDownloader;


@interface UIButton (AFNetworking)






+ (void)setSharedImageDownloader:(AFImageDownloader *)imageDownloader;


+ (AFImageDownloader *)sharedImageDownloader;






- (void)setImageForState:(UIControlState)state
                 withURL:(NSURL *)url;


- (void)setImageForState:(UIControlState)state
                 withURL:(NSURL *)url
        placeholderImage:(nullable UIImage *)placeholderImage;


- (void)setImageForState:(UIControlState)state
          withURLRequest:(NSURLRequest *)urlRequest
        placeholderImage:(nullable UIImage *)placeholderImage
                 success:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, UIImage *image))success
                 failure:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error))failure;







- (void)setBackgroundImageForState:(UIControlState)state
                           withURL:(NSURL *)url;


- (void)setBackgroundImageForState:(UIControlState)state
                           withURL:(NSURL *)url
                  placeholderImage:(nullable UIImage *)placeholderImage;


- (void)setBackgroundImageForState:(UIControlState)state
                    withURLRequest:(NSURLRequest *)urlRequest
                  placeholderImage:(nullable UIImage *)placeholderImage
                           success:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, UIImage *image))success
                           failure:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error))failure;







- (void)cancelImageDownloadTaskForState:(UIControlState)state;


- (void)cancelBackgroundImageDownloadTaskForState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END

#endif
