//
//  NetworkingInfo.h
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Network;

@interface NetworkingInfo : NSObject

@property (nonatomic, weak) Network *networking;

/**
 *  显示信息
 */
- (void)depictSubjectMatter;

@end
