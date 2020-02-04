







#import "LoginService.h"

@implementation LoginService

+ (instancetype)loginService{
    static LoginService *loginSer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginSer = [[LoginService alloc] init];
    });
    return loginSer;
}

- (NSignUserN *)user{
    if (!_user) {
        _user = [[NSignUserN alloc] init];
    }
    return _user;
}

- (void)loginSetUser:(NSDictionary *)response{
    self.user.aren = [response objectForKey:@"aren"];
    self.user.precede = [response objectForKey:@"precede"];
    self.user.instructions = [response objectForKey:@"instructions"];
    self.user.functionality = [response objectForKey:@"functionality"];
    self.user.either = [response objectForKey:@"either"];
    self.user.exploit = [response objectForKey:@"exploit"];

}

- (void)clearLoginInfomation{
    self.user = nil;
}

@end
