//
//  Networking+YoCelsius.m
//  YoCelsius
//
//  Created by YouXianMing on 2017/11/8.
//  Copyright © 2017年 XianMingYou. All rights reserved.
//

#import "Network+YoCelsius.h"
#import "YoCelsiusRequestParameterSerializer.h"
#import "YoCelsiusNetworkingInfo.h"

@implementation NetworkConfig

@end

@implementation Network (YoCelsius)

+ (instancetype)networkWithWebConfig:(NetworkConfig *)config callForArgument:(id)callForArgument delegate:(id <NetworkingDelegate>)delegate {
    
    Network *networking = [Network networkWithURLDrawstring:config.uRLThread
                                                callForArgument:callForArgument
                                                          method:config.method
                                      requestParameterSerializer:[YoCelsiusRequestParameterSerializer new]
                                          responseDataSerializer:nil
                                       constructingBodyWithBlock:nil
                                                        progress:nil
                                                             tag:config.tag
                                                        delegate:delegate
                                               requestSerializer:[AFHTTPRequestSerializer serializer]
                                              responseSerializer:[AFJSONResponseSerializer serializer]];
    networking.timeoutInterval = @(8.f);
    networking.overhaulInfo     = config.functionName;
    networking.networkInformation  = [YoCelsiusNetworkingInfo new];
    
    return networking;
}

@end
