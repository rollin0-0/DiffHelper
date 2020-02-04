




#import "JSONHTTPClient.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"

typedef void (^RequestResultBlock)(NSData *data, JSONModelError *error);

NSString* const kHTTPMethodGET = @"GET";
NSString* const kHTTPMethodPOST = @"POST";

NSString* const kContentTypeAutomatic    = @"jsonmodel/automatic";
NSString* const kContentTypeJSON         = @"application/json";
NSString* const kContentTypeWWWEncoded   = @"application/x-www-form-urlencoded";



static NSStringEncoding defaultTextEncoding = NSUTF8StringEncoding;
static NSURLRequestCachePolicy defaultCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

static int defaultTimeoutInSeconds = 60;


static NSMutableDictionary* requestHeaders = nil;


static NSString* requestContentType = nil;

@implementation JSONHTTPClient

+(void)initialize
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        requestHeaders = [NSMutableDictionary dictionary];
        requestContentType = kContentTypeAutomatic;
    });
}

+(NSMutableDictionary*)requestHeaders
{
    return requestHeaders;
}

+(void)setDefaultTextEncoding:(NSStringEncoding)encoding
{
    defaultTextEncoding = encoding;
}

+(void)setCachingPolicy:(NSURLRequestCachePolicy)policy
{
    defaultCachePolicy = policy;
}

+(void)setTimeoutInSeconds:(int)seconds
{
    defaultTimeoutInSeconds = seconds;
}

+(void)setRequestContentType:(NSString*)contentTypeString
{
    requestContentType = contentTypeString;
}

+(NSString*)contentTypeForRequestString:(NSString*)requestString
{
    
    NSString* contentType = requestContentType;

    if (requestString.length>0 && [contentType isEqualToString:kContentTypeAutomatic]) {
        
        NSString* firstAndLastChar = [NSString stringWithFormat:@"%@%@",
                                      [requestString substringToIndex:1],
                                      [requestString substringFromIndex: requestString.length -1]
                                      ];

        if ([firstAndLastChar isEqualToString:@"{}"] || [firstAndLastChar isEqualToString:@"[]"]) {
            
            contentType = kContentTypeJSON;
        } else {
            
            contentType = kContentTypeWWWEncoded;
        }
    }

    
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return [NSString stringWithFormat:@"%@; charset=%@", contentType, charset];
}

+(NSString*)urlEncode:(id<NSObject>)value
{
    
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [(NSNumber*)value stringValue];
    }

    NSAssert([value isKindOfClass:[NSString class]], @"request parameters can be only of NSString or NSNumber classes. '%@' is of class %@.", value, [value class]);

    NSString *str = (NSString *)value;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0 || __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_9
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

#else
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)str,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
#endif
}

+(void)requestDataFromURL:(NSURL*)url method:(NSString*)method requestBody:(NSData*)bodyData headers:(NSDictionary*)headers handler:(RequestResultBlock)handler
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url
                                                                cachePolicy: defaultCachePolicy
                                                            timeoutInterval: defaultTimeoutInSeconds];
    [request setHTTPMethod:method];

    if ([requestContentType isEqualToString:kContentTypeAutomatic]) {
        
        if (bodyData) {
            NSString *bodyString = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
            [request setValue: [self contentTypeForRequestString: bodyString] forHTTPHeaderField:@"Content-type"];
        }
    } else {
        
        [request setValue: requestContentType forHTTPHeaderField:@"Content-type"];
    }

    
    for (NSString* key in [requestHeaders allKeys]) {
        [request setValue:requestHeaders[key] forHTTPHeaderField:key];
    }

    
    for (NSString* key in [headers allKeys]) {
        [request setValue:headers[key] forHTTPHeaderField:key];
    }

    if (bodyData) {
        [request setHTTPBody: bodyData];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)bodyData.length] forHTTPHeaderField:@"Content-Length"];
    }

    void (^completionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *origResponse, NSError *origError) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)origResponse;
        JSONModelError *error = nil;

        
        if (origError) {
            error = [JSONModelError errorWithDomain:origError.domain code:origError.code userInfo:origError.userInfo];
        }

        
        if (error.code == NSURLErrorUserCancelledAuthentication) {
            response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:401 HTTPVersion:@"HTTP/1.1" headerFields:@{}];
        }

        
        if (!error && (response.statusCode >= 300 || response.statusCode < 200)) {
            error = [JSONModelError errorBadResponse];
        }

        
        if (error) {
            error.httpResponse = [response copy];
        }

        
        if (!data.length) {
            data = nil;
        }

        handler(data, error);
    };

    

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0 || __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_10
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
#else
    NSOperationQueue *queue = [NSOperationQueue new];

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        completionHandler(data, response, error);
    }];
#endif
}

