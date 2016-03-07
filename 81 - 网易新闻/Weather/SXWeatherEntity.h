//
//  SXWeatherEntity.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXWeatherDetailEntity.h"
#import "SXWeatherBgEntity.h"
//@class SXWeatherBgEntity;
//@class SXWeatherDetailEntity;

@interface SXWeatherEntity : NSObject

/** 数组里面装的是SXWeatherDetailEntity模型*/
@property(nonatomic,strong)NSArray *detailArray;
@property(nonatomic,strong)SXWeatherBgEntity *pm2d5;
@property(nonatomic,copy)NSString *dt;
@property(nonatomic,assign)int rt_temperature;

@end
