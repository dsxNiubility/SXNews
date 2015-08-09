//
//  SXWeatherItemView.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/9.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXWeatherItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *tLbl;
@property (weak, nonatomic) IBOutlet UILabel *weatherLbl;
@property (weak, nonatomic) IBOutlet UILabel *windLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property(nonatomic,copy)NSString *weather;
+ (instancetype)view;
@end
