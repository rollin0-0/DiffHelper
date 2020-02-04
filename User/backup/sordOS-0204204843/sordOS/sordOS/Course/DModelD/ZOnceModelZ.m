







#import "ZOnceModelZ.h"

@implementation OnceModel

+ (instancetype)defaultModel{
    static OnceModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[super allocWithZone:NULL] init];
    });
    return model;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [OnceModel defaultModel];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [OnceModel defaultModel];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [OnceModel defaultModel];
}

@end
