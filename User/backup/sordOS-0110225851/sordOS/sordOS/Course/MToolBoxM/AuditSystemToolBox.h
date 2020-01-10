







#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditSystemToolBox : NSObject

+ (instancetype)shareBox;

@property (nonatomic,readonly) NSString *buildVersion;
@property (nonatomic,readonly) NSString *idfa;
@property (nonatomic,readonly) NSString *bundleId;
@property (nonatomic,readonly) NSString *bundleName;
@property (nonatomic,readonly) NSString *phoneModel;
@property (nonatomic,readonly) NSInteger direction;
@property (nonatomic,readonly) NSString *placeString;
@property (nonatomic,readonly) NSString *placeInstallString;
@property (nonatomic,readonly) NSString *pureString;


@end

NS_ASSUME_NONNULL_END
