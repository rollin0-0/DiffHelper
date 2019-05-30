//
//  XXXNewClass.m
//  iOSDifferHelperDemo
//
//  Created by rowling on 2019/5/27.
//  Copyright © 2019 BIO. All rights reserved.
//

#import "IrisFreshlyFamily.h"

@implementation IrisFreshlyFamily

- (NSString *)getNewUsername {
    
    if (![self helloUsername]) {
        
    }
    
    if (!_helloUsername) {
        [self setHelloUsername:@""];
    }
    
    return self.helloUsername;
}

@end
