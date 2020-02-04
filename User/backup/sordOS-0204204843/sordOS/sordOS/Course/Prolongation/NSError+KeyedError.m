







#import "NSError+KeyedError.h"

@implementation NSError (KeyedError)

+ (NSError *)errorWithReponse:(NSDictionary *)response{
    NSString *descr = [response objectForKey:@"extend"] ? [response objectForKey:@"extend"] : @"";
    NSInteger errorCode = [response objectForKey:@"fairly"] ? [[response objectForKey:@"fairly"] integerValue] : 9527;
    NSError *jd_error = [NSError errorWithDomain:NSNetServicesErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:descr}];
    return jd_error;
}

@end
