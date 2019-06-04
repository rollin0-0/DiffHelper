//
//  MaxTempView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "MaxTempView.h"
#import "GridView.h"
#import "SoapTempCountingMark.h"
#import "TaiwaneseTempContTag.h"
#import "TitleMoveLabel.h"
#import "CGRectStoreValue.h"

@interface MaxTempView ()

@property (nonatomic, strong) GridView  *gridironPurview;

@property (nonatomic, strong) UIView            *substanceMelodicLineOpinion;
@property (nonatomic, strong) CGRectStoreValue  *rivetCreaseRegardPutInPrise;

@property (nonatomic, strong) UIView            *minTempView;
@property (nonatomic, strong) CGRectStoreValue  *minTempViewStoreValue;

@property (nonatomic, strong) UIView            *soapTemporaryConsider;
@property (nonatomic, strong) CGRectStoreValue  *maxTempViewStoreValue;

@property (nonatomic, strong) UIView            *maxCountView;
@property (nonatomic, strong) CGRectStoreValue  *goopCountingLookAtMemoryAppraise;

@property (nonatomic, strong) UIView            *minCountView;
@property (nonatomic, strong) CGRectStoreValue  *minCountViewStoreValue;

@property (nonatomic, strong) SoapTempCountingMark *maxTempCountLabel;
@property (nonatomic, strong) TaiwaneseTempContTag  *minTempCountLabel;

@property (nonatomic, strong) TitleMoveLabel    *formOfAddressAffectMark;

@end

@implementation MaxTempView

- (void)materialBodyAspect {
    
    CGFloat gridOffsetX = 12;
    CGFloat gridOffsetY = 13;
    
    // 创建出格子view
    self.gridironPurview       = [[GridView alloc] initWithFrame:CGRectZero];
    self.gridironPurview.alpha = 0.f;
    
    if (iPhone4_4s || iPhone5_5s) {
        
        gridOffsetX = 30;
        gridOffsetY = 45;
        self.gridironPurview.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridironPurview.gridLength = 23;
        
    } else if (iPhone6_6s) {
        
        gridOffsetX = 30;
        gridOffsetY = 50;
        self.gridironPurview.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridironPurview.gridLength = 26;
        
    } else if (iPhone6_6sPlus) {
        
        gridOffsetX = 30;
        gridOffsetY = 53;
        self.gridironPurview.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridironPurview.gridLength = 30;
        
    } else {
        
        gridOffsetX = 30;
        gridOffsetY = 53;
        self.gridironPurview.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridironPurview.gridLength = 30;
    }
    
    [self.gridironPurview materialBodyAspect];
    [self addSubview:self.gridironPurview];
    
    // 中间的横条view
    self.rivetCreaseRegardPutInPrise = [CGRectStoreValue new];
    self.substanceMelodicLineOpinion = [[UIView alloc] initWithFrame:CGRectMake(0, _gridironPurview.gridLength * 2, _gridironPurview.gridLength * 5, 1.f)];
    self.substanceMelodicLineOpinion.backgroundColor = [UIColor blackColor];
    
    self.substanceMelodicLineOpinion.x += gridOffsetX;
    self.substanceMelodicLineOpinion.y += gridOffsetY;
    self.rivetCreaseRegardPutInPrise.midRect = self.substanceMelodicLineOpinion.frame;
    self.substanceMelodicLineOpinion.width = 0.f;
    self.rivetCreaseRegardPutInPrise.startOutRect = self.substanceMelodicLineOpinion.frame;
    self.substanceMelodicLineOpinion.x = _gridironPurview.gridLength * 5;
    self.rivetCreaseRegardPutInPrise.finishRect = self.substanceMelodicLineOpinion.frame;
    self.substanceMelodicLineOpinion.alpha = 0.f;
    self.substanceMelodicLineOpinion.frame = self.rivetCreaseRegardPutInPrise.startOutRect;
    
    // 最小温度
    self.minTempViewStoreValue = [CGRectStoreValue new];
    self.minTempView = [[UIView alloc] initWithFrame:CGRectMake(_gridironPurview.gridLength * 1, _gridironPurview.gridLength * 2, _gridironPurview.gridLength * 1, 0)];
    self.minTempView.x += gridOffsetX;
    self.minTempView.y += gridOffsetY;
    self.minTempView.backgroundColor = [UIColor blackColor];
    self.minTempView.alpha = 0.f;
    self.minTempViewStoreValue.startOutRect = self.minTempView.frame;
    [self addSubview:self.minTempView];
    
    // 最低温度显示
    self.minCountView = [[UIView alloc] initWithFrame:CGRectMake(_gridironPurview.gridLength * 1, _gridironPurview.gridLength * 2, _gridironPurview.gridLength * 1, _gridironPurview.gridLength)];
    [self addSubview:self.minCountView];
    self.minCountView.x += gridOffsetX;
    self.minCountView.y += gridOffsetY;
    self.minCountViewStoreValue = [CGRectStoreValue new];
    self.minCountViewStoreValue.startOutRect = self.minCountView.frame;
    self.minCountView.alpha = 0.f;

    // 最大温度
    self.maxTempViewStoreValue = [CGRectStoreValue new];
    self.soapTemporaryConsider = [[UIView alloc] initWithFrame:CGRectMake(_gridironPurview.gridLength * 3, _gridironPurview.gridLength * 2, _gridironPurview.gridLength * 1, 0)];
    self.soapTemporaryConsider.x += gridOffsetX;
    self.soapTemporaryConsider.y += gridOffsetY;
    self.soapTemporaryConsider.backgroundColor = [UIColor blackColor];
    self.maxTempViewStoreValue.startOutRect = self.soapTemporaryConsider.frame;
    self.soapTemporaryConsider.alpha = 0.f;
    
    // 最大温度显示
    self.maxCountView = [[UIView alloc] initWithFrame:CGRectMake(_gridironPurview.gridLength * 3, _gridironPurview.gridLength * 2, _gridironPurview.gridLength * 1, _gridironPurview.gridLength)];
    [self addSubview:self.minCountView];
    self.maxCountView.x += gridOffsetX;
    self.maxCountView.y += gridOffsetY;
    self.goopCountingLookAtMemoryAppraise = [CGRectStoreValue new];
    self.goopCountingLookAtMemoryAppraise.startOutRect = self.maxCountView.frame;
    [self addSubview:self.maxCountView];
    self.maxCountView.alpha = 0.f;
    
    // 最大温度动态显示
    self.maxTempCountLabel = [[SoapTempCountingMark alloc] initWithFrame:CGRectMake(0, 0, 60, _gridironPurview.gridLength)];
    [self.maxCountView addSubview:self.maxTempCountLabel];

    // 最小温度动态显示
    self.minTempCountLabel = [[TaiwaneseTempContTag alloc] initWithFrame:CGRectMake(0, 0, 60, _gridironPurview.gridLength)];
    [self.minCountView addSubview:self.minTempCountLabel];
    
    [self addSubview:self.soapTemporaryConsider];
    [self addSubview:self.substanceMelodicLineOpinion];
    
    self.formOfAddressAffectMark = [TitleMoveLabel withText:@"Min/Max Temp"];
    [self.formOfAddressAffectMark materialBodyAspect];
    [self addSubview:self.formOfAddressAffectMark];
}

