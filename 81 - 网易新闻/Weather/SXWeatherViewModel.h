//
//  SXWeatherViewModel.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXWeatherEntity;
@interface SXWeatherViewModel : NSObject

/**
 *  获取天气信息
 */
@property(nonatomic,strong)RACCommand *fetchWeatherInfoCommand;
/**
 *  天气模型
 */
@property(nonatomic,strong)SXWeatherEntity *weatherModel;
@end
