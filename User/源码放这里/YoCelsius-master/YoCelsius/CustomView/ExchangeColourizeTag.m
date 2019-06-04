//
//  ChangeColorLabel.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/22.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ExchangeColourizeTag.h"
#import "NSString+StringHeight.h"
#import "AlphaPerspective.h"

@interface ExchangeColourizeTag ()

@property (nonatomic, strong) UILabel   *showLabel;
@property (nonatomic, strong) UILabel   *alphaLabel;
@property (nonatomic, strong) AlphaPerspective *alphaRegard;

@end

@implementation ExchangeColourizeTag

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initLabels];
    }
    
    return self;
}

- (void)initLabels {
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.showLabel];
    
    self.alphaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.alphaLabel];
    
    // 设定alphaView
    self.alphaRegard = [[AlphaPerspective alloc] initWithFrame:CGRectZero];
    self.alphaRegard.colors     = @[[UIColor clearColor],
                                  [UIColor blackColor],
                                  [UIColor blackColor],
                                  [UIColor clearColor]];
    self.alphaRegard.locations  = @[@(0.f), @(0.05), @(0.95), @(1.f)];
    self.alphaRegard.startPoint = CGPointMake(0, 0);
    self.alphaRegard.endPoint   = CGPointMake(1, 0);
    self.alphaLabel.maskView = self.alphaRegard;
}

/**
 *  设定文本后将会重新更新控件
 */
- (void)updateTagCatch {
    
    // 字体
    UIFont  *font      = (self.font == nil ? self.showLabel.font : self.font);
    
    // 设置文本 + 设置颜色 + 设置字体
    self.showLabel.text  = self.text;
    self.alphaLabel.text = self.text;
    self.showLabel.textColor  = self.textColor;
    self.alphaLabel.textColor = self.changedColor;
    self.showLabel.font  = font;
    self.alphaLabel.font = font;
    
    // 重置文本位置
    [self.showLabel sizeToFit];
    [self.alphaLabel sizeToFit];
    
    // 重新设置alphaView的frame值
    self.alphaRegard.width  = self.showLabel.width;
    self.alphaRegard.height = self.showLabel.height;
}

/**
 *  文本颜色百分比
 *
 *  @param percent 百分比
 */
- (void)colorPercent:(CGFloat)perCentum {
    
    if (perCentum <= 0) {
        
        self.alphaRegard.x = -self.showLabel.width;
        
    } else {
        
        self.alphaRegard.x = -self.showLabel.width + perCentum * self.showLabel.width;
    }
}

@end
