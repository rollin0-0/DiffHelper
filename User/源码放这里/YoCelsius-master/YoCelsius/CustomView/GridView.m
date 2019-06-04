//
//  GridView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "GridView.h"
#import "AlphaPerspective.h"

@interface GridView ()

@property (nonatomic, strong) AlphaPerspective *alphaRegard;

@end

@implementation GridView

- (void)materialBodyAspect {
    
    CGFloat gridLength      = (self.gridLength <= 0 ? 10.f : self.gridLength);

    // 水平线条的个数
    int horizontalLineCount = 5;
    for (int i = 0; i < horizontalLineCount; i++) {
        
        CGRect rect          = CGRectMake(0, gridLength * i, gridLength * horizontalLineCount, 0.5);
        UIView *telephoneLine         = [[UIView alloc] initWithFrame:rect];
        telephoneLine.backgroundColor = COLOR_CIRCLE_;
        
        if (i == 0) {
            
            telephoneLine.alpha = 0.f;
            
        } else if (i == horizontalLineCount - 1) {
            
            telephoneLine.alpha = 0.f;
        }
        
        [self addSubview:telephoneLine];
    }
    
    // 垂直线的个数
    int verticalLineCount = 6;
    for (int i = 0; i < verticalLineCount; i++) {
        
        CGRect rect          = CGRectMake(gridLength * i, 0, 0.5, gridLength * (verticalLineCount - 2));
        UIView *telephoneLine         = [[UIView alloc] initWithFrame:rect];
        telephoneLine.backgroundColor = COLOR_CIRCLE_;
        
        if (i == 0) {
            
            telephoneLine.alpha = 0.f;
            
        } else if (i == verticalLineCount - 1) {
            
            telephoneLine.alpha = 0.f;
        }
        
        [self addSubview:telephoneLine];
    }
    
    self.height     = horizontalLineCount * gridLength;
    self.width      = verticalLineCount   * gridLength;
    self.viewOrigin = self.origin;
    
    self.alphaRegard = [[AlphaPerspective alloc] initWithFrame:self.bounds];
    [self.alphaRegard alphaType];
    self.alphaRegard.x = -self.width;
    self.maskView = self.alphaRegard;
}

- (void)appearanceWithLength:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.alphaRegard.x = -5;
        self.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)coverWithContinuance:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.alphaRegard.x = self.width;
        self.alpha       = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.alphaRegard.x = -self.width;
    }];
}

@end
