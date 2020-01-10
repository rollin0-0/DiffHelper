




#import "JSONAPI.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"

@interface JSONAPIRPCErrorModel: JSONModel
@property (assign, nonatomic) int code;
@property (strong, nonatomic) NSString* message;
@property (strong, nonatomic) id<Optional> data;
@end


static JSONAPI* sharedInstance = nil;

static long jsonRpcId = 0;


@interface JSONAPI ()
@property (strong, nonatomic) NSString* baseURLString;
@end


@implementation JSONAPI


+(void)initialize
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[JSONAPI alloc] init];
    });
}


+(void)setAPIBaseURLWithString:(NSString*)base
{
    sharedInstance.baseURLString = base;
}

+(void)setContentType:(NSString*)ctype
{
    [JSONHTTPClient setRequestContentType: ctype];
}

+(void)getWithPath:(NSString*)path andParams:(NSDictionary*)params completion:(JSONObjectBlock)completeBlock
{
    NSString* fullURL = [NSString stringWithFormat:@"%@%@", sharedInstance.baseURLString, path];

    [JSONHTTPClient getJSONFromURLWithString: fullURL params:params completion:^(NSDictionary *json, JSONModelError *e) {
        completeBlock(json, e);
    }];
}

+(void)postWithPath:(NSString*)path andParams:(NSDictionary*)params completion:(JSONObjectBlock)completeBlock
{
    NSString* fullURL = [NSString stringWithFormat:@"%@%@", sharedInstance.baseURLString, path];

    [JSONHTTPClient postJSONFromURLWithString: fullURL params:params completion:^(NSDictionary *json, JSONModelError *e) {
        completeBlock(json, e);
    }];
}

+(void)__rpcRequestWithObject:(id)jsonObject completion:(JSONObjectBlock)completeBlock
{

    NSData* jsonRequestData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                              options:kNilOptions
                                                                error:nil];
    NSString* jsonRequestString = [[NSString alloc] initWithData:jsonRequestData encoding: NSUTF8StringEncoding];

    NSAssert(sharedInstance.baseURLString, @"API base URL not set");
    [JSONHTTPClient postJSONFromURLWithString: sharedInstance.baseURLString
                                   bodyString: jsonRequestString
                                   completion:^(NSDictionary *json, JSONModelError* e) {

                                       if (completeBlock) {
                                           
                                           NSDictionary* result = json[@"result"];

                                           if (!result) {
                                               JSONAPIRPCErrorModel* error = [[JSONAPIRPCErrorModel alloc] initWithDictionary:json[@"error"] error:nil];
                                               if (error) {
                                                   
                                                   if (!error.message) error.message = @"Generic json rpc error";
                                                   e = [JSONModelError errorWithDomain:JSONModelErrorDomain
                                                                                  code:error.code
                                                                              userInfo: @{ NSLocalizedDescriptionKey : error.message}];
                                               } else {
                                                   
                                                   e = [JSONModelError errorBadResponse];
                                               }
                                           }

                                           
                                           completeBlock(result, e);
                                       }
                                   }];
}

+(void)rpcWithMethodName:(NSString*)method andArguments:(NSArray*)args completion:(JSONObjectBlock)completeBlock
{
    NSAssert(method, @"No method specified");
    if (!args) args = @[];

    [self __rpcRequestWithObject:@{
                                  
                                  @"id": @(++jsonRpcId),
                                  @"params": args,
                                  @"method": method
     } completion:completeBlock];
}

+(void)rpc2WithMethodName:(NSString*)method andParams:(id)params completion:(JSONObjectBlock)completeBlock
{
    NSAssert(method, @"No method specified");
    if (!params) params = @[];

    [self __rpcRequestWithObject:@{
                                  
                                  @"jsonrpc": @"2.0",
                                  @"id": @(++jsonRpcId),
                                  @"params": params,
                                  @"method": method
     } completion:completeBlock];
}

@end

@implementation JSONAPIRPCErrorModel
@end
