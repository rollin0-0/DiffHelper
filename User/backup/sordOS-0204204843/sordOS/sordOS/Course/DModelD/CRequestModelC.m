







#import "CRequestModelC.h"


@implementation CRequestModelC

+ (instancetype)requsetModel{
    static CRequestModelC *model = nil;
          static dispatch_once_t onceToken;
          dispatch_once(&onceToken, ^{
              model = [[super allocWithZone:NULL] init];
          });
          return model;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [CRequestModelC requsetModel];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [CRequestModelC requsetModel];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [CRequestModelC requsetModel];
}

- (NSMutableDictionary *)publicParameter {

    NSTimeInterval time     = [[NSDate date] timeIntervalSince1970];
    NSString    *timeStr    = [NSString stringWithFormat:@"%ld",(long)time];
    NSString *nameKey       = self.key;
    NSString *customStr    = [NSString stringWithFormat:@"%@%@",nameKey,[[NSString stringWithFormat:@"%f",time] substringToIndex:10]];
    NSString *customStrSign    = customStr.md5String;
    
    NSString *appendStr = [NSString stringWithFormat:@"%@%@",self.Id,self.key];
    
    NSMutableDictionary *parmeter     = [NSMutableDictionary dictionaryWithCapacity:0];



    return parmeter;
}

@end
