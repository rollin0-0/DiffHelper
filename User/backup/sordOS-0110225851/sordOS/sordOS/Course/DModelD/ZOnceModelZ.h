







#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OnceModel : JSONModel

+ (instancetype)defaultModel;

@property (nonatomic, copy) NSString *userType;

@property (nonatomic, copy) NSString *zoneId;
@property (nonatomic, copy) NSString *etc;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *planName;
@property (nonatomic, copy) NSString *planId;

@end

NS_ASSUME_NONNULL_END
