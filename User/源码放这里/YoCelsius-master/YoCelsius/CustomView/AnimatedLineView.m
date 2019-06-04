//
//  AnimatedLineView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "AnimatedLineView.h"

@interface AnimatedLineView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) CGRect startOutRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect finishRect;

@end

@implementation AnimatedLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initRects];
        
        self.imageView       = [[UIImageView alloc] initWithFrame:self.startOutRect];
        self.imageView.alpha = 0.f;
        [self addSubview:self.imageView];
    }
    
    return self;
}

- (void)initRects {
    
    CGRect rect    = self.bounds;
    self.startOutRect = CGRectMake(0, -10, rect.size.width, rect.size.height / 2.f);
    self.midRect   = CGRectMake(0, 0, rect.size.width, rect.size.height / 2.f);
    self.finishRect   = CGRectMake(0, -5, rect.size.width, rect.size.height / 2.f);
}

/**
 *  重置UIImageView的参数
 */
- (void)resetFigureThought {
    
    self.imageView.alpha = 0.f;
    self.imageView.frame = self.startOutRect;
}

/**
 *  显示出来
 *
 *  @param duration 动画持续时间
 *  @param animated 是否执行动画
 */
- (void)appearanceWithLength:(CGFloat)duration animated:(BOOL)animated {
    
    [self resetFigureThought];
    
    if (animated) {
        
        [UIView animateWithDuration:duration animations:^{
            
            self.imageView.frame = self.midRect;
            self.imageView.alpha = 1.f;
        }];
        
    } else {
        
        self.imageView.frame = self.midRect;
        self.imageView.alpha = 1.f;
    }
}

/**
 *  隐藏
 *
 *  @param duration 动画持续时间
 *  @param animated 是否执行动画
 */
- (void)coverWithContinuance:(CGFloat)duration animated:(BOOL)animated {
    
    if (animated) {
        
        [UIView animateWithDuration:duration animations:^{
            self.imageView.frame = self.finishRect;
            self.imageView.alpha = 0.f;
        }];
        
    } else {
        
        self.imageView.frame = self.finishRect;
        self.imageView.alpha = 0.f;
    }
}

@synthesize image = _image;

- (UIImage *)image {
    
    return _image;
}

- (void)setImage:(UIImage *)image {
    
    _image               = image;
    self.imageView.image = image;
}

@end
