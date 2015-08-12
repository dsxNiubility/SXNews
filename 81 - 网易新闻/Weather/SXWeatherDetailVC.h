//
//  SXWeatherDetailVC.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SXWeatherModel;

@interface SXWeatherDetailVC : UIViewController

@property(nonatomic,strong)SXWeatherModel *weatherModel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@end
