//
//  ThreeLineView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "LeashMelodicLineWatch.h"

#define   Rad(degrees)  ((M_PI * (degrees))/ 180.f)

@interface LeashMelodicLineWatch ()

@property (nonatomic, strong) AnimatedLineView  *unityStemma;
@property (nonatomic, strong) AnimatedLineView  *twoLine;
@property (nonatomic, strong) AnimatedLineView  *threeLine;

@end

@implementation LeashMelodicLineWatch

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initLineViews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(upshotManageSuitActive:)                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(upshotManageSuitActive:)                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(upshotManageSuitActive:)                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)initLineViews {
    
    UIImage *image = [UIImage imageNamed:@"WindSpeed"];
    CGFloat  width = self.height / image.size.height * image.size.width / 2.f;
    
    // 初始化第一个叶子
    self.unityStemma        = [[AnimatedLineView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.unityStemma.image  = image;
    self.unityStemma.center = self.middlePoint;
    [self addSubview:self.unityStemma];

    // 初始化第二个叶子
    self.twoLine        = [[AnimatedLineView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.twoLine.image  = image;
    self.twoLine.center = self.middlePoint;
    [self addSubview:self.twoLine];
    self.twoLine.transform = CGAffineTransformRotate(self.twoLine.transform, Rad(120));

    // 初始化第三个叶子
    self.threeLine        = [[AnimatedLineView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.threeLine.image  = image;
    self.threeLine.center = self.middlePoint;
    [self addSubview:self.threeLine];
    self.threeLine.transform = CGAffineTransformRotate(self.threeLine.transform, Rad(240));
}

- (void)appearanceWithLength:(CGFloat)duration animated:(BOOL)animated {
    
    [self.unityStemma   appearanceWithLength:duration animated:animated];
    [self.twoLine   appearanceWithLength:duration animated:animated];
    [self.threeLine appearanceWithLength:duration animated:animated];
}

- (void)coverWithContinuance:(CGFloat)duration animated:(BOOL)animated {
    
    [self.unityStemma   coverWithContinuance:duration animated:animated];
    [self.twoLine   coverWithContinuance:duration animated:animated];
    [self.threeLine coverWithContinuance:duration animated:animated];
}

- (void)splayEpitomeConsiderWithBandAwayBack {
        
    CGFloat roundPastPeerlessSecondBase = (self.roundPastPeerlessSecondBase <= 0 ? 0.001 : self.roundPastPeerlessSecondBase);

    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue         = @(0);
    rotationAnimation.toValue           = @(M_PI * 100000);
    rotationAnimation.duration          = (1 / roundPastPeerlessSecondBase) * 100000;
    rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)upshotManageSuitActive:(id)obj {
    
    // 获取通知对象
    NSNotification *fication = obj;

    if ([fication.name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.alpha = 1.f;
        }];
        
        [self splayEpitomeConsiderWithBandAwayBack];
        
    } else if ([fication.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.alpha = 0.f;
        }];
        
    } else if ([fication.name isEqualToString:UIApplicationWillResignActiveNotification]) {
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.alpha = 0.f;
        }];
    }
}

@end
