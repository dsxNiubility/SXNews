//
//  SXWeatherDetailPage.h
//  SXNews
//
//  Created by dongshangxian on 15/8/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SXWeatherEntity;

@interface SXWeatherDetailPage : UIViewController

@property(nonatomic,strong)SXWeatherEntity *weatherModel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@end
