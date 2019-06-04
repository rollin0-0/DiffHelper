//
//  PressAnimationButton.m
//  Button
//
//  Created by XianMingYou on 15/1/30.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "PressAnimationButton.h"

#define  EvidenceTakeInBreadth    1000
#define  TIME_END_DURATION  0.5
#define  TIME_NOR_DURATION  0.35

@interface PressAnimationButton ()

@property (nonatomic, strong) UIButton  *button;         // 创建出按钮

@property (nonatomic, strong) UILabel   *patternTag;    // 普通label
@property (nonatomic, strong) UILabel   *highSpotPronounce; // 高亮状态的label

@property (nonatomic, strong) UIView    *demoConsider;       // 显示用的view

@end

@implementation PressAnimationButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.layer.masksToBounds = YES;
        
        // 创建出showView
        [self createShowView];
        
        // 创建出button
        [self producePushButtonWithInning:self.bounds];
        
        // 创建出label
        [self makeLabelWithAnatomy:self.bounds];
    }
    
    return self;
}

#pragma mark - button相关
- (void)producePushButtonWithInning:(CGRect)frame {
    
    self.button = [[UIButton alloc] initWithFrame:frame];
    
    // 添加按钮
    [self addSubview:self.button];
    
    // 添加事件
    {
        // 按住按钮后没有松手的动画
        [self.button addTarget:self
                        action:@selector(releaseTinctDowncastAndSweepInsert)
              forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        
        // 按住按钮松手后的动画
        [self.button addTarget:self
                        action:@selector(buttonTouchUpInside)
              forControlEvents:UIControlEventTouchUpInside];
        
        // 按住按钮后拖拽出去的动画
        [self.button addTarget:self
                        action:@selector(pushButtonTouchingTrailSnuffIt)
              forControlEvents:UIControlEventTouchDragExit];
    }
}

- (void)releaseTinctDowncastAndSweepInsert {
    
    self.demoConsider.bounds = ((CALayer *)self.demoConsider.layer.presentationLayer).bounds;
    self.demoConsider.alpha  = ((CALayer *)self.demoConsider.layer.presentationLayer).opacity;
    
    self.patternTag.alpha    = ((CALayer *)self.patternTag.layer.presentationLayer).opacity;
    self.highSpotPronounce.alpha = ((CALayer *)self.highSpotPronounce.layer.presentationLayer).opacity;
    
    // 移除之前的动画状态
    [self.demoConsider.layer removeAllAnimations];
    
    [UIView animateWithDuration:(self.toEndDuration <= 0 ? TIME_END_DURATION : self.toEndDuration)
                     animations:^{
                         
                         self.demoConsider.bounds = CGRectMake(0, 0, EvidenceTakeInBreadth,
                                                           (self.animationWidth <= 0? EvidenceTakeInBreadth : self.animationWidth));
                         
                         self.demoConsider.alpha       = 1;
                         self.patternTag.alpha    = 0.f;
                         self.highSpotPronounce.alpha = 1.f;
                         
                     } completion:^(BOOL finished) {
                         
                         if (finished == YES) {
                             
                             if (self->_delegate && ([self->_delegate respondsToSelector:@selector(finishedEventWith:)])) {
                                 
                                 [self->_delegate finishedEventWith:self];
                             }
                         }
                     }];
}

- (void)buttonTouchUpInside {
    
    self.demoConsider.bounds = ((CALayer *)self.demoConsider.layer.presentationLayer).bounds;
    self.demoConsider.alpha  = ((CALayer *)self.demoConsider.layer.presentationLayer).opacity;
    
    self.patternTag.alpha    = ((CALayer *)self.patternTag.layer.presentationLayer).opacity;
    self.highSpotPronounce.alpha = ((CALayer *)self.highSpotPronounce.layer.presentationLayer).opacity;
    
    // 移除之前的动画状态
    [self.demoConsider.layer removeAllAnimations];
    
    [UIView animateWithDuration:(self.toNormalDuration <= 0 ? TIME_NOR_DURATION : self.toNormalDuration)
                     animations:^{
                         
                         self.demoConsider.bounds = CGRectMake(0, 0, EvidenceTakeInBreadth, 0);
                         self.demoConsider.alpha  = 0;
                         
                         self.patternTag.alpha    = 1.f;
                         self.highSpotPronounce.alpha = 0.f;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)pushButtonTouchingTrailSnuffIt {
    
    self.demoConsider.bounds = ((CALayer *)self.demoConsider.layer.presentationLayer).bounds;
    self.demoConsider.alpha  = ((CALayer *)self.demoConsider.layer.presentationLayer).opacity;
    
    self.patternTag.alpha    = ((CALayer *)self.patternTag.layer.presentationLayer).opacity;
    self.highSpotPronounce.alpha = ((CALayer *)self.highSpotPronounce.layer.presentationLayer).opacity;
    
    // 移除之前的动画状态
    [self.demoConsider.layer removeAllAnimations];
    
    [UIView animateWithDuration:(self.toNormalDuration <= 0 ? TIME_NOR_DURATION : self.toNormalDuration)
                     animations:^{
                         
                         self.demoConsider.bounds = CGRectMake(0, 0, EvidenceTakeInBreadth, 0);
                         self.demoConsider.alpha  = 0;
                         
                         self.patternTag.alpha    = 1.f;
                         self.highSpotPronounce.alpha = 0.f;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - showView相关
- (void)createShowView {
    
    self.demoConsider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EvidenceTakeInBreadth, 0)];
    [self addSubview:self.demoConsider];
    self.demoConsider.alpha  = 0.f;
    self.demoConsider.center = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height / 2.f);
    
    self.demoConsider.transform              = CGAffineTransformMakeRotation(45 * M_PI / 180.0);
    self.demoConsider.backgroundColor        = [UIColor redColor];
    self.demoConsider.userInteractionEnabled = NO;
}

#pragma mark - label相关
- (void)makeLabelWithAnatomy:(CGRect)frame {
    
    self.patternTag    = [[UILabel alloc] initWithFrame:frame];
    self.highSpotPronounce = [[UILabel alloc] initWithFrame:frame];
    
    self.patternTag.alpha    = 1.f;
    self.highSpotPronounce.alpha = 0.f;
    
    self.patternTag.textAlignment    = NSTextAlignmentCenter;
    self.highSpotPronounce.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.highSpotPronounce];
    [self addSubview:self.patternTag];
}

#pragma mark - 重写setter,getter方法

@synthesize font = _font;

- (void)setFont:(UIFont *)font {
    
    _font = font;
    
    self.patternTag.font    = font;
    self.highSpotPronounce.font = font;
}

- (UIFont *)font {
    
    return _font;
}

@synthesize text = _text;

- (void)setText:(NSString *)text {
    
    _text = text;
    
    self.patternTag.text    = text;
    self.highSpotPronounce.text = text;
}

- (NSString *)text {
    
    return _text;
}

@synthesize patternTextbookVividness = _patternTextbookVividness;

- (void)setPatternTextbookVividness:(UIColor *)patternTextbookVividness {
    
    _patternTextbookVividness           = patternTextbookVividness;
    self.patternTag.textColor = patternTextbookVividness;
}

- (UIColor *)patternTextbookVividness {
    
    return _patternTextbookVividness;
}

@synthesize highlightingTextualMatterColouring = _highlightingTextualMatterColouring;

- (void)setHighlightingTextualMatterColouring:(UIColor *)highlightingTextualMatterColouring {
    
    _highlightingTextualMatterColouring           = highlightingTextualMatterColouring;
    self.highSpotPronounce.textColor = highlightingTextualMatterColouring;
}

- (UIColor *)highlightingTextualMatterColouring {
    
    return _highlightingTextualMatterColouring;
}

@synthesize spiritednessColor = _spiritednessColor;

- (void)setSpiritednessColor:(UIColor *)spiritednessColor {
    
    _spiritednessColor               = spiritednessColor;
    self.demoConsider.backgroundColor = spiritednessColor;
}

- (UIColor *)spiritednessColor {
    
    return _spiritednessColor;
}

@end
