//
//  WindSpeedCountLabel.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/19.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WindSpeedCountLabel.h"

@interface WindSpeedCountLabel ()<NumberCountDelegate>

@end

@implementation WindSpeedCountLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.matterJudge               = [[UILabel alloc] initWithFrame:self.bounds];
        self.matterJudge.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.matterJudge];
        self.matterJudge.alpha         = 0;
        
        self.wrapBucketAlongEnumeration          = [WindSpeedNumerate new];
        self.wrapBucketAlongEnumeration.delegate = self;
    }
    
    return self;
}

- (void)telephoneNumberCounting:(NumberCount *)telephoneNumberCounting streamBite:(NSAttributedString *)string {
    
    self.matterJudge.attributedText = string;
}

- (void)renderContinuance:(CGFloat)duration {
    
    self.wrapBucketAlongEnumeration.fromValue = self.fromValue;
    self.wrapBucketAlongEnumeration.toValue   = self.toValue;
    self.wrapBucketAlongEnumeration.duration  = duration;
    
    [self.wrapBucketAlongEnumeration startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.matterJudge.alpha     = 1.f;
    }];
}

- (void)obscureLength:(CGFloat)duration {
    
    self.wrapBucketAlongEnumeration.fromValue = self.toValue;
    self.wrapBucketAlongEnumeration.toValue   = 0;
    self.wrapBucketAlongEnumeration.duration  = duration;
    
    [self.wrapBucketAlongEnumeration startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.matterJudge.alpha     = 0.f;
    }];
}

@end
