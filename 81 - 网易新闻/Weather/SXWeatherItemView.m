//
//  SXWeatherItemView.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/9.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXWeatherItemView.h"

@implementation SXWeatherItemView


+ (instancetype)view
{
    return [[NSBundle mainBundle]loadNibNamed:@"SXWeatherItemView" owner:nil options:nil][0];
}

- (void)setWeather:(NSString *)weather{
    _weather = weather;
    self.weatherLbl.text = weather;
    if ([weather isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder"];
    }else if ([weather isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun"];
    }else if ([weather isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sunandcloud"];
    }else if ([weather isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"cloud"];
    }else if ([weather hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain"];
    }else if ([weather hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sandfloat"];
    }
}

@end
