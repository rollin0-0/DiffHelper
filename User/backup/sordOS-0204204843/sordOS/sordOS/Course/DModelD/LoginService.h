







#import <Foundation/Foundation.h>
#import "NSignUserN.h"


@interface LoginService : NSObject



@property (nonatomic, strong) NSignUserN *user;

+ (instancetype) loginService;

- (void)loginSetUser:(NSDictionary *)response;

- (void)clearLoginInfomation;

@end

