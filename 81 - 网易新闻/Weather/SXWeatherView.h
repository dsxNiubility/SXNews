//
//  SXWeatherView.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SXWeatherEntity;
@interface SXWeatherView : UIView
@property(nonatomic,strong)SXWeatherEntity *weatherModel;

+ (instancetype)view;
- (void)addAnimate;

@end