+(void)requestDataFromURL:(NSURL*)url method:(NSString*)method params:(NSDictionary*)params headers:(NSDictionary*)headers handler:(RequestResultBlock)handler
{
    
    NSMutableString* paramsString = nil;

    if (params) {
        
        paramsString = [NSMutableString stringWithString:@""];
        for (NSString* key in [[params allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
            [paramsString appendFormat:@"%@=%@&", key, [self urlEncode:params[key]] ];
        }
        if ([paramsString hasSuffix:@"&"]) {
            paramsString = [[NSMutableString alloc] initWithString: [paramsString substringToIndex: paramsString.length-1]];
        }
    }

    
    if ([method isEqualToString:kHTTPMethodGET] && params) {

        
        url = [NSURL URLWithString:[NSString stringWithFormat: @"%@%@%@",
                                    [url absoluteString],
                                    [url query] ? @"&" : @"?",
                                    paramsString
                                    ]];
    }

    
    [self requestDataFromURL: url
                      method: method
                 requestBody: [method isEqualToString:kHTTPMethodPOST]?[paramsString dataUsingEncoding:NSUTF8StringEncoding]:nil
                     headers: headers
                       handler:handler];
}

+(void)JSONFromURLWithString:(NSString*)urlString method:(NSString*)method params:(NSDictionary*)params orBodyString:(NSString*)bodyString completion:(JSONObjectBlock)completeBlock
{
    [self JSONFromURLWithString:urlString
                         method:method
                         params:params
                   orBodyString:bodyString
                        headers:nil
                     completion:completeBlock];
}

+(void)JSONFromURLWithString:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params orBodyString:(NSString *)bodyString headers:(NSDictionary *)headers completion:(JSONObjectBlock)completeBlock
{
    [self JSONFromURLWithString:urlString
                         method:method
                         params:params
                     orBodyData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]
                        headers:headers
                     completion:completeBlock];
}

+(void)JSONFromURLWithString:(NSString*)urlString method:(NSString*)method params:(NSDictionary *)params orBodyData:(NSData*)bodyData headers:(NSDictionary*)headers completion:(JSONObjectBlock)completeBlock
{
    RequestResultBlock handler = ^(NSData *responseData, JSONModelError *error) {
        id jsonObject = nil;

        
        if (!responseData && !error) {
            
            error = [JSONModelError errorBadResponse];
        }

        
        if (error==nil) {
            
            
            if(responseData.length > 0)
            {
                
                jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
            }
        }
        
        else if (error && responseData && jsonObject==nil) {
            
            jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
            
            error.responseData = responseData;
        }

        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock(jsonObject, error);
            }
        });
    };

    NSURL *url = [NSURL URLWithString:urlString];

    if (bodyData) {
        [self requestDataFromURL:url method:method requestBody:bodyData headers:headers handler:handler];
    } else {
        [self requestDataFromURL:url method:method params:params headers:headers handler:handler];
    }
}

+(void)getJSONFromURLWithString:(NSString*)urlString completion:(JSONObjectBlock)completeBlock
{
    [self JSONFromURLWithString:urlString method:kHTTPMethodGET
                         params:nil
                   orBodyString:nil completion:^(id json, JSONModelError* e) {
                       if (completeBlock) completeBlock(json, e);
                   }];
}

+(void)getJSONFromURLWithString:(NSString*)urlString params:(NSDictionary*)params completion:(JSONObjectBlock)completeBlock
{
    [self JSONFromURLWithString:urlString method:kHTTPMethodGET
                         params:params
                   orBodyString:nil completion:^(id json, JSONModelError* e) {
                       if (completeBlock) completeBlock(json, e);
                   }];
}

+(void)postJSONFromURLWithString:(NSString*)urlString params:(NSDictionary*)params completion:(JSONObjectBlock)completeBlock
{
    [self JSONFromURLWithString:urlString method:kHTTPMethodPOST
                         params:params
                   orBodyString:nil completion:^(id json, JSONModelError* e) {
                       if (completeBlock) completeBlock(json, e);
                   }];

}

+(void)postJSONFromURLWithString:(NSString*)urlString bodyString:(NSString*)bodyString completion:(JSONObjectBlock)completeBlock
{
    [self JSONFromURLWithString:urlString method:kHTTPMethodPOST
                         params:nil
                   orBodyString:bodyString completion:^(id json, JSONModelError* e) {
                       if (completeBlock) completeBlock(json, e);
                   }];
}

+(void)postJSONFromURLWithString:(NSString*)urlString bodyData:(NSData*)bodyData completion:(JSONObjectBlock)completeBlock
{
    [self JSONFromURLWithString:urlString method:kHTTPMethodPOST
                         params:nil
                   orBodyString:[[NSString alloc] initWithData:bodyData encoding:defaultTextEncoding]
                                 completion:^(id json, JSONModelError* e) {
                       if (completeBlock) completeBlock(json, e);
                   }];
}

@end
