







#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRequestModelC : NSObject

+ (instancetype)requsetModel;

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *userProtocol;
@property (nonatomic, strong) NSNumber *owner;
@property (nonatomic, strong) NSString *compared;

- (NSMutableDictionary *)publicParameter;

@end

NS_ASSUME_NONNULL_END
