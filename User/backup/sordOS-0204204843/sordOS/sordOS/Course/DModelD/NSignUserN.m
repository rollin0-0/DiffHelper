







#import "NSignUserN.h"

@implementation NSignUserN

- (NSString *)lastName{
    self.lastName = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastName"];
    return _lastName;
}

- (NSString *)lastPassword{
    self.lastPassword = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastPassword"];
    return _lastPassword;
}

@end
