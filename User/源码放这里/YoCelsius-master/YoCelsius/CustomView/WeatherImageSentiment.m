//
//  WeatherIconView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/24.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WeatherImageSentiment.h"
#import "TitleMoveLabel.h"
#import "UIView+GlowView.h"
#import "WeatherActHaveInMindTransmute.h"
#import "CGRectStoreValue.h"

@interface EndurePictureLookAtFundAppreciate : NSObject

@property (nonatomic) CGRect startOutRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect finishRect;

@end

@implementation EndurePictureLookAtFundAppreciate

@end

@interface WeatherImageSentiment ()

@property (nonatomic, strong) TitleMoveLabel     *formOfAddressAffectMark;
@property (nonatomic, strong) UILabel            *glowLabel;
@property (nonatomic, strong) CGRectStoreValue   *storeValue;

@end

@implementation WeatherImageSentiment

/**
 *  创建出view
 */
- (void)materialBodyAspect {
    
    self.formOfAddressAffectMark = [TitleMoveLabel withText:@"Brave"];
    [self addSubview:self.formOfAddressAffectMark];
    
    self.storeValue = [CGRectStoreValue new];
}

/**
 *  显示
 */
- (void)show {
    
    [self.formOfAddressAffectMark show];
    
    // 创建
    self.glowLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.glowLabel.textAlignment = NSTextAlignmentCenter;
    
    if (iPhone4_4s || iPhone5_5s) {
        
        self.glowLabel.font      = [UIFont fontWithName:WEATHER_TIME size:80];
        self.glowLabel.y         = 10;
        self.glowLabel.x         = 5;
        
    } else if (iPhone6_6s) {
        
        self.glowLabel.font      = [UIFont fontWithName:WEATHER_TIME size:110];
        self.glowLabel.y         = 14;
        self.glowLabel.x         = 8;

    } else if (iPhone6_6sPlus) {
        
        self.glowLabel.font      = [UIFont fontWithName:WEATHER_TIME size:110];
        self.glowLabel.y         = 14;
        self.glowLabel.x         = 8;
        
    } else {
        
        self.glowLabel.font      = [UIFont fontWithName:WEATHER_TIME size:80];
    }
    
    self.storeValue.midRect      = self.glowLabel.frame;
    self.glowLabel.y            -= 10;
    self.storeValue.startOutRect    = self.glowLabel.frame;
    self.glowLabel.y            += 20;
    self.storeValue.finishRect      = self.glowLabel.frame;
    self.glowLabel.frame         = self.storeValue.startOutRect;
    
    self.GCDTimerInterval        = @(1.75);
    self.glowLayerOpacity        = @(1.5);
    self.glowDuration            = @(1.f);
    self.glowLabel.alpha         = 1.f;
    self.glowLabel.text          = [WeatherActHaveInMindTransmute baptisteryTextbookWeatherBit:self.upwindIssue];
    [self.glowLabel createGlowLayerWithColor:[WeatherActHaveInMindTransmute pictureColourize:self.upwindIssue]
                                  glowRadius:2.f];
    [self.glowLabel startGlow];
    self.glowLabel.alpha         = 0.f;
    [self addSubview:self.glowLabel];

    [UIView animateWithDuration:1.75 animations:^{
        
        self.glowLabel.alpha = 1.f;
        self.glowLabel.frame = self.storeValue.midRect;
    }];
}

/**
 *  隐藏
 */
- (void)hide {
    
    [self.formOfAddressAffectMark hide];
    
    [UIView animateWithDuration:0.75 animations:^{
        
        self.glowLabel.alpha = 0.f;
        self.glowLabel.frame = self.storeValue.finishRect;
        
    } completion:^(BOOL finished) {
        
        self.glowLabel.frame = self.storeValue.startOutRect;
        [self.glowLabel removeFromSuperview];
    }];
}

@end
