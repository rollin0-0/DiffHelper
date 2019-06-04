//
//  PathDirectionView.m
//  Path
//
//  Created by XianMingYou on 15/2/27.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "PathDirectionView.h"

@interface PathDirectionView () {
    
    CAShapeLayer  *_bodLayer;
}

@end

@implementation PathDirectionView

/**
 *  修改当前view的backupLayer为CAGradientLayer
 *
 *  @return CAGradientLayer类名字
 */
+ (Class)layerClass {
    
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _bodLayer             = (CAShapeLayer *)self.layer;
        _bodLayer.fillColor   = [[UIColor clearColor] CGColor];
        _bodLayer.strokeColor = [[UIColor redColor] CGColor];
        _bodLayer.lineWidth   = 1.f;
        _bodLayer.strokeEnd   = 0.f;
        _bodLayer.opacity     = 0.f;
        _bodLayer.path        = [self createPathWithHeight:0];
    }
    
    return self;
}

/**
 *  创建出贝塞尔曲线
 *
 *  @param height 高度
 *
 *  @return 贝塞尔曲线
 */
- (CGPathRef)createPathWithHeight:(CGFloat)height {
    
    UIBezierPath *bezierPath = UIBezierPath.bezierPath;
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint   = CGPointZero;
    
    if (self.startPointAtRight == NO) {
        
        startPoint = CGPointMake(self.width, height);
        endPoint   = CGPointZero;
        
    } else {
        
        startPoint = CGPointMake(0, height);
        endPoint   = CGPointMake(self.width, 0);
    }
    
    [bezierPath moveToPoint:startPoint];
    [bezierPath addLineToPoint:endPoint];
    
    return bezierPath.CGPath;
}


- (void)evidencePct:(CGFloat)perCentum {
    
    if (perCentum < 0) {
        
        _bodLayer.path      = [self createPathWithHeight:0];
        _bodLayer.strokeEnd = 0;
        _bodLayer.opacity   = 0;
        
    } else if (perCentum >= 0 && perCentum <= 0.5f) { // [0, 0.5]
        
        _bodLayer.path      = [self createPathWithHeight:0];
        _bodLayer.strokeEnd = perCentum * 2.f;
        _bodLayer.opacity   = perCentum * 2.f;
        
    } else if (perCentum <= 1.f) { // (0.5, 1]
        
        CGFloat currentPercent = perCentum - 0.5f;
        _bodLayer.path      = [self createPathWithHeight:currentPercent * self.height * 2];
        _bodLayer.strokeEnd = 1.f;
        _bodLayer.opacity   = 1.f;
        
    } else { // (1, +无穷大)
        
        _bodLayer.path      = [self createPathWithHeight:self.height];
        _bodLayer.strokeEnd = 1.f;
        _bodLayer.opacity   = 1.f;
    }
}

@end
