




















#import <TargetConditionals.h>
#import <Foundation/Foundation.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol AFImageCache <NSObject>


- (void)addImage:(UIImage *)image withIdentifier:(NSString *)identifier;


- (BOOL)removeImageWithIdentifier:(NSString *)identifier;


- (BOOL)removeAllImages;


- (nullable UIImage *)imageWithIdentifier:(NSString *)identifier;
@end



@protocol AFImageRequestCache <AFImageCache>


- (BOOL)shouldCacheImage:(UIImage *)image forRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;


- (void)addImage:(UIImage *)image forRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;


- (BOOL)removeImageforRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;


- (nullable UIImage *)imageforRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;

@end


@interface AFAutoPurgingImageCache : NSObject <AFImageRequestCache>


@property (nonatomic, assign) UInt64 memoryCapacity;


@property (nonatomic, assign) UInt64 preferredMemoryUsageAfterPurge;


@property (nonatomic, assign, readonly) UInt64 memoryUsage;


- (instancetype)init;


- (instancetype)initWithMemoryCapacity:(UInt64)memoryCapacity preferredMemoryCapacity:(UInt64)preferredMemoryCapacity;

@end

NS_ASSUME_NONNULL_END

#endif