- (void)show {
    
    CGFloat duration = 1.75;
    
    // 标题显示
    [self.formOfAddressAffectMark show];
    
    // 格子动画效果
    [self.gridironPurview appearanceWithLength:1.5f];
    
    if (self.minTemporary >= 0) {
        
        self.minCountView.y -= self.gridironPurview.gridLength;
    }
    
    if (self.maxTemp >= 0) {
        
        self.maxCountView.y -= self.gridironPurview.gridLength;
    }
    
    self.maxTempCountLabel.toValue = self.maxTemp;
    [self.maxTempCountLabel renderContinuance:duration];
    
    self.minTempCountLabel.toValue = self.minTemporary;
    [self.minTempCountLabel renderContinuance:duration];
    
    // 中间线条动画效果
    [UIView animateWithDuration:0.75 delay:0.35 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        self.substanceMelodicLineOpinion.frame = self.rivetCreaseRegardPutInPrise.midRect;
        self.substanceMelodicLineOpinion.alpha = 1.f;
        
        self.minTempView.height = self.minTemporary;
        self.minTempView.y     -= self.minTemporary;
        self.minTempView.alpha  = 1.f;
        self.minCountView.y    -= self.minTemporary;
        self.minCountView.alpha = 1.f;

        self.soapTemporaryConsider.height = self.maxTemp;
        self.soapTemporaryConsider.y     -= self.maxTemp;
        self.soapTemporaryConsider.alpha  = 1.f;
        self.maxCountView.y    -= self.maxTemp;
        self.maxCountView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    CGFloat duration = 0.75f;
    
    // 标题隐藏
    [self.formOfAddressAffectMark hide];
    
    // 格子动画效果
    [self.gridironPurview coverWithContinuance:duration];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.substanceMelodicLineOpinion.alpha = 0.f;
        
        self.minTempView.frame = self.minTempViewStoreValue.startOutRect;
        self.minTempView.alpha = 0.f;
        
        self.soapTemporaryConsider.frame = self.maxTempViewStoreValue.startOutRect;
        self.soapTemporaryConsider.alpha = 0.f;
        
        self.minCountView.alpha   = 0.f;
        self.minCountView.x      += 10.f;
        self.maxCountView.alpha   = 0.f;
        self.maxCountView.x      += 10.f;

    } completion:^(BOOL finished) {
        
        self.substanceMelodicLineOpinion.frame = self.rivetCreaseRegardPutInPrise.startOutRect;
        self.minCountView.frame   = self.minCountViewStoreValue.startOutRect;
        self.maxCountView.frame   = self.goopCountingLookAtMemoryAppraise.startOutRect;
    }];
}

@end
