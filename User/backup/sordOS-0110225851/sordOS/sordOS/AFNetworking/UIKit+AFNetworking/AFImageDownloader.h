




















#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV 

#import <Foundation/Foundation.h>
#import "AFAutoPurgingImageCache.h"
#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AFImageDownloadPrioritization) {
    AFImageDownloadPrioritizationFIFO,
    AFImageDownloadPrioritizationLIFO
};


@interface AFImageDownloadReceipt : NSObject


@property (nonatomic, strong) NSURLSessionDataTask *task;


@property (nonatomic, strong) NSUUID *receiptID;
@end


@interface AFImageDownloader : NSObject


@property (nonatomic, strong, nullable) id <AFImageRequestCache> imageCache;


@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;


@property (nonatomic, assign) AFImageDownloadPrioritization downloadPrioritizaton;


+ (instancetype)defaultInstance;


+ (NSURLCache *)defaultURLCache;


+ (NSURLSessionConfiguration *)defaultURLSessionConfiguration;


- (instancetype)init;


- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;


- (instancetype)initWithSessionManager:(AFHTTPSessionManager *)sessionManager
                downloadPrioritization:(AFImageDownloadPrioritization)downloadPrioritization
                maximumActiveDownloads:(NSInteger)maximumActiveDownloads
                            imageCache:(nullable id <AFImageRequestCache>)imageCache;


- (nullable AFImageDownloadReceipt *)downloadImageForURLRequest:(NSURLRequest *)request
                                                        success:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse  * _Nullable response, UIImage *responseObject))success
                                                        failure:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error))failure;


- (nullable AFImageDownloadReceipt *)downloadImageForURLRequest:(NSURLRequest *)request
                                                 withReceiptID:(NSUUID *)receiptID
                                                        success:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse  * _Nullable response, UIImage *responseObject))success
                                                        failure:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error))failure;


- (void)cancelTaskForImageDownloadReceipt:(AFImageDownloadReceipt *)imageDownloadReceipt;

@end

#endif

NS_ASSUME_NONNULL_END
