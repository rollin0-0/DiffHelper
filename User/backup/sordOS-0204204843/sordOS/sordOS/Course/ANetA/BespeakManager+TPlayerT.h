







#import "BespeakManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BespeakManager (TPlayerT)

- (void)getAccountOnlineSuccess:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)registerWithName:(NSString *)name password:(NSString *)password successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)numberRegisterGetCode:(NSString *)number success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;
- (void)numberRegisterWithId:(NSString *)Id code:(NSString *)code password:(NSString *)password success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)signInWithName:(NSString *)name paswword:(NSString *)password successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)signOutSuccess:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


@end

NS_ASSUME_NONNULL_END
