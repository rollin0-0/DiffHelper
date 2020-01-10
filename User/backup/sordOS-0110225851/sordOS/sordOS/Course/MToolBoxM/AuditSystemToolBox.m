







#import "AuditSystemToolBox.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>


@implementation AuditSystemToolBox

+ (instancetype)shareBox{
    static AuditSystemToolBox *box = nil;
          static dispatch_once_t onceToken;
          dispatch_once(&onceToken, ^{
              box = [[super allocWithZone:NULL] init];
          });
    return box;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [AuditSystemToolBox shareBox];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [AuditSystemToolBox shareBox];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [AuditSystemToolBox shareBox];
}


- (NSString *)buildVersion{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)phoneModel{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *str = [[NSString alloc]initWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return str;
}

- (NSString *)bundleName{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)bundleId{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)idfa{
            SEL advertisingIdentifierSel = sel_registerName("advertisingIdentifier");
            SEL UUIDStringSel = sel_registerName("UUIDString");
            
            ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if([manager respondsToSelector:advertisingIdentifierSel]) {
                
                id UUID = [manager performSelector:advertisingIdentifierSel];
                
                if([UUID respondsToSelector:UUIDStringSel]) {
                    return [UUID performSelector:UUIDStringSel];
                }
                
            }
    #pragma clang diagnostic pop
            return @"";
}

- (NSInteger)direction{
    UIInterfaceOrientation orien = [[UIApplication sharedApplication] statusBarOrientation];
    if (orien == UIInterfaceOrientationLandscapeLeft || orien == UIInterfaceOrientationLandscapeRight) {
        return 1;
    } else {
        return 0;
    }
}

- (NSString *)placeString{
    
    
    NSString *domainName = JTDefault_PlaceString;
    NSString *newDomainName = [[NSUserDefaults standardUserDefaults] objectForKey:@"placeString"];
    NSString *placeString = @"";
    
    return placeString;
}

- (NSString *)pureString{
    NSString *domainName = JTDefault_PlaceString;
    NSString *newDomainName = [[NSUserDefaults standardUserDefaults] objectForKey:@"placeString"];
    if (newDomainName) {
        return newDomainName;
    }else{
        return domainName;
    }
}

- (NSString *)placeInstallString{
    
   NSString *placeInstallString = @"";
   return placeInstallString;
}

@end
