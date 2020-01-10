







#import "BespeakManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BespeakManager (SCodeS)


- (void)findPasswordCodeWithName:(NSString *)name success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;
- (void)findPasswordConfirmWithName:(NSString *)name newPassword:(NSString *)password code:(NSString *)code success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)bindPhoneCodeGetWithNumber:(NSString *)numner success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;
- (void)bindPhoneWithNumber:(NSString *)numner code:(NSString *)code success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)bindMailCodeGetWithAddress:(NSString *)mail success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;
- (void)bindMailWithAddress:(NSString *)mail code:(NSString *)code success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)modiyPasswordWithName:(NSString *)name newPassword:(NSString *)password oldPassword:(NSString *)oldPassword success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;


- (void)IDCardVefiedWithName:(NSString *)name card:(NSString *)card success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
