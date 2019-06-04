//
//  ShapeWordView.m
//  PathWord
//
//  Created by XianMingYou on 15/3/6.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "MoldParolePurview.h"

@interface MoldParolePurview ()

@property (nonatomic, strong) CAShapeLayer  *bodLayer;

@end

@implementation MoldParolePurview

- (void)materialBodyAspect {
    
    // 过滤数据
    CGFloat   lineWidth   = (self.lineWidth <= 0 ? 0.5 : self.lineWidth);
    UIFont   *font        = (self.font == nil ? [UIFont systemFontOfSize:18.f] : self.font);
    UIColor  *bloodLineSemblance   = (self.bloodLineSemblance == nil ? [UIColor blackColor] : self.bloodLineSemblance);
    NSString *text        = self.text;
    
    if (text == nil || text.length == 0) {
        
        return;
    }
    
    // 初始化layer
    self.bodLayer             = [CAShapeLayer layer];
    self.bodLayer.frame       = self.bounds;
    self.bodLayer.lineWidth   = lineWidth;
    self.bodLayer.fillColor   = [UIColor clearColor].CGColor;
    self.bodLayer.strokeColor = bloodLineSemblance.CGColor;
    self.bodLayer.path = [UIBezierPath pathForMultilineString:text
                                                       withFont:font
                                                       maxWidth:self.bounds.size.width
                                                  textAlignment:NSTextAlignmentCenter].CGPath;
    self.bodLayer.bounds          = CGPathGetBoundingBox(self.bodLayer.path);
    self.bodLayer.geometryFlipped = YES;
    self.bodLayer.strokeEnd       = 0.f;
    [self.layer addSublayer:self.bodLayer];
}

- (void)perCentum:(CGFloat)perCentum animated:(BOOL)animated {
    
    if (animated) {
        
        if (perCentum <= 0) {
            
            self.bodLayer.strokeEnd = 0;
            
        } else if (perCentum > 0 && perCentum <= 1) {
            
            self.bodLayer.strokeEnd = perCentum;
            
        } else {
            
            self.bodLayer.strokeEnd = 1.f;
        }
        
    } else {
        
        if (perCentum <= 0) {
            
            [CATransaction setDisableActions:YES];
            self.bodLayer.strokeEnd = 0;
            [CATransaction setDisableActions:NO];
            
        } else if (perCentum > 0 && perCentum <= 1) {
            
            [CATransaction setDisableActions:YES];
            self.bodLayer.strokeEnd = perCentum;
            [CATransaction setDisableActions:NO];
            
        } else {
            
            [CATransaction setDisableActions:YES];
            self.bodLayer.strokeEnd = 1.f;
            [CATransaction setDisableActions:NO];
        }
    }
}

@end
