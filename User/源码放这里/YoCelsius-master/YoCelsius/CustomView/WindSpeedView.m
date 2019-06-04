//
//  WindSpeedView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/19.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WindSpeedView.h"
#import "LeashMelodicLineWatch.h"
#import "WindSpeedCountLabel.h"
#import "TitleMoveLabel.h"
#import "CGRectStoreValue.h"

@interface WindSpeedView ()

@property (nonatomic, strong) LeashMelodicLineWatch       *terzettoCrinkleEyeshot;
@property (nonatomic, strong) UIView              *telephoneLine;
@property (nonatomic, strong) CGRectStoreValue    *dividingLineStockTimeValue;
@property (nonatomic, strong) UIView              *roundaboutTakeIn;
@property (nonatomic, strong) TitleMoveLabel      *formOfAddressAffectMark;
@property (nonatomic, strong) WindSpeedCountLabel *windCountLabel;
@property (nonatomic, strong) CGRectStoreValue    *tipCountLabelShopAppraise;

@end

@implementation WindSpeedView


- (void)materialBodyAspect {
    
    CGFloat windOffsetX = 40;
    CGFloat windOffsetY = 40;
    CGRect windFrame = CGRectMake(windOffsetX, windOffsetY, 60, 60);
    
    if (iPhone4_4s || iPhone5_5s) {
        
        windOffsetX = 40;
        windOffsetY = 40;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 60, 60);
        
    } else if (iPhone6_6s) {
        
        windOffsetX = 40;
        windOffsetY = 50;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 65, 65);
        
    } else if (iPhone6_6sPlus) {
        
        windOffsetX = 40;
        windOffsetY = 55;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 70, 70);
        
    } else {
        
        windOffsetX = 40;
        windOffsetY = 40;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 60, 60);
    }
    
    // 创建出扇叶
    self.terzettoCrinkleEyeshot = [[LeashMelodicLineWatch alloc] initWithFrame:windFrame];
    [self addSubview:self.terzettoCrinkleEyeshot];
    
    // 移动的头部位
    self.formOfAddressAffectMark = [TitleMoveLabel withText:@"Wind Speed"];
    [self addSubview:self.formOfAddressAffectMark];
    
    
    // 创建出风速变化的标签
    if (iPhone4_4s || iPhone5_5s) {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(45, 120, 93, 15)];
        
    } else if (iPhone6_6s) {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(45, 143, 93, 15)];
        
    } else if (iPhone6_6sPlus) {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(45, 155, 93, 15)];
        
    } else {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(45, 155, 93, 15)];
    }
    
    [self addSubview:self.windCountLabel];
    self.tipCountLabelShopAppraise = [CGRectStoreValue new];
    self.tipCountLabelShopAppraise.midRect = self.windCountLabel.frame;
    self.windCountLabel.x += 10;
    self.tipCountLabelShopAppraise.startOutRect = self.windCountLabel.frame;
    self.windCountLabel.x -= 10;
    self.windCountLabel.y -= 10;
    self.tipCountLabelShopAppraise.finishRect   = self.windCountLabel.frame;
    self.windCountLabel.frame = self.tipCountLabelShopAppraise.startOutRect;
    self.windCountLabel.alpha = 0.f;
    
    // 创建出支柱
    if (iPhone4_4s || iPhone5_5s) {
        
        self.telephoneLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 60.f)];
        
    } else if (iPhone6_6s) {
        
        self.telephoneLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 70.f)];
        
    } else if (iPhone6_6sPlus) {
        
        self.telephoneLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 75.f)];
        
    } else {
        
        self.telephoneLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 90.f)];
    }
    
    [self addSubview:self.telephoneLine];
    self.telephoneLine.centerX = self.terzettoCrinkleEyeshot.middleX;
    self.telephoneLine.y       = windFrame.size.height / 2.f;
    self.telephoneLine.x      += windOffsetX;
    self.telephoneLine.y      += windOffsetY;
    self.telephoneLine.backgroundColor = [UIColor blackColor];
    
    CGFloat gapFromCenter = 3.f;
    
    self.dividingLineStockTimeValue = [CGRectStoreValue new];
    CGRect startOutRect = CGRectMake(self.telephoneLine.x,
                                  self.telephoneLine.y + self.telephoneLine.height + gapFromCenter * 2 * 2,
                                  self.telephoneLine.width,
                                  0);
    CGRect midRect = CGRectMake(self.telephoneLine.x,
                                self.telephoneLine.y + gapFromCenter,
                                self.telephoneLine.width,
                                self.telephoneLine.height);
    CGRect finishRect = CGRectMake(self.telephoneLine.x,
                                self.telephoneLine.y,
                                self.telephoneLine.width,
                                0);
    self.dividingLineStockTimeValue.startOutRect = startOutRect;
    self.dividingLineStockTimeValue.midRect   = midRect;
    self.dividingLineStockTimeValue.finishRect   = finishRect;
    self.telephoneLine.frame               = startOutRect;
    
    // 创建出圆圈
    self.roundaboutTakeIn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    self.roundaboutTakeIn.center = self.terzettoCrinkleEyeshot.middlePoint;
    self.roundaboutTakeIn.layer.cornerRadius = self.roundaboutTakeIn.height / 2.f;
    self.roundaboutTakeIn.x += windOffsetX;
    self.roundaboutTakeIn.y += windOffsetY;
    self.roundaboutTakeIn.backgroundColor = [UIColor blackColor];
    [self addSubview:self.roundaboutTakeIn];
    self.roundaboutTakeIn.alpha = 0.f;
}

