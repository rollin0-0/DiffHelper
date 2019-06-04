//
//  FailedLongPressView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/10.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "GiveOutLongPushHorizon.h"


@interface FailedLongPressViewStoreValue : NSObject

@property (nonatomic) CGRect startOutRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect finishRect;

@end

@implementation FailedLongPressViewStoreValue

@end

@interface GiveOutLongPushHorizon ()<PressAnimationButtonDelegate>

@property (nonatomic, strong) BloodlineBackgroundLookAt             *melodicPhraseBackgroundPerspective;

@property (nonatomic, strong) PressAnimationButton           *closetRelease;
@property (nonatomic, strong) FailedLongPressViewStoreValue  *pressButtonStoreValue;

@property (nonatomic, strong) UIImageView                    *iconView;
@property (nonatomic, strong) FailedLongPressViewStoreValue  *ikonSeeStorageRate;

@end

@implementation GiveOutLongPushHorizon

- (void)materialBodyAspect {
    
    // 封面图标
    self.iconView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover"]];
    self.iconView.height = 180;
    self.iconView.width  = 180;
    self.iconView.center = self.center;
    self.iconView.y     -= 100;
    [self addSubview:self.iconView];
    
    self.ikonSeeStorageRate           = [FailedLongPressViewStoreValue new];
    self.ikonSeeStorageRate.midRect   = self.iconView.frame;
    self.iconView.y                  -= 20;
    self.ikonSeeStorageRate.startOutRect = self.iconView.frame;
    self.iconView.y                  += 40;
    self.ikonSeeStorageRate.finishRect   = self.iconView.frame;
    self.iconView.frame               = self.ikonSeeStorageRate.startOutRect;
    self.iconView.alpha               = 0.f;

    // 背景view
    self.melodicPhraseBackgroundPerspective = [BloodlineBackgroundLookAt makeViewWithFrameIn:self.bounds
                                                            assemblyLineBreadth:4
                                                              bloodCol:4
                                                            bloodLineSemblance:[[UIColor blackColor] colorWithAlphaComponent:0.035]];
    [self addSubview:self.melodicPhraseBackgroundPerspective];
    
    // 长按按钮
    self.closetRelease = [[PressAnimationButton alloc] initWithFrame:CGRectMake(0, 0, Width - 30, 48)];
    [self addSubview:self.closetRelease];
    self.closetRelease.font               = [UIFont fontWithName:LATO_LIGHT size:20.f];
    self.closetRelease.layer.borderColor  = [UIColor blackColor].CGColor;
    self.closetRelease.patternTextbookVividness    = [UIColor blackColor];
    self.closetRelease.highlightingTextualMatterColouring = [UIColor whiteColor];
    self.closetRelease.layer.borderWidth  = 0.5f;
    self.closetRelease.spiritednessColor     = [UIColor blackColor];
    self.closetRelease.animationWidth     = Width - 110;
    self.closetRelease.text               = @"Long Press To Update";
    self.closetRelease.center             = self.center;
    self.closetRelease.y                  = self.height - 60;
    self.closetRelease.delegate           = self;
    
    self.pressButtonStoreValue           = [FailedLongPressViewStoreValue new];
    self.pressButtonStoreValue.midRect   = self.closetRelease.frame;
    self.closetRelease.y                  -= 20;
    self.pressButtonStoreValue.startOutRect = self.closetRelease.frame;
    self.closetRelease.y                  += 25;
    self.pressButtonStoreValue.finishRect   = self.closetRelease.frame;
    self.closetRelease.frame               = self.pressButtonStoreValue.startOutRect;
    self.closetRelease.alpha               = 0.f;
}

- (void)finishedEventWith:(PressAnimationButton *)button {
    
    NSLog(@"长按效果");
    if (_delegate && [_delegate respondsToSelector:@selector(pressEvent:)]) {
        
        [_delegate pressEvent:self];
    }
}

- (void)show {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.closetRelease.frame = self.pressButtonStoreValue.midRect;
        self.closetRelease.alpha = 1.f;
        
        self.iconView.frame    = self.ikonSeeStorageRate.midRect;
        self.iconView.alpha    = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.closetRelease.frame = self.pressButtonStoreValue.finishRect;
        self.closetRelease.alpha = 0.f;
        
        self.iconView.frame    = self.ikonSeeStorageRate.finishRect;
        self.iconView.alpha    = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.closetRelease.frame = self.pressButtonStoreValue.startOutRect;
        self.iconView.frame    = self.ikonSeeStorageRate.startOutRect;
    }];
}

- (void)getRidOf {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.melodicPhraseBackgroundPerspective.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

@end
