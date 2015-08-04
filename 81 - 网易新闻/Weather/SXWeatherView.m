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
    
    [self addBtnWithTitle:@"搜索" icon:@"204" color:[UIColor orangeColor] index:0];
    [self addBtnWithTitle:@"上头条" icon:@"202" color:[UIColor redColor] index:1];
    [self addBtnWithTitle:@"离线" icon:@"203" color:[UIColor colorWithRed:213/255.0 green:22/255.0 blue:71/255.0 alpha:1] index:2];
    [self addBtnWithTitle:@"夜间" icon:@"205" color:[UIColor colorWithRed:58/255.0 green:153/255.0 blue:208/255.0 alpha:1] index:3];
    [self addBtnWithTitle:@"扫一扫" icon:@"204" color:[UIColor colorWithRed:70/255.0 green:95/255.0 blue:176/255.0 alpha:1] index:4];
    [self addBtnWithTitle:@"邀请好友" icon:@"201" color:[UIColor colorWithRed:80/255.0 green:192/255.0 blue:70/255.0 alpha:1] index:5];

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
    
    UIButton *btn = [[UIButton alloc]init];
    btn.width = w-40;
    btn.height = btn.width;
    btn.y = 40;
    if (index > 2) {
        btn.y = 10;
    }
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
    titleLbl.y = btn.y + btn.height;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [itemView addSubview:titleLbl];
    
}

- (void)addAnimate{
    
    [UIView animateWithDuration:0.2 animations:^{
        for (UIView *view in self.bottomView.subviews) {
            for (UIButton *btn in view.subviews) {
                btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            for (UIView *view in self.bottomView.subviews) {
                for (UIButton *btn in view.subviews) {
                    btn.transform = CGAffineTransformIdentity;
                }
            }
        }];
    }];

}

@end
