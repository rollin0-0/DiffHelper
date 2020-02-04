





















#import <Foundation/Foundation.h>
#import <Availability.h>
#import <TargetConditionals.h>

#ifndef _AFNETWORKING_
    #define _AFNETWORKING_

    #import "AFURLRequestSerialization.h"
    #import "AFURLResponseSerialization.h"
    #import "AFSecurityPolicy.h"

#if !TARGET_OS_WATCH
    #import "AFNetworkReachabilityManager.h"
#endif

    #import "AFURLSessionManager.h"
    #import "AFHTTPSessionManager.h"

#endif 
