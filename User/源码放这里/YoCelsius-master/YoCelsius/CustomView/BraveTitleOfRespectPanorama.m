//
//  WeatherTitleView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/23.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "BraveTitleOfRespectPanorama.h"
#import "ExchangeColourizeTag.h"

@interface EndureDeedWatchShopEsteem : NSObject

@property (nonatomic) CGRect startOutRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect finishRect;

@end

@implementation EndureDeedWatchShopEsteem

@end

@interface BraveTitleOfRespectPanorama ()

@property (nonatomic, strong) ExchangeColourizeTag            *changeColourationMark;
@property (nonatomic, strong) EndureDeedWatchShopEsteem  *changeColorLabelStoreValue;
@property (nonatomic, strong) UIView                      *cinqueStrain;
@property (nonatomic, strong) UIView                      *hLine;
@property (nonatomic, strong) UILabel                     *describInfoLabel;

@end

@implementation BraveTitleOfRespectPanorama

/**
 *  创建出view
 */
- (void)materialBodyAspect {
    
    // 颜色设置
    self.changeColourationMark              = [[ExchangeColourizeTag alloc] initWithFrame:CGRectMake(35 - 10, 23, 0, 0)];
    self.changeColourationMark.textColor    = [UIColor blackColor];
    self.changeColourationMark.changedColor = GlossVirgin;
    self.changeColourationMark.font         = [UIFont fontWithName:LatoUnconstipated size:24];
    [self.changeColourationMark updateTagCatch];
    [self.changeColourationMark colorPercent:0.f];
    self.changeColourationMark.alpha        = 0.f;
    [self addSubview:self.changeColourationMark];
    
    // 垂直的线条
    self.cinqueStrain = [[UIView alloc] initWithFrame:CGRectMake(17 - 5, 18, 6, 40)];
    self.cinqueStrain.backgroundColor = [UIColor blackColor];
    self.cinqueStrain.alpha           = 0.f;
    [self addSubview:self.cinqueStrain];
    
    // 水平的线条
    self.hLine                 = [[UIView alloc] initWithFrame:CGRectMake(17 + 10, self.cinqueStrain.y + self.cinqueStrain.height - 1, 200, 1)];
    self.hLine.alpha           = 0.f;
    self.hLine.backgroundColor = [UIColor blackColor];
    [self addSubview:self.hLine];
    
    // 天气描述信息
    self.describInfoLabel = [[UILabel alloc] initWithFrame:\
                             CGRectMake(17 + 10,
                                        self.cinqueStrain.y + self.cinqueStrain.height + 2,
                                        200,
                                        12)];
    self.describInfoLabel.textAlignment = NSTextAlignmentRight;
    self.describInfoLabel.textColor     = GlossVirgin;
    self.describInfoLabel.alpha         = 0.f;
    self.describInfoLabel.font          = [UIFont fontWithName:LatoSheer size:10.f];
    [self addSubview:self.describInfoLabel];
}

- (void)show {
    
    // 更新标题
    self.changeColourationMark.text = self.cityAppoint;
    [self.changeColourationMark updateTagCatch];
    [self.changeColourationMark colorPercent:0.f];
    
    CGFloat duration = 1.75f;
    
    // 获取天气描述信息
    self.describInfoLabel.text = self.weatherDescription;
    
    [UIView animateWithDuration:duration animations:^{
        
        // 城市名字信息
        self.changeColourationMark.x     = 35;
        self.changeColourationMark.alpha = 1.f;
        
        // 垂直的线条
        self.cinqueStrain.x     = 17;
        self.cinqueStrain.alpha = 1.f;
        
        // 水平的线条
        self.hLine.x     = 17;
        self.hLine.alpha = 1.f;
        
        // 天气描述信息
        self.describInfoLabel.x     = 17.f;
        self.describInfoLabel.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    // 动画时间
    CGFloat duration = 0.75f;
    
    [UIView animateWithDuration:duration animations:^{
        
        // 城市名字信息
        self.changeColourationMark.x     = 35 + 10;
        self.changeColourationMark.alpha = 0.f;
        
        // 垂直的线条
        self.cinqueStrain.x     = 17 + 5;
        self.cinqueStrain.alpha = 0.f;
        
        // 水平的线条
        self.hLine.x     = 17 - 5;
        self.hLine.alpha = 0.f;
        
        // 天气描述信息
        self.describInfoLabel.x     = 17.f - 10;
        self.describInfoLabel.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.changeColourationMark.x = 35 - 10;
        self.cinqueStrain.x            = 17 - 5;
        self.hLine.x            = 17 + 10;
        self.describInfoLabel.x = 17 + 10;
    }];
}

- (void)accessOffsetValue:(CGFloat)offsetValue {
    
    if (offsetValue <= 0) {
        
        CGFloat perCentum = -offsetValue / 100.f;
        [self.changeColourationMark colorPercent:perCentum];
        
        CGFloat tmpX  = - offsetValue;
        
        self.hLine.x  = 17.f + tmpX * 0.2;
        self.cinqueStrain.y  = 18.f + tmpX *0.1f;
        self.changeColourationMark.x = 35 + tmpX * 0.1;
        self.describInfoLabel.x = 17.f - tmpX * 0.05;
        
    } else {
        
        CGFloat perCentum = (64 - offsetValue) / 64.f;
        
        self.changeColourationMark.alpha = perCentum;
        self.hLine.alpha            = perCentum;
        self.cinqueStrain.alpha            = perCentum;
        self.describInfoLabel.alpha = perCentum;
    }
}

@end
