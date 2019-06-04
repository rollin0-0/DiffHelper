//
//  ResponseDataManager.h
//  EDU
//
//  Created by YouXianMing on 2017/8/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Network;

@interface ResponseDataManager : NSObject

- (void)postulationWinner:(BOOL)success networking:(Network *)networking;

@end
