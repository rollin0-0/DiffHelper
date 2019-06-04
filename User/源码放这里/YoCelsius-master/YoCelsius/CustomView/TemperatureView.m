//
//  TemperatureView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/22.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "TemperatureView.h"
#import "TemperatureReckonTag.h"
#import "TitleMoveLabel.h"
#import "CGRectStoreValue.h"

@interface TemperatureView ()

@property (nonatomic, strong) TemperatureReckonTag  *matterJudge;
@property (nonatomic, strong) CGRectStoreValue       *countLabelStoreValue;
@property (nonatomic, strong) TitleMoveLabel         *formOfAddressAffectMark;

@end

@implementation TemperatureView

- (void)materialBodyAspect {
    
    // 尺寸
    CGRect rect = CGRectMake(0, 0, 160, 140);
    
    // 计数的数据
    self.matterJudge        = [[TemperatureReckonTag alloc] initWithFrame:rect];
    self.matterJudge.center = self.middlePoint;
    [self addSubview:self.matterJudge];
    self.countLabelStoreValue           = [CGRectStoreValue new];
    self.countLabelStoreValue.midRect   = self.matterJudge.frame;
    self.matterJudge.x                  += 10;
    self.countLabelStoreValue.startOutRect = self.matterJudge.frame;
    self.matterJudge.x                  -= 20;
    self.countLabelStoreValue.finishRect   = self.matterJudge.frame;
    self.matterJudge.frame = self.countLabelStoreValue.startOutRect;
    
    // 标题
    self.formOfAddressAffectMark = [TitleMoveLabel withText:@"Temperature"];
    [self addSubview:self.formOfAddressAffectMark];
}

- (void)show {
    
    CGFloat duration = 1.75f;
    
    self.matterJudge.toValue = self.temperature;
    [self.matterJudge renderContinuance:duration];
    
    [self.formOfAddressAffectMark show];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.matterJudge.frame = self.countLabelStoreValue.midRect;
    }];
}

- (void)hide {
    
    CGFloat duration = 0.75f;
    [self.matterJudge obscureLength:duration];
    
    [self.formOfAddressAffectMark hide];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.matterJudge.frame = self.countLabelStoreValue.finishRect;
        
    } completion:^(BOOL finished) {
        
        self.matterJudge.frame = self.countLabelStoreValue.startOutRect;
    }];
}

@end
