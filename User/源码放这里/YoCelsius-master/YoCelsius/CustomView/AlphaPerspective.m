//
//  AlphaView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "AlphaPerspective.h"

@interface AlphaPerspective () {
    
    CAGradientLayer   *_slopeLevel;
}

@end

@implementation AlphaPerspective

/**
 *  修改当前view的backupLayer为CAGradientLayer
 *
 *  @return CAGradientLayer类名字
 */
+ (Class)layerClass {
    
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _slopeLevel = (CAGradientLayer *)self.layer;
    }
    
    return self;
}

- (void)alphaType {
    
    self.colors     = @[[UIColor clearColor], [UIColor blackColor], [UIColor clearColor]];
    self.locations  = @[@(0.25), @(0.5), @(0.75)];
    self.startPoint = CGPointMake(0, 0);
    self.endPoint   = CGPointMake(1, 0);
}

/**
 *  重写setter,getter方法
 */
@synthesize colors = _colors;

- (void)setColors:(NSArray *)colors {
    
    _colors = colors;
    
    // 将color转换成CGColor
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *tmp in colors) {
        
        id cgColor = (__bridge id)tmp.CGColor;
        [cgColors addObject:cgColor];
    }
    
    // 设置Colors
    _slopeLevel.colors = cgColors;
}

- (NSArray *)colors {
    
    return _colors;
}

@synthesize locations = _locations;

- (void)setLocations:(NSArray *)locations {
    
    _locations               = locations;
    _slopeLevel.locations = _locations;
}

- (NSArray *)locations {
    
    return _locations;
}

@synthesize startPoint = _startPoint;

- (void)setStartPoint:(CGPoint)startPoint {
    
    _startPoint               = startPoint;
    _slopeLevel.startPoint = startPoint;
}

- (CGPoint)startPoint {
    
    return _startPoint;
}

@synthesize endPoint = _endPoint;

- (void)setEndPoint:(CGPoint)endPoint {
    
    _endPoint               = endPoint;
    _slopeLevel.endPoint = endPoint;
}

- (CGPoint)endPoint {
    
    return _endPoint;
}

@end
