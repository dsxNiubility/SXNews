//
//  SXWeatherView.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXWeatherView.h"

@implementation SXWeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)view{
    return [[NSBundle mainBundle]loadNibNamed:@"SXWeatherView" owner:nil options:nil].firstObject;
}


@end
