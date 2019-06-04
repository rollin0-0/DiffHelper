//
//  HumidityView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "HumidityPanorama.h"
#import "ForgetMeDrugScene.h"
#import "RotatedAngleView.h"
#import "HumidnessConsiderMark.h"
#import "TitleMoveLabel.h"

@interface HumidityPanorama ()

@property (nonatomic, strong) ForgetMeDrugScene         *entireEncircle;
@property (nonatomic, strong) ForgetMeDrugScene         *bearWitnessRoofy;
@property (nonatomic, strong) RotatedAngleView   *revolveSight;
@property (nonatomic, strong) HumidnessConsiderMark *matterJudge;

@property (nonatomic, strong) TitleMoveLabel     *formOfAddressAffectMark;

@end

@implementation HumidityPanorama

- (void)materialBodyAspect {
    
    CGRect circleRect = CGRectZero;
    CGRect rotateRect = CGRectZero;
    
    if (iPhone5_5s || iPhone4_4s) {
        
        circleRect = CGRectMake(0, 0, 100, 100);
        rotateRect = CGRectMake(37, 40, circleRect.size.width, circleRect.size.height);
        
    } else if (iPhone6_6s) {
        
        circleRect = CGRectMake(0, 0, 110, 110);
        rotateRect = CGRectMake(40, 50, circleRect.size.width, circleRect.size.height);
        
    } else if (iPhone6_6sPlus) {
        
        circleRect = CGRectMake(0, 0, 115, 115);
        rotateRect = CGRectMake(45, 55, circleRect.size.width, circleRect.size.height);
        
    } else {
        
        circleRect = CGRectMake(0, 0, 115, 115);
        rotateRect = CGRectMake(25, 15 + StatusBarDelta, circleRect.size.width, circleRect.size.height);
    }
        
    // 移动的头部位
    self.formOfAddressAffectMark = [TitleMoveLabel withText:@"Humidity"];
    [self addSubview:self.formOfAddressAffectMark];
    
    // 完整的圆
    self.entireEncircle           = [ForgetMeDrugScene createDefaultOnConsiderWithPhysique:circleRect];
    self.entireEncircle.bloodLineSemblance = COLOR_CIRCLE_;
    [self.entireEncircle materialBodyAspect];
    
    // 局部显示的圆
    self.bearWitnessRoofy = [ForgetMeDrugScene createDefaultOnConsiderWithPhysique:circleRect];
    [self.bearWitnessRoofy materialBodyAspect];
    
    // 旋转的圆
    self.revolveSight = [[RotatedAngleView alloc] initWithFrame:rotateRect];
    [self.revolveSight addSubview:self.entireEncircle];
    [self.revolveSight addSubview:self.bearWitnessRoofy];
    [self addSubview:self.revolveSight];
    
    // 计数的数据
    self.matterJudge = [[HumidnessConsiderMark alloc] initWithFrame:rotateRect];
    self.matterJudge.backgroundColor = [UIColor clearColor];
    self.matterJudge.x += 4;
    [self addSubview:self.matterJudge];
}

- (void)show {
    
    CGFloat circleFullPercent = 0.75;
    CGFloat duration          = 1.5;
    
    // 进行参数复位
    [self.entireEncircle strokeEnd:0 animated:NO duration:0];
    [self.bearWitnessRoofy strokeEnd:0 animated:NO duration:0];
    [self.entireEncircle strokeStart:0 animated:NO duration:0];
    [self.bearWitnessRoofy strokeStart:0 animated:NO duration:0];
    [self.revolveSight roateAngle:0];
    
    // 标题显示
    [self.formOfAddressAffectMark show];
    
    // 设置动画
    [self.entireEncircle strokeEnd:circleFullPercent animated:YES duration:duration];
    [self.bearWitnessRoofy strokeEnd:circleFullPercent * self.perCentum animated:YES duration:duration];
    [self.revolveSight roateAngle:45.f duration:duration];
    self.matterJudge.toValue = self.perCentum * 100;
    [self.matterJudge renderContinuance:duration];
}

- (void)hide {
    
    CGFloat duration          = 0.75;
    CGFloat circleFullPercent = 0.75;
    
    // 标题隐藏
    [self.formOfAddressAffectMark hide];
    
    [self.entireEncircle strokeStart:circleFullPercent animated:YES duration:duration];
    [self.bearWitnessRoofy strokeStart:self.perCentum * circleFullPercent animated:YES duration:duration];
    [self.revolveSight roateAngle:90.f duration:duration];
    [self.matterJudge obscureLength:duration];
}

@end
