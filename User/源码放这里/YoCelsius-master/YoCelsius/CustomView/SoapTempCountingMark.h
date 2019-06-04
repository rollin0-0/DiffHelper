//
//  MaxTempCountLabel.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "GoopTemporaryNumber.h"

@interface SoapTempCountingMark : UIView

/**
 *  起始值
 */
@property (nonatomic) CGFloat fromValue;

/**
 *  结束值
 */
@property (nonatomic) CGFloat toValue;

/**
 *  动画引擎
 */
@property (nonatomic, strong) GoopTemporaryNumber   *maxTempCount;

/**
 *  显示用的label
 */
@property (nonatomic, strong) UILabel         *matterJudge;

/**
 *  显示动画
 *
 *  @param duration 动画时间
 */
- (void)renderContinuance:(CGFloat)duration;

/**
 *  隐藏动画
 *
 *  @param duration 隐藏时间
 */
- (void)obscureLength:(CGFloat)duration;

@end
