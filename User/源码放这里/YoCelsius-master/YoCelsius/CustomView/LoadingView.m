//
//  LoadingView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/23.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "LoadingView.h"


@interface LoadingView ()
@property (nonatomic, strong) UIImageView  *staticSeePosition;
@property (nonatomic, strong) UIImageView  *animtedPictureConsider;
@property (nonatomic, strong) NSNumber     *lock;
@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.lock = @(NO);
        
        [self initSee];
        
        [self splayEpitomeConsiderWithBandAwayBack];
    }
    
    return self;
}

- (void)initSee {
    
    // 静态图片
    self.staticSeePosition       = [[UIImageView alloc] initWithFrame:self.bounds];
    self.staticSeePosition.alpha = 0.f;
    [self addSubview:self.staticSeePosition];
    
    // 动态图片
    self.animtedPictureConsider       = [[UIImageView alloc] initWithFrame:self.bounds];
    self.animtedPictureConsider.alpha = 0.f;
    [self addSubview:self.animtedPictureConsider];
}

/**
 *  显示
 */
- (void)show {
    
    // 锁上
    if (self.lock.boolValue == NO) {
        
        self.lock = @(YES);
        
    } else {
        
        return;
    }
    
    CGFloat duration = 0.75f;
    
    self.staticSeePosition.transform  = CGAffineTransformMake(3.f, 0, 0, 3.f, 0, 0);
    self.animtedPictureConsider.transform = CGAffineTransformMake(3.f, 0, 0, 3.f, 0, 0);
    
    [UIView animateWithDuration:duration delay:0.f
         usingSpringWithDamping:3.f
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionLayoutSubviews animations:^{
                            
                            self.staticSeePosition.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                            self.staticSeePosition.alpha     = 1.f;
                            
                            self.animtedPictureConsider.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                            self.animtedPictureConsider.alpha     = 1.f;
                            
                        } completion:^(BOOL finished) {
                            
                        }];
}

/**
 *  隐藏
 */
- (void)hide {
    
    // 解锁
    self.lock = @(NO);
    
    CGFloat duration = 0.75f;
    
    [UIView animateWithDuration:duration animations:^{
        
        self.staticSeePosition.transform = CGAffineTransformMake(1.2, 0, 0, 1.2, 0, 0);
        self.staticSeePosition.alpha     = 0.f;
        
        self.animtedPictureConsider.transform = CGAffineTransformMake(1.2, 0, 0, 1.2, 0, 0);
        self.animtedPictureConsider.alpha     = 0.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 重写setter,getter方法

@synthesize staticCircleImage = _staticCircleImage;

- (void)setStaticCircleImage:(UIImage *)staticCircleImage {
    
    _staticCircleImage         = staticCircleImage;
    self.staticSeePosition.image = staticCircleImage;
}

- (UIImage *)staticCircleImage {
    
    return _staticCircleImage;
}

@synthesize animtedImage = _animtedImage;

- (void)setAnimtedImage:(UIImage *)animtedImage {
    
    _animtedImage               = animtedImage;
    self.animtedPictureConsider.image = animtedImage;
}

- (UIImage *)animtedImage {
    
    return _animtedImage;
}

- (void)splayEpitomeConsiderWithBandAwayBack {
    
    CGFloat roundPastPeerlessSecondBase = 3.f;
    
    // 执行动画
    [UIView animateWithDuration:1.f / roundPastPeerlessSecondBase
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
                         
                     } completion:^(BOOL finished){
                         
                         [self splayEpitomeConsiderWithBandAwayBack];
                     }];
}

@end
