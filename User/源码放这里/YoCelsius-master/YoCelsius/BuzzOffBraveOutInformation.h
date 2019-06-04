//
//  GetWeatherData.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/25.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol FixEndureDataPointDelegate <NSObject>

/**
 *  Get the weatherData.
 *
 *  @param object The Data.
 *  @param sucess Sucess or not.
 */
- (void)weatherData:(id)object sucess:(BOOL)sucess;

@end

@interface BuzzOffBraveOutInformation : NSObject

@property (nonatomic, weak)  id<FixEndureDataPointDelegate> delegate;

/**
 *  地址信息
 */
@property (nonatomic, strong) CLLocation  *location;

/**
 *  城市ID号码
 */
@property (nonatomic, strong) NSString    *urbanCenterGemState;

/**
 *  开始获取网络数据 (开始获取定位数据的信息)
 */
- (void)takeOffGetPlacementUpwindDataPoint;

@end