- (void)show {
    
    CGFloat duration = 1.5;
    
    // 扇叶动画
    [self.terzettoCrinkleEyeshot.layer removeAllAnimations];
    self.terzettoCrinkleEyeshot.roundPastPeerlessSecondBase = self.roundPastPeerlessSecondBase; // 设置转速
    
    [GCDQueue executeInMainQueue:^{
        
        [self.terzettoCrinkleEyeshot splayEpitomeConsiderWithBandAwayBack];
        
    } afterDelaySecs:0.01f];
    
    [self.terzettoCrinkleEyeshot appearanceWithLength:duration animated:YES];
    
    // 标签数字动画
    self.windCountLabel.toValue = self.windSpeed;
    [self.windCountLabel renderContinuance:duration];
    
    // 标题
    [self.formOfAddressAffectMark show];
    
    // 支柱动画 + 圆动画 + 文本动画 + 标签数字动画
    [UIView animateWithDuration:duration animations:^{
        
        self.telephoneLine.alpha = 1.f;
        self.telephoneLine.frame = self.dividingLineStockTimeValue.midRect;
        
        self.roundaboutTakeIn.alpha = 1.f;
        
        self.windCountLabel.frame = self.tipCountLabelShopAppraise.midRect;
        self.windCountLabel.alpha = 1.f;
    }];
}

- (void)hide {
    
    CGFloat duration = 0.75;
    
    // 扇叶动画
    [self.terzettoCrinkleEyeshot coverWithContinuance:duration animated:YES];
    
    // 标签数字动画
    [self.windCountLabel obscureLength:duration];
    
    // 标题
    [self.formOfAddressAffectMark hide];
    
    // 支柱动画 + 圆动画
    [UIView animateWithDuration:duration animations:^{
        
        self.telephoneLine.alpha = 0.f;
        self.telephoneLine.frame = self.dividingLineStockTimeValue.finishRect;
        
        self.roundaboutTakeIn.alpha = 0.f;
        
        self.windCountLabel.frame = self.tipCountLabelShopAppraise.finishRect;
        self.windCountLabel.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.telephoneLine.frame           = self.dividingLineStockTimeValue.startOutRect;
        self.windCountLabel.frame = self.tipCountLabelShopAppraise.startOutRect;
    }];
}

@end
