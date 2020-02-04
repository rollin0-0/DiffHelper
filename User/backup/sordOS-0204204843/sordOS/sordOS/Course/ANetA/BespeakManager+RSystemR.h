







#import "BespeakManager.h"
#import "ZOnceModelZ.h"

NS_ASSUME_NONNULL_BEGIN

@interface BespeakManager (RSystemR)

- (void)changeDifferentPlace;

- (void)installationRecordWithId:(NSString *)Id key:(NSString *)key;

- (void)internetHelpSuccess:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;

- (void)LoginInfoZoneId:(NSString *)zongId success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;

- (void)newsRequsetWithExtensionBody:(OnceModel *)model successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;

- (void)cardEveryDayWithUserDetail:(NSString *)userDetail successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;

- (void)recheckEveryDayCardWithInfoDic:(OnceModel *)model str:(NSString *)keyString successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock;

- (void)checkLeaksDocument;

- (void)dataReportWithType:(NSString *)type serId:(NSString *)serId serName:(NSString *)serName roleName:(NSString *)roleName roleLevel:(NSString *)roleLevel roleId:(NSString *)roleId number:(NSString *)number uId:(NSString *)uId;

@end

NS_ASSUME_NONNULL_END
