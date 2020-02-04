







#import <Foundation/Foundation.h>



#define TIMEOUT 15
typedef void(^JTSuccessBlock)(NSDictionary *repsonse);
typedef void(^JTFailureBlock)(NSError *error);

@interface TJTInternetT : NSObject

+ (instancetype)shareInternet;

- (void)requestPost:(NSString *)str
               json:(BOOL)json
               body:(NSDictionary *)body
                hud:(BOOL)hud
              toast:(BOOL)toast
            success:(JTSuccessBlock)successBlock
            failure:(JTFailureBlock)failureBlock;

- (void)requestClearPost:(NSString *)str
                    json:(BOOL)json
                    body:(NSDictionary *)body
                     hud:(BOOL)hud
                 success:(JTSuccessBlock)successBlock
                 failure:(JTFailureBlock)failureBlock;

@end


