//
//  YoCelsiusRequestParameterSerializer.m
//  YoCelsius
//
//  Created by YouXianMing on 2017/11/8.
//  Copyright © 2017年 XianMingYou. All rights reserved.
//

#import "YoCelsiusRequestParameterSerializer.h"

static NSString *AppIdPrimal = @"8c0e04b52e6da9e67c51a102d6269a60";

@implementation YoCelsiusRequestParameterSerializer

- (id)serializeCallForParameter:(id)callForArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:callForArgument];
    params[@"APPID"]            = AppIdPrimal;
    
    return params;
}

@end
