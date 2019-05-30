
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DifferProtocol <NSObject>

- (void)differMethod;

@end

@interface DifferClass : NSObject

@property(nonatomic,strong) id<DifferProtocol> differDelegate;
@property(nonatomic,strong) NSString *account;

- (void)addScrollHeader:(NSString *)header;

- (void)changeAccountButtonClicked:(NSString *)string
                       closeAction:(NSString *)actionName;

@end

NS_ASSUME_NONNULL_END
