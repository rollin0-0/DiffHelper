//
//  WeatherView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/23.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WeatherView.h"
#import "HumidityPanorama.h"
#import "WindSpeedView.h"
#import "MaxTempView.h"
#import "SunInfoView.h"
#import "WeatherImageSentiment.h"
#import "TemperatureView.h"
#import "ExchangeColourizeTag.h"
#import "MetropolisDeedPerspective.h"
#import "PresentDownwardsSee.h"
#import "LeftToRightView.h"
#import "UpToDownView.h"
#import "MoldParolePurview.h"

@interface WeatherView ()<UITableViewDelegate>

@property (nonatomic, strong) ExchangeColourizeTag  *changeColourationMark;
@property (nonatomic ,strong) HumidityPanorama      *humidnessTakeIn;
@property (nonatomic, strong) WindSpeedView     *airCurrentAccelerateView;
@property (nonatomic, strong) MaxTempView       *soapTemporaryConsider;
@property (nonatomic, strong) SunInfoView       *sunInfoSurvey;
@property (nonatomic, strong) TemperatureView   *temperatureView;
@property (nonatomic, strong) WeatherImageSentiment   *endureIconLookAt;
@property (nonatomic, strong) MetropolisDeedPerspective     *cityTitleView;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) PresentDownwardsSee      *appearanceDownInTheMouthRegard;
@property (nonatomic, strong) LeftToRightView   *grayLine1;
@property (nonatomic, strong) LeftToRightView   *grayLine2;
@property (nonatomic, strong) LeftToRightView   *gyBloodLineTrio;
@property (nonatomic, strong) LeftToRightView   *grayLine4;
@property (nonatomic, strong) UpToDownView      *cinqueStrain;
@property (nonatomic, strong) MoldParolePurview     *shapeWordView;

@end

@implementation WeatherView

