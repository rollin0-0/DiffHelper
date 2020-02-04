




















#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.")
@interface AFNetworkActivityIndicatorManager : NSObject


@property (nonatomic, assign, getter = isEnabled) BOOL enabled;


@property (readonly, nonatomic, assign, getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible;


@property (nonatomic, assign) NSTimeInterval activationDelay;



@property (nonatomic, assign) NSTimeInterval completionDelay;


+ (instancetype)sharedManager;


- (void)incrementActivityCount;


- (void)decrementActivityCount;


- (void)setNetworkingActivityActionWithBlock:(nullable void (^)(BOOL networkActivityIndicatorVisible))block;

@end

NS_ASSUME_NONNULL_END

#endif
