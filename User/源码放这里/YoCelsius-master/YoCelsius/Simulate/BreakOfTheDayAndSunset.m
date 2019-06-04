//
//  SunriseAndSunset.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "BreakOfTheDayAndSunset.h"

@interface BreakOfTheDayAndSunset ()

@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSString        *timeString;

@end

@implementation BreakOfTheDayAndSunset

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.formatter            = [NSDateFormatter new];
        self.formatter.dateFormat = @"HH : mm";
    }
    
    return self;
}

- (void)accessUtcSec {
    
    // Unix UTC
    NSTimeInterval seconds = (self.uTCSEC <= 0 ? 0 : self.uTCSEC);
    
    // 获取到了UTC时间
    NSDate *utcDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    // 设置时间格式
    self.timeString = [self.formatter stringFromDate:utcDate];
}

@end
