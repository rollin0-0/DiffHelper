




















#import <Foundation/Foundation.h>

#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>

typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
    AFNetworkReachabilityStatusUnknown          = -1,
    AFNetworkReachabilityStatusNotReachable     = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetworkReachabilityStatusReachableViaWiFi = 2,
};

NS_ASSUME_NONNULL_BEGIN


@interface AFNetworkReachabilityManager : NSObject


@property (readonly, nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;


@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;


@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;


@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;






+ (instancetype)sharedManager;


+ (instancetype)manager;


+ (instancetype)managerForDomain:(NSString *)domain;


+ (instancetype)managerForAddress:(const void *)address;


- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;


+ (instancetype)new NS_UNAVAILABLE;


- (instancetype)init NS_UNAVAILABLE;






- (void)startMonitoring;


- (void)stopMonitoring;






- (NSString *)localizedNetworkReachabilityStatusString;






- (void)setReachabilityStatusChangeBlock:(nullable void (^)(AFNetworkReachabilityStatus status))block;

@end












FOUNDATION_EXPORT NSString * const AFNetworkingReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString * const AFNetworkingReachabilityNotificationStatusItem;






FOUNDATION_EXPORT NSString * AFStringFromNetworkReachabilityStatus(AFNetworkReachabilityStatus status);

NS_ASSUME_NONNULL_END
#endif
