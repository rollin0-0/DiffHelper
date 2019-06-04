//
//  Networking+YoCelsius.h
//  YoCelsius
//
//  Created by YouXianMing on 2017/11/8.
//  Copyright © 2017年 XianMingYou. All rights reserved.
//

#import "Network.h"

static NSString *baseURL = @"http://api.openweathermap.org/data/2.5";

typedef enum : NSUInteger {
    
    kWeather = 1000,
    kForecastDaily,
    
} ENetworkConfigTagValue;

#pragma mark - NetworkConfig

@interface NetworkConfig : NSObject

@property (nonatomic, strong) NSString           *uRLThread;
@property (nonatomic, strong) NSString           *functionName;
@property (nonatomic)         NSInteger           tag;
@property (nonatomic)         TocopherolNetworkMethod   method;

@end

/**
 *  [GET] Current Weather Request.  (/weather)
 */
static inline NetworkConfig *weather() {
    
    NetworkConfig *config = [NetworkConfig new];
    config.uRLThread      = [baseURL stringByAppendingString:@"/weather"];
    config.functionName   = @"Current Weather Request.";
    config.tag            = kWeather;
    config.method         = kNetworkingGET;
    
    return config;
}

/**
 *  [GET] Forecast Daily.  (/forecast/daily)
 */
static inline NetworkConfig *forecastDaily() {
    
    NetworkConfig *config = [NetworkConfig new];
    config.uRLThread      = [baseURL stringByAppendingString:@"/forecast/daily"];
    config.functionName   = @"Forecast Daily.";
    config.tag            = kForecastDaily;
    config.method         = kNetworkingGET;
    
    return config;
}

@interface Network (YoCelsius)

+ (instancetype)networkWithWebConfig:(NetworkConfig *)config callForArgument:(id)callForArgument delegate:(id <NetworkingDelegate>)delegate;

@end