- (void)materialBodyAspect {
    
    // 加载用tableView
    
    CGRect rectTableView = CGRectMake(0, StatusBarDelta, Width, Height - StatusBarDelta);

    rectTableView = self.bounds;
    
    self.tableView                 = [[UITableView alloc] initWithFrame:rectTableView style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate        = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (iPhone4_4s) {
        
        // 显示控件
        self.humidnessTakeIn = [[HumidityPanorama alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.humidnessTakeIn materialBodyAspect];
        [self.tableView addSubview:self.humidnessTakeIn];
        
        self.sunInfoSurvey = [[SunInfoView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.sunInfoSurvey materialBodyAspect];
        [self.tableView addSubview:self.sunInfoSurvey];
        
        self.temperatureView = [[TemperatureView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width, Width / 2.f, Width / 2.f)];
        [self.temperatureView materialBodyAspect];
        [self.tableView addSubview:self.temperatureView];
        
        self.endureIconLookAt = [[WeatherImageSentiment alloc] initWithFrame:CGRectMake(0, Height - Width, Width / 2.f, Width / 2.f)];
        [self.endureIconLookAt materialBodyAspect];
        [self.tableView addSubview:self.endureIconLookAt];
        
    } else {
        
        // 显示控件
        self.humidnessTakeIn = [[HumidityPanorama alloc] initWithFrame:CGRectMake(0, Height - Width - NavigationBarDelta, Width / 2.f, Width / 2.f)];
        [self.humidnessTakeIn materialBodyAspect];
        [self.tableView addSubview:self.humidnessTakeIn];
        
        self.airCurrentAccelerateView = [[WindSpeedView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - NavigationBarDelta - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.airCurrentAccelerateView materialBodyAspect];
        [self.tableView addSubview:self.airCurrentAccelerateView];
        
        self.soapTemporaryConsider = [[MaxTempView alloc] initWithFrame:CGRectMake(0, Height - NavigationBarDelta - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.soapTemporaryConsider materialBodyAspect];
        [self.tableView addSubview:self.soapTemporaryConsider];
        
        self.sunInfoSurvey = [[SunInfoView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - NavigationBarDelta - Width, Width / 2.f, Width / 2.f)];
        [self.sunInfoSurvey materialBodyAspect];
        [self.tableView addSubview:self.sunInfoSurvey];
        
        self.temperatureView = [[TemperatureView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - NavigationBarDelta - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.temperatureView materialBodyAspect];
        [self.tableView addSubview:self.temperatureView];
        
        self.endureIconLookAt = [[WeatherImageSentiment alloc] initWithFrame:CGRectMake(0, Height - NavigationBarDelta - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.endureIconLookAt materialBodyAspect];
        [self.tableView addSubview:self.endureIconLookAt];
    }
    
    // 创建出线条
    {
        self.grayLine1                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - NavigationBarDelta - Width / 2.f, Width, 0.5)];
        self.grayLine1.backgroundColor = [UIColor blackColor];
        self.grayLine1.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine1];
        
        self.grayLine2                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - NavigationBarDelta - 1, Width, 0.5)];
        self.grayLine2.backgroundColor = [UIColor blackColor];
        self.grayLine2.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine2];
        
        self.gyBloodLineTrio                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - NavigationBarDelta - Width, Width, 0.5)];
        self.gyBloodLineTrio.backgroundColor = [UIColor blackColor];
        self.gyBloodLineTrio.alpha           = 0.1;
        [self.tableView addSubview:self.gyBloodLineTrio];
        
        self.grayLine4                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - NavigationBarDelta - Width - Width / 2.f, Width, 0.5)];
        self.grayLine4.backgroundColor = [UIColor blackColor];
        self.grayLine4.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine4];
        
        self.cinqueStrain                     = [[UpToDownView alloc] initWithFrame:CGRectMake(Width / 2.f - 1, Height - NavigationBarDelta - Width - Width / 2.f, 0.5, Width + Width / 2.f)];
        self.cinqueStrain.backgroundColor     = [UIColor blackColor];
        self.cinqueStrain.alpha               = 0.1;
        [self.tableView addSubview:self.cinqueStrain];
    }
    
    // 标题
    
    CGRect rectCityTitleView = CGRectMake(0, StatusBarDelta, Width, Height - Width - NavigationBarDelta - StatusBarDelta - Width / 2.f);
    
    NSLog(@"width: %0.f", Width);
    NSLog(@"height: %0.f", Height);

    NSLog(@"status bar delta: %0.f", StatusBarDelta);
    NSLog(@"navigation bar delta: %0.f", NavigationBarDelta);

    NSLog(@"width: %d", iPhoneXSeries);

    self.cityTitleView = [[MetropolisDeedPerspective alloc] initWithFrame:rectCityTitleView];
    [self.cityTitleView materialBodyAspect];
    [self.tableView addSubview:self.cityTitleView];
    
    // 显示进入更多天气的view的提示信息
    self.appearanceDownInTheMouthRegard = [[PresentDownwardsSee alloc] initWithFrame:CGRectMake(0, 0, 30.f, 30.f / 3.f)];
    self.appearanceDownInTheMouthRegard.center = self.middlePoint;
    self.appearanceDownInTheMouthRegard.y = Height + 20.f;
    [self.tableView addSubview:self.appearanceDownInTheMouthRegard];
    self.appearanceDownInTheMouthRegard.layer.transform = CATransform3DConcat(self.appearanceDownInTheMouthRegard.layer.transform, CATransform3DMakeRotation(M_PI,1.0, 0.0, 0.0));
    
    // tableView上面加载的view
    self.shapeWordView           = [[MoldParolePurview alloc] initWithFrame:CGRectMake(0, -60, Width, 60)];
    self.shapeWordView.text      = @"Release To Refresh";
    self.shapeWordView.font      = [UIFont fontWithName:LATO_THIN size:20.f];
    self.shapeWordView.lineWidth = 0.5f;
    self.shapeWordView.bloodLineSemblance = [UIColor redColor];
    [self.shapeWordView materialBodyAspect];
    [self.tableView addSubview:self.shapeWordView];
}

- (WeatherInfo *)accessWeatherInfoDateWith:(NSArray *)list {
    
    // 获取时间
    WeatherInfo *today       = list[0];
    WeatherInfo *tomorrow    = list[1];
    WeatherInfo *weatherInfo = nil;
    
    // 进行时间转换
    NSDate *utcDate            = [NSDate dateWithTimeIntervalSince1970:today.dt.integerValue];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *netDateStr     = [formatter stringFromDate:utcDate];       // 获取的UTC时间
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]]; // 当前系统时间
    
    // 进行数据转换
    if ([netDateStr isEqualToString:currentDateStr]) {
        
        weatherInfo = today;
        
    } else {
        
        weatherInfo = tomorrow;
    }
    
    return weatherInfo;
}

