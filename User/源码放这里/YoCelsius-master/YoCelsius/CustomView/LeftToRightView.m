//
//  LeftToRightView.m
//  AnimatedLineView
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "LeftToRightView.h"

@implementation LeftToRightView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGFloat x      = frame.origin.x;
        CGFloat y      = frame.origin.y;
        CGFloat height = frame.size.height;
        CGFloat width  = frame.size.width;
        
        self.protrudeFraming = CGRectMake(x, y, 0, height);
        self.midPhysique   = CGRectMake(x, y, width, height);
        self.endFrame   = CGRectMake(x + width, y, 0, height);
        
        self.frame      = self.protrudeFraming;
    }
    
    return self;
}

- (void)show {
    
    // 动画
    [UIView animateWithDuration:self.meltToPointDuration animations:^{
        
        self.alpha = self.maxAlpha;
        self.frame = self.midPhysique;
    }];
}

- (void)hide {
    
    // 动画
    [UIView animateWithDuration:self.blowOverToEnshroudLength animations:^{
        
        self.alpha = 0.f;
        self.frame = self.endFrame;
        
    } completion:^(BOOL finished) {
        
        self.frame = self.protrudeFraming;
        self.alpha = 0.f;
    }];
}

@end
