

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IgnoreProperty : NSObject

@property (nonatomic, strong) NSString *myButton;
@property (nonatomic, strong) NSString *testButton;

- (void)fetchServerLink;

@end

NS_ASSUME_NONNULL_END
