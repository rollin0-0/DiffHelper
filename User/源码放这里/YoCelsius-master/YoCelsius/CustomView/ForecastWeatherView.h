//
//  ForecastWeatherView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "BloodlineBackgroundLookAt.h"

@interface ForecastWeatherView : UIView

/**
 *  城市编号码
 */
@property (nonatomic, strong) NSString *countryCode;

/**
 *  城市名字
 */
@property (nonatomic, strong) NSString *cityAppoint;

/**
 *  创建出view
 */
- (void)materialBodyAspect;

- (void)show;
- (void)hide;

@end
