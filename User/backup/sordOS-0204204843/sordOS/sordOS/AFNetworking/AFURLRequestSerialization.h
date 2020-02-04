




















#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN


FOUNDATION_EXPORT NSString * AFPercentEscapedStringFromString(NSString *string);


FOUNDATION_EXPORT NSString * AFQueryStringFromParameters(NSDictionary *parameters);


@protocol AFURLRequestSerialization <NSObject, NSSecureCoding, NSCopying>


- (nullable NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(nullable id)parameters
                                        error:(NSError * _Nullable __autoreleasing *)error NS_SWIFT_NOTHROW;

@end

#pragma mark -


typedef NS_ENUM(NSUInteger, AFHTTPRequestQueryStringSerializationStyle) {
    AFHTTPRequestQueryStringDefaultStyle = 0,
};

@protocol AFMultipartFormData;


@interface AFHTTPRequestSerializer : NSObject <AFURLRequestSerialization>


@property (nonatomic, assign) NSStringEncoding stringEncoding;


@property (nonatomic, assign) BOOL allowsCellularAccess;


@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;


@property (nonatomic, assign) BOOL HTTPShouldHandleCookies;


@property (nonatomic, assign) BOOL HTTPShouldUsePipelining;


@property (nonatomic, assign) NSURLRequestNetworkServiceType networkServiceType;


@property (nonatomic, assign) NSTimeInterval timeoutInterval;






@property (readonly, nonatomic, strong) NSDictionary <NSString *, NSString *> *HTTPRequestHeaders;


+ (instancetype)serializer;


- (void)setValue:(nullable NSString *)value
forHTTPHeaderField:(NSString *)field;


- (nullable NSString *)valueForHTTPHeaderField:(NSString *)field;


- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password;


- (void)clearAuthorizationHeader;






@property (nonatomic, strong) NSSet <NSString *> *HTTPMethodsEncodingParametersInURI;


- (void)setQueryStringSerializationWithStyle:(AFHTTPRequestQueryStringSerializationStyle)style;


- (void)setQueryStringSerializationWithBlock:(nullable NSString * (^)(NSURLRequest *request, id parameters, NSError * __autoreleasing *error))block;






- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(nullable id)parameters
                                     error:(NSError * _Nullable __autoreleasing *)error;


- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(nullable NSDictionary <NSString *, id> *)parameters
                              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                                  error:(NSError * _Nullable __autoreleasing *)error;


- (NSMutableURLRequest *)requestWithMultipartFormRequest:(NSURLRequest *)request
                             writingStreamContentsToFile:(NSURL *)fileURL
                                       completionHandler:(nullable void (^)(NSError * _Nullable error))handler;

@end

#pragma mark -


@protocol AFMultipartFormData


- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                        error:(NSError * _Nullable __autoreleasing *)error;


- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                        error:(NSError * _Nullable __autoreleasing *)error;


- (void)appendPartWithInputStream:(nullable NSInputStream *)inputStream
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                           length:(int64_t)length
                         mimeType:(NSString *)mimeType;


- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;



- (void)appendPartWithFormData:(NSData *)data
                          name:(NSString *)name;



- (void)appendPartWithHeaders:(nullable NSDictionary <NSString *, NSString *> *)headers
                         body:(NSData *)body;


- (void)throttleBandwidthWithPacketSize:(NSUInteger)numberOfBytes
                                  delay:(NSTimeInterval)delay;

@end

#pragma mark -


@interface AFJSONRequestSerializer : AFHTTPRequestSerializer


@property (nonatomic, assign) NSJSONWritingOptions writingOptions;


+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions;

@end

#pragma mark -


@interface AFPropertyListRequestSerializer : AFHTTPRequestSerializer


@property (nonatomic, assign) NSPropertyListFormat format;


@property (nonatomic, assign) NSPropertyListWriteOptions writeOptions;


+ (instancetype)serializerWithFormat:(NSPropertyListFormat)format
                        writeOptions:(NSPropertyListWriteOptions)writeOptions;

@end

#pragma mark -






FOUNDATION_EXPORT NSString * const AFURLRequestSerializationErrorDomain;


FOUNDATION_EXPORT NSString * const AFNetworkingOperationFailingURLRequestErrorKey;


FOUNDATION_EXPORT NSUInteger const kAFUploadStream3GSuggestedPacketSize;
FOUNDATION_EXPORT NSTimeInterval const kAFUploadStream3GSuggestedDelay;

NS_ASSUME_NONNULL_END
