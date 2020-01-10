







#import "BespeakManager.h"

@implementation BespeakManager

+ (instancetype)defaultManager{
    static BespeakManager *request = nil;
          static dispatch_once_t onceToken;
          dispatch_once(&onceToken, ^{
              request = [[super allocWithZone:NULL] init];
          });
          return request;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [BespeakManager defaultManager];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [BespeakManager defaultManager];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [BespeakManager defaultManager];
}

@end
