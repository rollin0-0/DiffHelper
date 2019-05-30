//
//  XXXNewClass.m
//  iOSDifferHelperDemo
//
//  Created by rowling on 2019/5/27.
//  Copyright © 2019 BIO. All rights reserved.
//

#import "XXXNewClass.h"

@implementation XXXNewClass

- (NSString *)getNewUsername {
    
    if (![self YYY_username]) {
        
    }
    
    if (!_YYY_username) {
        [self setYYY_username:@""];
    }
    
    return self.YYY_username;
}

@end
