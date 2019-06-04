//
//  SunsetView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "SunsetView.h"

@interface SundownConsiderStockTreasure : NSObject

@property (nonatomic) CGRect startOutRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect finishRect;

@end

@implementation SundownConsiderStockTreasure

@end

@interface sundownConsider ()

@property (nonatomic, strong) UIView                *upOpinion;
@property (nonatomic, strong) UIView                *dispiritedVista;
@property (nonatomic, strong) UIImageView           *sunVisualizeCatch;
@property (nonatomic, strong) SundownConsiderStockTreasure  *solarizeRangeSeeStoragePrise;
@property (nonatomic, strong) UIImageView           *sunMyungMoonRangeRegard;
@property (nonatomic, strong) SundownConsiderStockTreasure  *moonOnIconCatchStoreTreasure;
@property (nonatomic, strong) UIView                *lineOfCreditVista;

@end

@implementation sundownConsider

/**
 *  创建出view
 */
- (void)materialBodyAspect {
    
    self.upOpinion                     = [[UIView alloc] initWithFrame:self.improvingShoppingCentreRect];
    self.upOpinion.layer.masksToBounds = YES;
    [self addSubview:self.upOpinion];
    
    self.dispiritedVista                     = [[UIView alloc] initWithFrame:self.downcastFocusRect];
    self.dispiritedVista.layer.masksToBounds = YES;
    [self addSubview:self.dispiritedVista];
    
    // 创建出太阳的view并存储一些相关参数
    self.sunVisualizeCatch           = [[UIImageView alloc] initWithFrame:self.upOpinion.frame];
    self.sunVisualizeCatch.image     = [UIImage imageNamed:@"sun"];
    [self.upOpinion addSubview:self.sunVisualizeCatch];
    self.sunVisualizeCatch.alpha     = 0.f;
    self.solarizeRangeSeeStoragePrise = [SundownConsiderStockTreasure new];
    self.solarizeRangeSeeStoragePrise.startOutRect = self.sunVisualizeCatch.frame;
    self.sunVisualizeCatch.y                  += self.sunVisualizeCatch.height;
    self.solarizeRangeSeeStoragePrise.midRect   = self.sunVisualizeCatch.frame;
    self.sunVisualizeCatch.y                  += 10.f;
    self.solarizeRangeSeeStoragePrise.finishRect   = self.sunVisualizeCatch.frame;
    self.sunVisualizeCatch.frame = self.solarizeRangeSeeStoragePrise.startOutRect;
    
    // 创建出月亮的view并存储一些相关参数
    self.sunMyungMoonRangeRegard           = [[UIImageView alloc] initWithFrame:self.upOpinion.bounds];
    self.sunMyungMoonRangeRegard.image     = [UIImage imageNamed:@"moon"];
    self.sunMyungMoonRangeRegard.y        -= self.sunMyungMoonRangeRegard.height;
    [self.dispiritedVista addSubview:self.sunMyungMoonRangeRegard];
    self.moonOnIconCatchStoreTreasure = [SundownConsiderStockTreasure new];
    self.moonOnIconCatchStoreTreasure.startOutRect = self.sunMyungMoonRangeRegard.frame;
    self.sunMyungMoonRangeRegard.y                  += self.sunMyungMoonRangeRegard.height;
    self.moonOnIconCatchStoreTreasure.midRect   = self.sunMyungMoonRangeRegard.frame;
    self.sunMyungMoonRangeRegard.y                  += 10.f;
    self.moonOnIconCatchStoreTreasure.finishRect   = self.sunMyungMoonRangeRegard.frame;
    self.sunMyungMoonRangeRegard.frame = self.moonOnIconCatchStoreTreasure.startOutRect;
    self.sunMyungMoonRangeRegard.alpha = 0.f;
    
    // 中间的线条
    self.lineOfCreditVista                 = [[UIView alloc] initWithFrame:CGRectMake(0, self.height / 2.f, self.width, 1)];
    self.lineOfCreditVista.backgroundColor = COLOR_CIRCLE_;
    [self addSubview:self.lineOfCreditVista];
    self.lineOfCreditVista.alpha = 0.f;
}

/**
 *  显示动画
 *
 *  @param duration 动画时间
 */
- (void)appearanceWithLength:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.sunVisualizeCatch.frame = self.solarizeRangeSeeStoragePrise.midRect;
        self.sunVisualizeCatch.alpha = 1.f;
        
        self.sunMyungMoonRangeRegard.frame = self.moonOnIconCatchStoreTreasure.midRect;
        self.sunMyungMoonRangeRegard.alpha = 1.f;
        
        self.lineOfCreditVista.alpha = 1.f;
    }];
}

/**
 *  隐藏动画
 *
 *  @param duration 动画时间
 */
- (void)coverWithContinuance:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.sunVisualizeCatch.frame = self.solarizeRangeSeeStoragePrise.finishRect;
        self.sunVisualizeCatch.alpha = 0.f;
        
        self.sunMyungMoonRangeRegard.frame          = self.moonOnIconCatchStoreTreasure.finishRect;
        self.sunMyungMoonRangeRegard.alpha          = 0.f;
        self.dispiritedVista.layer.masksToBounds = NO;
        
        self.lineOfCreditVista.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.sunVisualizeCatch.frame  = self.solarizeRangeSeeStoragePrise.startOutRect;
        self.sunMyungMoonRangeRegard.frame = self.moonOnIconCatchStoreTreasure.startOutRect;
        self.dispiritedVista.layer.masksToBounds = YES;
    }];
}

@end