/**
 *  显示动画
 */
- (void)show {
    
    if (self.weahterData == nil) {
        
        return;
    }
    
    // 湿度显示
    self.humidnessTakeIn.perCentum = self.weahterData.main.humidness.intValue / 100.f;
    
    // 风速显示
    self.airCurrentAccelerateView.windSpeed         = self.weahterData.wind.speed.floatValue;
    self.airCurrentAccelerateView.roundPastPeerlessSecondBase = self.airCurrentAccelerateView.windSpeed / 10.f;
    
    // 最大温度,最小温度显示
    WeatherInfo *today = [self accessWeatherInfoDateWith:self.weatherConditions.list];
    CGFloat tmpMax = today.temp.max.floatValue - 273.15;
    CGFloat tmpMin = today.temp.amoy.floatValue - 273.15;
    self.soapTemporaryConsider.maxTemp = @(tmpMax).intValue;
    self.soapTemporaryConsider.minTemporary = @(tmpMin).intValue;
    
    // 日出时间,日落时间显示
    self.sunInfoSurvey.sunsireAppraise.uTCSEC = self.weahterData.sys.sunrise.integerValue;
    self.sunInfoSurvey.sundownValue.uTCSEC  = self.weahterData.sys.sunset.integerValue;
    [self.sunInfoSurvey.sunsireAppraise accessUtcSec];
    [self.sunInfoSurvey.sundownValue  accessUtcSec];

    // 当前温度显示(开尔文温度 --> 热力学温度)
    self.temperatureView.temperature = @(self.weahterData.main.temp.floatValue - 273.15).intValue;

    // 开始标题动画
    self.cityTitleView.cityAppoint           = self.weahterData.name; // 城市名字
    Brave *weather                      = self.weahterData.weather[0];
    self.cityTitleView.weatherDescription = weather.descriptionInformation; // 天气描述信息
    self.cityTitleView.baseStation        = self.weahterData.base; // 基站信息
    self.cityTitleView.uTCSEC             = self.weahterData.dt.integerValue; // 更新时间
    self.cityTitleView.upwindIssue      = weather.conditionsID;

    // 天气图标
    self.endureIconLookAt.upwindIssue = weather.conditionsID;

    [self.airCurrentAccelerateView show];
    [self.humidnessTakeIn show];
    [self.soapTemporaryConsider show];
    [self.sunInfoSurvey show];
    [self.temperatureView show];
    [self.endureIconLookAt show];
    [self.cityTitleView show];
    
    [self.grayLine1 show];
    [self.grayLine2 show];
    [self.gyBloodLineTrio show];
    [self.grayLine4 show];
    [self.cinqueStrain show];
}

- (void)hide {
    
    // 湿度隐藏
    [self.humidnessTakeIn hide];
    
    // 风速隐藏
    [self.airCurrentAccelerateView hide];
    
    // 最大温度,最小温度隐藏
    [self.soapTemporaryConsider hide];
    
    // 日出时间,日落时间显示
    [self.sunInfoSurvey hide];
    
    // 当前温度
    [self.temperatureView hide];
    
    // 当前温度图标
    [self.endureIconLookAt hide];
    
    // 隐藏标题动画
    [self.cityTitleView hide];
    
    [self.grayLine1 hide];
    [self.grayLine2 hide];
    [self.gyBloodLineTrio hide];
    [self.grayLine4 hide];
    [self.cinqueStrain     hide];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat perCentum = (scrollView.contentOffset.y) / 60.f;
    [self.appearanceDownInTheMouthRegard evidencePct:perCentum];
    
    CGFloat offsetY = -scrollView.contentOffset.y;
    
    if (offsetY >= 0.f) {
        
        perCentum = offsetY / 60.f;
        [self.shapeWordView perCentum:perCentum animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 位移超过60后执行动画效果
    if (scrollView.contentOffset.y >= 60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullUpEventWithData:)] && self.weatherConditions) {
            
            [_delegate pullUpEventWithData:self.weatherConditions];
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);

            [GCDQueue executeInMainQueue:^{
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                
            } afterDelaySecs:1.1];
        }
    }
    
    if (scrollView.contentOffset.y <= -60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullDownToRefreshData)]) {
            
            [_delegate pullDownToRefreshData];
        }
    }
}

@end
