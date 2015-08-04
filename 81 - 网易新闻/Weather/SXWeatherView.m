//
//  SXWeatherView.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXWeatherView.h"
#import "UIView+Frame.h"

@interface SXWeatherView ()
@property(nonatomic,strong)UIView *bottomView;
@end
@implementation SXWeatherView

- (void)awakeFromNib{
    UIView *bottomView = [[UIView alloc]init];
    self.bottomView = bottomView;
    [self addSubview:bottomView];

    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bottomView.y = 255;
    self.bottomView.height = self.height-self.bottomView.y;
    self.bottomView.width = self.width;
    self.bottomView.x = 0;
    self.bottomView.backgroundColor = [UIColor yellowColor];
    
    [self addBtnWithTitle:@"搜索" icon:@"201" color:[UIColor redColor] index:0];
    
}

+ (instancetype)view{
    return [[NSBundle mainBundle]loadNibNamed:@"SXWeatherView" owner:nil options:nil].firstObject;
}

- (void)addBtnWithTitle:(NSString *)title icon:(NSString *)icon color:(UIColor *)color index:(int)index{
    
    int cols = index%3;
    int rows = index/3;
    CGFloat w = self.width/3;
    CGFloat h = self.bottomView.height/2;
    UIView *itemView = [[UIView alloc]init];
    [self.bottomView addSubview:itemView];
    itemView.x = cols * w;
    itemView.y = rows * h;
    itemView.width = w;
    itemView.height = h;
    
    NSLog(@"%@",NSStringFromCGRect(self.bottomView.frame));
    NSLog(@"%@",NSStringFromCGRect(itemView.frame));
    
    UIButton *btn = [[UIButton alloc]init];
    btn.width = w-40;
    btn.height = btn.width;
    btn.y = 40;
    btn.x = 20;
    
    btn.layer.cornerRadius = btn.width/2;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = color;
    
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:icon];
    img.width = btn.width;
    img.height = img.width;
    img.center = btn.center;
    
    [itemView addSubview:btn];
    [itemView addSubview:img];
    
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = title;
    titleLbl.height = 40;
    titleLbl.width = itemView.width;
    titleLbl.x = 0;
    titleLbl.y = itemView.height - titleLbl.height;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [itemView addSubview:titleLbl];
    itemView.backgroundColor = [UIColor orangeColor];
    
    
}

@end
